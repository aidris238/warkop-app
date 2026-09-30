import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import 'database.dart';

class PurchaseLine {
  final int ingredientId;
  final double qty;
  final String satuanBeli;
  final int harga;
  PurchaseLine({
    required this.ingredientId,
    required this.qty,
    required this.satuanBeli,
    required this.harga,
  });
}

class SaleLine {
  final int productId;
  final int qty;
  final List<int> modifierIds;
  SaleLine({required this.productId, required this.qty, this.modifierIds = const []});
}

class DashboardData {
  final int omzet;
  final int hpp;
  final int transaksi;
  final int pengeluaran;
  final List<MapEntry<String, int>> terlaris;
  int get labaKotor => omzet - hpp;
  int get labaBersih => labaKotor - pengeluaran;
  DashboardData({
    required this.omzet,
    required this.hpp,
    required this.transaksi,
    required this.pengeluaran,
    required this.terlaris,
  });
}

String hashPin(String pin) => sha256.convert(utf8.encode('warkop:$pin')).toString();

class WarkopRepository {
  final AppDatabase db;
  WarkopRepository(this.db);

  // ---------- stok ----------
  Future<Map<int, double>> stockMap() async {
    final rows = await db.select(db.stockMovements).get();
    final m = <int, double>{};
    for (final r in rows) {
      m[r.ingredientId] = (m[r.ingredientId] ?? 0) + r.qty;
    }
    return m;
  }

  Future<double> stockOf(int ingredientId) async {
    final rows = await (db.select(db.stockMovements)
          ..where((t) => t.ingredientId.equals(ingredientId)))
        .get();
    var s = 0.0;
    for (final r in rows) {
      s += r.qty;
    }
    return s;
  }

  Future<double> factorOf(int ingredientId, String satuanBeli) async {
    final ing = await (db.select(db.ingredients)
          ..where((t) => t.id.equals(ingredientId)))
        .getSingleOrNull();
    if (ing == null) return 1;
    if (satuanBeli == ing.satuan) return 1;
    final c = await (db.select(db.unitConversions)
          ..where((t) =>
              t.ingredientId.equals(ingredientId) &
              t.satuanBeli.equals(satuanBeli)))
        .getSingleOrNull();
    return c?.faktor ?? 1;
  }

  // ---------- HPP (FR-1.6) ----------
  Future<int> hppOf(int productId) async {
    final p = await (db.select(db.products)
          ..where((t) => t.id.equals(productId)))
        .getSingleOrNull();
    if (p == null) return 0;
    if (p.tipe == 'langsung') {
      if (p.ingredientId == null) return 0;
      final ing = await (db.select(db.ingredients)
            ..where((t) => t.id.equals(p.ingredientId!)))
          .getSingleOrNull();
      return ing?.hargaTerakhir ?? 0;
    }
    final ris = await (db.select(db.recipeItems)
          ..where((t) => t.productId.equals(productId)))
        .get();
    var hpp = 0;
    for (final ri in ris) {
      final ing = await (db.select(db.ingredients)
            ..where((t) => t.id.equals(ri.ingredientId)))
          .getSingleOrNull();
      if (ing != null) hpp += (ing.hargaTerakhir * ri.takaran).round();
    }
    return hpp;
  }

