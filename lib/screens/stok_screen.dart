import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';

class StokScreen extends ConsumerStatefulWidget {
  const StokScreen({super.key});
  @override
  ConsumerState<StokScreen> createState() => _StokScreenState();
}

class _StokScreenState extends ConsumerState<StokScreen> {
  int _nonce = 0;

  Future<void> _detail(Ingredient ing, double stok) async {
    final db = ref.read(dbProvider);
    final riwayat = await (db.select(db.stockMovements)
          ..where((t) => t.ingredientId.equals(ing.id))
          ..orderBy([(t) => OrderingTerm.desc(t.waktu)])
          ..limit(50))
        .get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ing.nama),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Stok kini: ${qtyStr(stok, ing.satuan)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Divider(),
              const Text('Kartu stok (50 terakhir):', style: TextStyle(fontWeight: FontWeight.bold)),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: riwayat.length,
                  itemBuilder: (_, i) {
                    final r = riwayat[i];
                    final plus = r.qty >= 0;
                    return ListTile(
                      dense: true,
                      leading: Icon(plus ? Icons.arrow_downward : Icons.arrow_upward,
                          color: plus ? Colors.green : Colors.red),
                      title: Text('${plus ? '+' : ''}${qtyStr(r.qty, ing.satuan)} • ${r.tipe}'),
                      subtitle: Text('${r.alasan ?? r.refTabel ?? '-'} • ${tglJam(r.waktu)}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _penyesuaian(ing);
            },
            child: const Text('Penyesuaian'),
          ),
        ],
      ),
    );
  }

  Future<void> _penyesuaian(Ingredient ing) async {
    final repo = ref.read(repoProvider);
    final qtyC = TextEditingController();
    final alasanC = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Penyesuaian • ${ing.nama}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: qtyC,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              decoration: InputDecoration(
                  labelText: 'Selisih (+/- dalam ${ing.satuan})', border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: alasanC,
              decoration: const InputDecoration(
                  labelText: 'Alasan (rusak/tumpah/koreksi...)',
                  border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
        ],
      ),
    );
    if (ok != true) return;
    final selisih = double.tryParse(qtyC.text.replaceAll(',', '.'));
    if (selisih == null || selisih == 0 || alasanC.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Selisih dan alasan wajib diisi')));
      }
      return;
    }
    await repo.adjustStock(ing.id, selisih, alasanC.text.trim());
    setState(() => _nonce++);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Penyesuaian tersimpan')));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    final repo = ref.watch(repoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok'),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () => setState(() => _nonce++))],
      ),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: Future.wait([
          (db.select(db.ingredients)..where((t) => t.aktif.equals(true))..orderBy([(t) => OrderingTerm(expression: t.nama)])).get(),
          repo.stockMap(),
        ]),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final ings = snap.data![0] as List<Ingredient>;
          final sm = snap.data![1] as Map<int, double>;
          if (ings.isEmpty) return const Center(child: Text('Belum ada bahan. Tambah di menu Master.'));
          return ListView.builder(
            itemCount: ings.length,
            itemBuilder: (_, i) {
              final ing = ings[i];
              final s = sm[ing.id] ?? 0;
              final Color warna;
              final String status;
              if (s <= 0) {
                warna = Colors.red;
                status = 'Habis';
              } else if (s < ing.stokMin) {
                warna = Colors.orange;
                status = 'Menipis';
              } else {
                warna = Colors.green;
                status = 'Aman';
              }
              return Card(
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: warna.withValues(alpha: 0.2), child: Icon(Icons.inventory, color: warna)),
                  title: Text(ing.nama),
                  subtitle: Text('${qtyStr(s, ing.satuan)} • min ${qtyStr(ing.stokMin, ing.satuan)}'),
                  trailing: Chip(label: Text(status), backgroundColor: warna.withValues(alpha: 0.15)),
                  onTap: () => _detail(ing, s),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
