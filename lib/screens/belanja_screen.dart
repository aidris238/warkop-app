import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import '../utils/format.dart';

class _Baris {
  final Ingredient ing;
  double qty;
  int harga;
  bool centang;
  _Baris({required this.ing, required this.qty, required this.harga, this.centang = true});
}

class BelanjaScreen extends ConsumerStatefulWidget {
  const BelanjaScreen({super.key});
  @override
  ConsumerState<BelanjaScreen> createState() => _BelanjaScreenState();
}

class _BelanjaScreenState extends ConsumerState<BelanjaScreen> {
  List<_Baris>? _rows;
  final Set<int> _manual = {};

  Future<void> _muat() async {
    final repo = ref.read(repoProvider);
    final saran = await repo.saranBelanja();
    _rows = saran.map((e) {
      final ing = e['ingredient'] as Ingredient;
      final qs = (e['qtySaran'] as double);
      return _Baris(ing: ing, qty: qs <= 0 ? 1 : qs, harga: (qs * ing.hargaTerakhir).round());
    }).toList();
    setState(() {});
  }

  Future<void> _tambahManual() async {
    final db = ref.read(dbProvider);
    final ings = await (db.select(db.ingredients)..where((t) => t.aktif.equals(true))).get();
    final tersisa = ings.where((e) => !_rows!.any((r) => r.ing.id == e.id) && !_manual.contains(e.id)).toList();
    if (!mounted || tersisa.isEmpty) return;
    Ingredient? pilih = tersisa.first;
    final qtyC = TextEditingController(text: '1');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: const Text('Tambah item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Ingredient>(
                value: pilih,
                items: tersisa.map((e) => DropdownMenuItem(value: e, child: Text(e.nama))).toList(),
                onChanged: (v) => setS(() => pilih = v),
                decoration: const InputDecoration(labelText: 'Bahan', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              TextField(controller: qtyC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Qty', border: OutlineInputBorder())),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Tambah')),
          ],
        ),
      ),
    );
    if (ok == true && pilih != null) {
      final q = double.tryParse(qtyC.text.replaceAll(',', '.')) ?? 1;
      setState(() {
        _rows!.add(_Baris(ing: pilih!, qty: q, harga: (q * pilih!.hargaTerakhir).round()));
        _manual.add(pilih!.id);
      });
    }
  }

  Future<void> _simpan() async {
    final repo = ref.read(repoProvider);
    final dipilih = _rows!.where((r) => r.centang).toList();
    if (dipilih.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Centang dulu item yang dibeli')));
      return;
    }
    await repo.recordPurchase(
      lines: dipilih
          .map((r) => PurchaseLine(ingredientId: r.ing.id, qty: r.qty, satuanBeli: r.ing.satuan, harga: r.harga))
          .toList(),
      supplier: 'Belanja pasar',
    );
    setState(() => _rows = null);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tersimpan jadi barang masuk, stok & HPP ter-update')));
  }

  void _share() {
    final dipilih = _rows!.where((r) => r.centang).toList();
    final buf = StringBuffer('Daftar belanja warkop:\n');
    for (final r in dipilih) {
      buf.writeln('- ${r.ing.nama}: ${qtyStr(r.qty, r.ing.satuan)} (~${rupiah(r.harga)})');
    }
    Share.share(buf.toString());
  }

  @override
  void initState() {
    super.initState();
    _muat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja 🛒'),
        actions: [
          IconButton(icon: const Icon(Icons.share), tooltip: 'Kirim ke WhatsApp', onPressed: _rows == null ? null : _share),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _muat),
        ],
      ),
      body: _rows == null
          ? const Center(child: CircularProgressIndicator())
          : _rows!.isEmpty
              ? const Center(child: Text('Semua stok aman, tidak ada yang perlu dibeli 🎉'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _rows!.length,
                        itemBuilder: (_, i) {
                          final r = _rows![i];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Checkbox(value: r.centang, onChanged: (v) => setState(() => r.centang = v ?? false)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(r.ing.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('Saran: ${qtyStr(r.qty, r.ing.satuan)}'),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                decoration: const InputDecoration(labelText: 'Qty beli', isDense: true),
                                                controller: TextEditingController(text: r.qty.toString())
                                                  ..selection = TextSelection.collapsed(offset: r.qty.toString().length),
                                                onChanged: (v) => r.qty = double.tryParse(v.replaceAll(',', '.')) ?? r.qty,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                decoration: const InputDecoration(labelText: 'Harga (Rp)', isDense: true),
                                                controller: TextEditingController(text: r.harga.toString())
                                                  ..selection = TextSelection.collapsed(offset: r.harga.toString().length),
                                                onChanged: (v) => r.harga = int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) ?? r.harga,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Estimasi: ${rupiah(_rows!.where((r) => r.centang).fold(0, (a, r) => a + r.harga))}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(child: OutlinedButton.icon(onPressed: _tambahManual, icon: const Icon(Icons.add), label: const Text('Item manual'))),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FilledButton(
                                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                                  onPressed: _simpan,
                                  child: const Text('Simpan jadi barang masuk'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