  // ---------- pembelian (FR-2) ----------
  Future<int> recordPurchase({
    required List<PurchaseLine> lines,
    String? supplier,
    String sumberDana = 'laci',
    DateTime? tanggal,
  }) async {
    return db.transaction(() async {
      final total = lines.fold<int>(0, (a, l) => a + l.harga);
      final pid = await db.into(db.purchases).insert(
            PurchasesCompanion.insert(
              tanggal: tanggal ?? DateTime.now(),
              supplier: Value(supplier),
              total: Value(total),
              sumberDana: Value(sumberDana),
            ),
          );
      for (final l in lines) {
        await db.into(db.purchaseItems).insert(
              PurchaseItemsCompanion.insert(
                purchaseId: pid,
                ingredientId: l.ingredientId,
                qty: l.qty,
                satuanBeli: l.satuanBeli,
                harga: l.harga,
              ),
            );
        final f = await factorOf(l.ingredientId, l.satuanBeli);
        final qtyStok = l.qty * f;
        final stokLama = await stockOf(l.ingredientId);
        await db.into(db.stockMovements).insert(
              StockMovementsCompanion.insert(
                ingredientId: l.ingredientId,
                tipe: 'IN',
                qty: qtyStok,
                refTabel: const Value('purchases'),
                refId: Value(pid),
                waktu: DateTime.now(),
              ),
            );
        final perUnit = qtyStok > 0 ? (l.harga / qtyStok).round() : 0;
        final ing = await (db.select(db.ingredients)
              ..where((t) => t.id.equals(l.ingredientId)))
            .getSingle();
        final int rataBaru;
        if (stokLama <= 0 || ing.hargaRata2 <= 0) {
          rataBaru = perUnit;
        } else {
          rataBaru =
              ((ing.hargaRata2 * stokLama + l.harga) / (stokLama + qtyStok))
                  .round();
        }
        await (db.update(db.ingredients)
              ..where((t) => t.id.equals(l.ingredientId)))
            .write(IngredientsCompanion(
                hargaTerakhir: Value(perUnit), hargaRata2: Value(rataBaru)));
      }
      return pid;
    });
  }

  // ---------- penjualan (FR-3) ----------
  Future<int> recordSale({
    required List<SaleLine> lines,
    String metode = 'tunai',
    int? customerId,
    String? meja,
    String status = 'lunas',
  }) async {
    return db.transaction(() async {
      final now = DateTime.now();
      var total = 0;
      final prepared = <Map<String, Object?>>[];
      for (final l in lines) {
        final p = await (db.select(db.products)
              ..where((t) => t.id.equals(l.productId)))
            .getSingle();
        final hpp = await hppOf(p.id);
        var harga = p.hargaJual;
        for (final mid in l.modifierIds) {
          final m = await (db.select(db.modifiers)
                ..where((t) => t.id.equals(mid)))
              .getSingleOrNull();
          if (m != null) harga += m.hargaTambah;
        }
        total += harga * l.qty;
        prepared.add({
          'pid': p.id,
          'harga': harga,
          'hpp': hpp,
          'qty': l.qty,
          'mods': l.modifierIds.join(','),
        });
      }
      final sid = await db.into(db.sales).insert(
            SalesCompanion.insert(
              waktu: now,
              total: Value(total),
              metodeBayar: Value(metode),
              customerId: Value(customerId),
              status: Value(status),
              meja: Value(meja),
            ),
          );
      for (final e in prepared) {
        final mods = e['mods'] as String;
        await db.into(db.saleItems).insert(
              SaleItemsCompanion.insert(
                saleId: sid,
                productId: e['pid'] as int,
                qty: e['qty'] as int,
                harga: e['harga'] as int,
                hpp: Value(e['hpp'] as int),
                modifiers: Value(mods.isEmpty ? null : mods),
              ),
            );
        if (status == 'lunas') {
          await _kurangiStok(e['pid'] as int, e['qty'] as int, sid);
        }
      }
      if (status == 'lunas' && metode == 'kasbon' && customerId != null) {
        final c = await (db.select(db.customers)
              ..where((t) => t.id.equals(customerId)))
            .getSingle();
        await (db.update(db.customers)
              ..where((t) => t.id.equals(customerId)))
            .write(
                CustomersCompanion(saldoKasbon: Value(c.saldoKasbon + total)));
      }
      return sid;
    });
  }

