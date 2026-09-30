import 'package:drift/drift.dart';

import 'database.dart';

/// Isi awal: contoh bahan + menu warkop supaya app langsung bisa dipakai.
/// Hanya jalan sekali (kalau tabel bahan masih kosong).
Future<void> seedAwal(AppDatabase db) async {
  final ada =
      await (db.select(db.ingredients)..limit(1)).getSingleOrNull();
  if (ada != null) return;

  final bahan = <Map<String, Object>>[
    {'nama': 'Kopi bubuk', 'kategori': 'Minuman', 'satuan': 'gram', 'min': 500.0, 'target': 2000.0, 'harga': 120},
    {'nama': 'Gula pasir', 'kategori': 'Minuman', 'satuan': 'gram', 'min': 1000.0, 'target': 5000.0, 'harga': 18},
    {'nama': 'SKM', 'kategori': 'Minuman', 'satuan': 'ml', 'min': 500.0, 'target': 2000.0, 'harga': 40},
    {'nama': 'Teh tubruk', 'kategori': 'Minuman', 'satuan': 'gram', 'min': 200.0, 'target': 1000.0, 'harga': 90},
    {'nama': 'Mie instan', 'kategori': 'Makanan', 'satuan': 'pcs', 'min': 10.0, 'target': 40.0, 'harga': 3500},
    {'nama': 'Telur', 'kategori': 'Makanan', 'satuan': 'pcs', 'min': 10.0, 'target': 30.0, 'harga': 2000},
    {'nama': 'Gelas plastik', 'kategori': 'Kemasan', 'satuan': 'pcs', 'min': 20.0, 'target': 100.0, 'harga': 400},
    {'nama': 'Gas LPG', 'kategori': 'Operasional', 'satuan': 'tabung', 'min': 1.0, 'target': 2.0, 'harga': 20000},
    {'nama': 'Rokok ketengan', 'kategori': 'Rokok', 'satuan': 'batang', 'min': 20.0, 'target': 100.0, 'harga': 2000},
  ];
  final ids = <String, int>{};
  for (final b in bahan) {
    final id = await db.into(db.ingredients).insert(IngredientsCompanion.insert(
          nama: b['nama'] as String,
          kategori: Value(b['kategori'] as String),
          satuan: Value(b['satuan'] as String),
          stokMin: Value(b['min'] as double),
          stokTarget: Value(b['target'] as double),
          hargaTerakhir: Value(b['harga'] as int),
          hargaRata2: Value(b['harga'] as int),
        ));
    ids[b['nama'] as String] = id;
  }
  // Konversi satuan beli (FR-1.2)
  await db.into(db.unitConversions).insert(UnitConversionsCompanion.insert(
      ingredientId: ids['Gula pasir']!, satuanBeli: 'kg', faktor: 1000.0));
  await db.into(db.unitConversions).insert(UnitConversionsCompanion.insert(
      ingredientId: ids['Kopi bubuk']!,
      satuanBeli: 'renteng',
      faktor: 250.0));
  await db.into(db.unitConversions).insert(UnitConversionsCompanion.insert(
      ingredientId: ids['Rokok ketengan']!,
      satuanBeli: 'bungkus',
      faktor: 16.0));

  // Stok awal supaya kasir langsung bisa dipakai
  Future<void> stokAwal(String nama, double qty) => db
      .into(db.stockMovements)
      .insert(StockMovementsCompanion.insert(
        ingredientId: ids[nama]!,
        tipe: 'IN',
        qty: qty,
        alasan: const Value('Stok awal'),
        waktu: DateTime.now(),
      ));
  await stokAwal('Kopi bubuk', 2000);
  await stokAwal('Gula pasir', 5000);
  await stokAwal('SKM', 2000);
  await stokAwal('Teh tubruk', 1000);
  await stokAwal('Mie instan', 40);
  await stokAwal('Telur', 30);
  await stokAwal('Gelas plastik', 100);
  await stokAwal('Gas LPG', 2);
  await stokAwal('Rokok ketengan', 100);

  Future<int> menu(String nama, String kategori, int harga,
      [Map<String, double> resep = const {}]) async {
    final pid = await db.into(db.products).insert(ProductsCompanion.insert(
          nama: nama,
          kategori: Value(kategori),
          hargaJual: Value(harga),
        ));
    for (final e in resep.entries) {
      await db.into(db.recipeItems).insert(RecipeItemsCompanion.insert(
            productId: pid,
            ingredientId: ids[e.key]!,
            takaran: e.value,
          ));
    }
    return pid;
  }

  await menu('Kopi hitam', 'Minuman panas', 5000,
      {'Kopi bubuk': 10, 'Gula pasir': 10, 'Gelas plastik': 1});
  await menu('Kopi susu', 'Minuman panas', 8000,
      {'Kopi bubuk': 10, 'SKM': 20, 'Gula pasir': 10, 'Gelas plastik': 1});
  await menu('Es teh manis', 'Minuman dingin', 4000,
      {'Teh tubruk': 5, 'Gula pasir': 15, 'Gelas plastik': 1});
  await menu('Indomie telor', 'Makanan', 12000, {'Mie instan': 1, 'Telur': 1});
  // Jual langsung 1:1 (FR-1.5)
  final rokokId = await db.into(db.products).insert(ProductsCompanion.insert(
        nama: 'Rokok ketengan',
        kategori: Value('Rokok'),
        hargaJual: Value(2500),
        tipe: Value('langsung'),
        ingredientId: Value(ids['Rokok ketengan']!),
      ));
}
