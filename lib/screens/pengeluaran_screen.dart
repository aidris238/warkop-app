import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';

const _kategoris = ['Listrik', 'Air', 'Sewa', 'Gaji', 'Iuran', 'Perbaikan', 'Lainnya'];

class PengeluaranScreen extends ConsumerStatefulWidget {
  const PengeluaranScreen({super.key});
  @override
  ConsumerState<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends ConsumerState<PengeluaranScreen> {
  String _kat = 'Listrik';
  String _dana = 'laci';
  bool _rutin = false;
  final _nomC = TextEditingController();
  final _catC = TextEditingController();
  int _nonce = 0;

  Future<void> _simpan() async {
    final db = ref.read(dbProvider);
    final nom = int.tryParse(_nomC.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (nom <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nominal harus > 0')));
      return;
    }
    await db.into(db.expenses).insert(ExpensesCompanion.insert(
          tanggal: DateTime.now(),
          kategori: _kat,
          nominal: nom,
          sumberDana: Value(_dana),
          catatan: Value(_catC.text.trim().isEmpty ? null : _catC.text.trim()),
          rutin: Value(_rutin),
        ));
    _nomC.clear();
    _catC.clear();
    setState(() => _nonce++);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengeluaran tersimpan')));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    final now = DateTime.now();
    final awal = DateTime(now.year, now.month, 1);
    return Scaffold(
      appBar: AppBar(title: const Text('Pengeluaran')),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: (db.select(db.expenses)..orderBy([(t) => OrderingTerm.desc(t.tanggal)])..limit(100)).get(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final semua = snap.data!;
          final bulanIni = semua.where((e) => !e.tanggal.isBefore(awal)).toList();
          final total = bulanIni.fold(0, (a, e) => a + e.nominal);
          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Text('Catat pengeluaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _kat,
                decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                items: _kategoris.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _kat = v ?? 'Listrik'),
              ),
              const SizedBox(height: 8),
              TextField(controller: _nomC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nominal', border: OutlineInputBorder(), prefixText: 'Rp ')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _dana,
                      decoration: const InputDecoration(labelText: 'Sumber dana', border: OutlineInputBorder()),
                      items: const [DropdownMenuItem(value: 'laci', child: Text('Laci')), DropdownMenuItem(value: 'pribadi', child: Text('Pribadi'))],
                      onChanged: (v) => setState(() => _dana = v ?? 'laci'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Rutin'),
                      value: _rutin,
                      onChanged: (v) => setState(() => _rutin = v ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              TextField(controller: _catC, decoration: const InputDecoration(labelText: 'Catatan (opsional)', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                onPressed: _simpan,
                child: const Text('Simpan'),
              ),
              const SizedBox(height: 16),
              Text('Bulan ini: ${rupiah(total)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              for (final e in bulanIni)
                Card(
                  child: ListTile(
                    title: Text('${e.kategori} • ${rupiah(e.nominal)}'),
                    subtitle: Text('${tgl(e.tanggal)} • ${e.catatan ?? '-'}'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