  Future<void> _kurangiStok(int productId, int qty, int saleId) async {
    final p = await (db.select(db.products)
          ..where((t) => t.id.equals(productId)))
        .getSingle();
    if (p.tipe == 'langsung' && p.ingredientId != null) {
      await db.into(db.stockMovements).insert(
            StockMovementsCompanion.insert(
              ingredientId: p.ingredientId!,
              tipe: 'OUT',
              qty: -qty.toDouble(),
              refTabel: const Value('sales'),
              refId: Value(saleId),
              waktu: DateTime.now(),
            ),
          );
      return;
    }
    final ris = await (db.select(db.recipeItems)
          ..where((t) => t.productId.equals(productId)))
        .get();
    for (final ri in ris) {
      await db.into(db.stockMovements).insert(
            StockMovementsCompanion.insert(
              ingredientId: ri.ingredientId,
              tipe: 'OUT',
              qty: -(ri.takaran * qty),
              refTabel: const Value('sales'),
              refId: Value(saleId),
              waktu: DateTime.now(),
            ),
          );
    }
  }

  Future<void> lunaskanHold(int saleId) async {
    await db.transaction(() async {
      final s = await (db.select(db.sales)
            ..where((t) => t.id.equals(saleId)))
          .getSingle();
      if (s.status != 'hold') return;
      final items = await (db.select(db.saleItems)
            ..where((t) => t.saleId.equals(saleId)))
          .get();
      for (final it in items) {
        await _kurangiStok(it.productId, it.qty, saleId);
      }
      await (db.update(db.sales)..where((t) => t.id.equals(saleId)))
          .write(const SalesCompanion(status: Value('lunas')));
      if (s.metodeBayar == 'kasbon' && s.customerId != null) {
        final c = await (db.select(db.customers)
              ..where((t) => t.id.equals(s.customerId!)))
            .getSingle();
        await (db.update(db.customers)
              ..where((t) => t.id.equals(s.customerId!)))
            .write(
                CustomersCompanion(saldoKasbon: Value(c.saldoKasbon + s.total)));
      }
    });
  }

  Future<void> voidSale(int saleId, String alasan) async {
    await db.transaction(() async {
      final s = await (db.select(db.sales)
            ..where((t) => t.id.equals(saleId)))
          .getSingle();
      if (s.status == 'void') return;
      if (s.status == 'lunas') {
        final items = await (db.select(db.saleItems)
              ..where((t) => t.saleId.equals(saleId)))
            .get();
        for (final it in items) {
          final p = await (db.select(db.products)
                ..where((t) => t.id.equals(it.productId)))
              .getSingle();
          if (p.tipe == 'langsung' && p.ingredientId != null) {
            await db.into(db.stockMovements).insert(
                  StockMovementsCompanion.insert(
                    ingredientId: p.ingredientId!,
                    tipe: 'IN',
                    qty: it.qty.toDouble(),
                    refTabel: const Value('sales_void'),
                    refId: Value(saleId),
                    alasan: Value(alasan),
                    waktu: DateTime.now(),
                  ),
                );
          } else {
            final ris = await (db.select(db.recipeItems)
                  ..where((t) => t.productId.equals(p.id)))
                .get();
            for (final ri in ris) {
              await db.into(db.stockMovements).insert(
                    StockMovementsCompanion.insert(
                      ingredientId: ri.ingredientId,
                      tipe: 'IN',
                      qty: ri.takaran * it.qty,
                      refTabel: const Value('sales_void'),
                      refId: Value(saleId),
                      alasan: Value(alasan),
                      waktu: DateTime.now(),
                    ),
                  );
            }
          }
        }
        if (s.metodeBayar == 'kasbon' && s.customerId != null) {
          final c = await (db.select(db.customers)
                ..where((t) => t.id.equals(s.customerId!)))
              .getSingle();
          await (db.update(db.customers)
                ..where((t) => t.id.equals(s.customerId!)))
              .write(CustomersCompanion(
                  saldoKasbon:
                      Value((c.saldoKasbon - s.total).clamp(0, 1 << 60))));
        }
      }
      await (db.update(db.sales)..where((t) => t.id.equals(saleId))).write(
          SalesCompanion(
              status: const Value('void'),
              catatan: Value('VOID: $alasan')));
    });
  }

  // ---------- penyesuaian stok (FR-4.4) ----------
  Future<void> adjustStock(
      int ingredientId, double selisih, String alasan) async {
    await db.into(db.stockMovements).insert(
          StockMovementsCompanion.insert(
            ingredientId: ingredientId,
            tipe: 'ADJ',
            qty: selisih,
            alasan: Value(alasan),
            waktu: DateTime.now(),
          ),
        );
  }

