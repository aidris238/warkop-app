import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import '../utils/format.dart';
import '../widgets/logo_header.dart';

class _BarisMasuk {
  int? ingredientId;
  String satuan;
  double qty;
  int harga;
  _BarisMasuk({this.ingredientId, this.satuan = 'pcs', this.qty = 1, this.harga = 0});
}

class MasukScreen extends ConsumerStatefulWidget {
  const MasukScreen({super.key});
  @override
  ConsumerState<MasukScreen> createState() => _MasukScreenState();
}

class _MasukScreenState extends ConsumerState<MasukScreen> {
  final List<_BarisMasuk> _baris = [_BarisMasuk()];
  final _supplierC = TextEditingController();
  String _dana = 'laci';
  int _nonce = 0;

  Future<void> _simpan(List<Ingredient> ings) async {
    final repo = ref.read(repoProvider);
    final lines = <PurchaseLine>[];
    for (final b in _baris) {
      if (b.ingredientId == null || b.qty <= 0) continue;
      lines.add(PurchaseLine(ingredientId: b.ingredientId!, qty: b.qty, satuanBeli: b.satuan, harga: b.harga));
    }
    if (lines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Isi dulu minimal 1 baris')));
      return;
    }
    await repo.recordPurchase(
      lines: lines,
      supplier: _supplierC.text.trim().isEmpty ? null : _supplierC.text.trim(),
      sumberDana: _dana,
    );
    setState(() {
      _baris.clear();
      _baris.add(_BarisMasuk());
      _supplierC.clear();
      _nonce++;
    });
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang masuk tersimpan, stok & HPP ter-update')));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: barWarkop('Kulakan'),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: Future.wait([
          (db.select(db.ingredients)..where((t) => t.aktif.equals(true))..orderBy([(t) => OrderingTerm(expression: t.nama)])).get(),
          (db.select(db.purchases)..orderBy([(t) => OrderingTerm.desc(t.tanggal)])..limit(20)).get(),
        ]),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final ings = snap.data![0] as List<Ingredient>;
          final riw = snap.data![1] as List<Purchase>;
          final byId = {for (final e in ings) e.id: e};
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Text('Catat pembelian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              for (var k = 0; k < _baris.length; k++)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        DropdownButtonFormField<int>(
                          value: _baris[k].ingredientId,
                          decoration: const InputDecoration(labelText: 'Bahan', border: OutlineInputBorder()),
                          items: ings.map((e) => DropdownMenuItem(value: e.id, child: Text(e.nama))).toList(),
                          onChanged: (v) => setState(() {
                            _baris[k].ingredientId = v;
                            if (v != null) _baris[k].satuan = byId[v]!.satuan;
                          }),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                decoration: const InputDecoration(labelText: 'Qty', border: OutlineInputBorder()),
                                onChanged: (v) => _baris[k].qty = double.tryParse(v.replaceAll(',', '.')) ?? _baris[k].qty,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(labelText: 'Satuan beli', border: OutlineInputBorder()),
                                controller: TextEditingController(text: _baris[k].satuan)
                                  ..selection = TextSelection.collapsed(offset: _baris[k].satuan.length),
                                onChanged: (v) => _baris[k].satuan = v,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(labelText: 'Harga total', border: OutlineInputBorder(), prefixText: 'Rp'),
                                onChanged: (v) => _baris[k].harga = int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              OutlinedButton.icon(onPressed: () => setState(() => _baris.add(_BarisMasuk())), icon: const Icon(Icons.add), label: const Text('Tambah baris')),
              const SizedBox(height: 8),
              TextField(controller: _supplierC, decoration: const InputDecoration(labelText: 'Supplier / tempat beli (opsional)', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _dana,
                decoration: const InputDecoration(labelText: 'Sumber dana', border: OutlineInputBorder()),
                items: const [DropdownMenuItem(value: 'laci', child: Text('Uang laci')), DropdownMenuItem(value: 'pribadi', child: Text('Uang pribadi owner'))],
                onChanged: (v) => setState(() => _dana = v ?? 'laci'),
              ),
              const SizedBox(height: 8),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                onPressed: () => _simpan(ings),
                child: const Text('Simpan'),
              ),
              const SizedBox(height: 16),
              const Text('Riwayat pembelian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              for (final p in riw)
                Card(
                  child: ListTile(
                    title: Text(p.supplier ?? 'Tanpa supplier'),
                    subtitle: Text(tglJam(p.tanggal)),
                    trailing: Text(rupiah(p.total), style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