  // ---------- dashboard & laporan (FR-8) ----------
  Future<DashboardData> dashboard(DateTime start, DateTime end) async {
    // Semua query di level DB; join sekali jalan, tanpa N+1.
    final sales = await (db.select(db.sales)
          ..where((t) =>
              t.status.equals('lunas') &
              t.waktu.isBiggerOrEqualValue(start) &
              t.waktu.isSmallerThanValue(end)))
        .get();
    final ids = sales.map((s) => s.id).toList();
    final items = ids.isEmpty
        ? <SaleItem>[]
        : await (db.select(db.saleItems)
              ..where((t) => t.saleId.isIn(ids)))
            .get();
    final prods = await db.select(db.products).get();
    final nama = {for (final p in prods) p.id: p.nama};
    var omzet = 0;
    var hpp = 0;
    final perMenu = <String, int>{};
    for (final s in sales) {
      omzet += s.total;
    }
    for (final it in items) {
      hpp += it.hpp * it.qty;
      final n = nama[it.productId];
      if (n != null) perMenu[n] = (perMenu[n] ?? 0) + it.qty;
    }
    final exps = await (db.select(db.expenses)
          ..where((t) =>
              t.tanggal.isBiggerOrEqualValue(start) &
              t.tanggal.isSmallerThanValue(end)))
        .get();
    var pengeluaran = 0;
    for (final e in exps) {
      pengeluaran += e.nominal;
    }
    final terlaris = perMenu.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return DashboardData(
      omzet: omzet,
      hpp: hpp,
      transaksi: sales.length,
      pengeluaran: pengeluaran,
      terlaris: terlaris.take(5).toList(),
    );
  }

  Future<int> nilaiStok() async {
    final ings = await db.select(db.ingredients).get();
    final sm = await stockMap();
    var total = 0;
    for (final ing in ings) {
      final s = sm[ing.id] ?? 0;
      if (s > 0) total += (s * ing.hargaRata2).round();
    }
    return total;
  }

  // ---------- kasbon (FR-7) ----------
  Future<void> bayarKasbon(int customerId, int nominal) async {
    await db.transaction(() async {
      await db.into(db.debtPayments).insert(DebtPaymentsCompanion.insert(
          customerId: customerId,
          tanggal: DateTime.now(),
          nominal: nominal));
      final c = await (db.select(db.customers)
            ..where((t) => t.id.equals(customerId)))
          .getSingle();
      await (db.update(db.customers)
            ..where((t) => t.id.equals(customerId)))
          .write(CustomersCompanion(
              saldoKasbon: Value((c.saldoKasbon - nominal).clamp(0, 1 << 60))));
    });
  }

  // ---------- belanja (FR-5) ----------
  Future<List<Map<String, Object?>>> saranBelanja() async {
    final ings = await (db.select(db.ingredients)
          ..where((t) => t.aktif.equals(true)))
        .get();
    final sm = await stockMap();
    final out = <Map<String, Object?>>[];
    for (final ing in ings) {
      final s = sm[ing.id] ?? 0;
      if (s < ing.stokMin) {
        out.add({
          'ingredient': ing,
          'stok': s,
          'qtySaran': (ing.stokTarget - s).clamp(0, double.infinity),
        });
      }
    }
    return out;
  }

  // ---------- PIN ----------
  Future<String?> pinHash() async {
    final row = await (db.select(db.appSettings)
          ..where((t) => t.kunci.equals('pin_hash')))
        .getSingleOrNull();
    return row?.nilai;
  }

  Future<void> setPin(String pin) async {
    await db
        .into(db.appSettings)
        .insertOnConflictUpdate(AppSettingsCompanion.insert(
          kunci: 'pin_hash',
          nilai: Value(hashPin(pin)),
        ));
  }

  Future<bool> verifyPin(String pin) async {
    final h = await pinHash();
    if (h == null) return true;
    return h == hashPin(pin);
  }
}
