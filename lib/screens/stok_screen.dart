import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';
import '../widgets/logo_header.dart';

// Stok: yang menipis di atas, aman di bawah. Ketuk = riwayat + betulkan.
class StokScreen extends ConsumerStatefulWidget {
  const StokScreen({super.key});
  @override
  ConsumerState<StokScreen> createState() => _StokScreenState();
}

class _StokScreenState extends ConsumerState<StokScreen> {
  int _nonce = 0;

  Future<void> _detail(Ingredient ing, double stok) async {
    final db = ref.read(dbProvider);
    final repo = ref.read(repoProvider);
    final riwayat = await (db.select(db.stockMovements)
          ..where((t) => t.ingredientId.equals(ing.id))
          ..orderBy([(t) => OrderingTerm.desc(t.waktu)])
          ..limit(30))
        .get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ing.nama),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(ctx)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sisa sekarang',
                          style: TextStyle(fontSize: 13)),
                      Text(qtyStr(stok, ing.satuan),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Keluar-masuk terakhir:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                for (final r in riwayat)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      r.qty >= 0
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: r.qty >= 0 ? Colors.green : Colors.red,
                    ),
                    title: Text(
                        '${r.qty >= 0 ? '+' : ''}${qtyStr(r.qty, ing.satuan)}'),
                    subtitle: Text(
                        '${_artiTipe(r.tipe)} • ${r.alasan ?? ''} • ${tglJam(r.waktu)}'),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Tutup')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _betulkan(ing, stok);
            },
            child: const Text('Betulkan stok'),
          ),
        ],
      ),
    );
  }

  String _artiTipe(String t) => switch (t) {
        'IN' => 'Masuk',
        'OUT' => 'Terjual',
        'ADJ' => 'Koreksi',
        'OPNAME' => 'Opname',
        'WASTE' => 'Rusak/buang',
        _ => t,
      };

  Future<void> _betulkan(Ingredient ing, double stokKini) async {
    final repo = ref.read(repoProvider);
    final nyataC = TextEditingController();
    String alasan = 'Koreksi';
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text('Betulkan • ${ing.nama}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tercatat: ${qtyStr(stokKini, ing.satuan)}'),
              const SizedBox(height: 8),
              TextField(
                controller: nyataC,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Hitung aslinya ada berapa?',
                  border: const OutlineInputBorder(),
                  suffixText: ing.satuan,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Kenapa beda?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              for (final a in [
                'Koreksi',
                'Tumpah / basi',
                'Dipakai sendiri',
                'Salah takar kemarin'
              ])
                RadioListTile<String>(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(a),
                  value: a,
                  groupValue: alasan,
                  onChanged: (v) => setS(() => alasan = v ?? 'Koreksi'),
                ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Batal')),
            FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Simpan')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    final nyata =
        double.tryParse(nyataC.text.replaceAll(',', '.'));
    if (nyata == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Isi dulu jumlah aslinya (angka)')));
      }
      return;
    }
    await repo.adjustStock(ing.id, nyata - stokKini, alasan);
    setState(() => _nonce++);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stok dibetulkan ✅')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    final repo = ref.watch(repoProvider);
    return Scaffold(
      appBar: barWarkop(
        'Stok',
        aksi: [
          IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Muat ulang',
              onPressed: () => setState(() => _nonce++))
        ],
      ),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: Future.wait([
          (db.select(db.ingredients)
                ..where((t) => t.aktif.equals(true))
                ..orderBy([(t) => OrderingTerm(expression: t.nama)]))
              .get(),
          repo.stockMap(),
        ]),
        builder: (ctx, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final ings = snap.data![0] as List<Ingredient>;
          final sm = snap.data![1] as Map<int, double>;
          if (ings.isEmpty) {
            return const Center(
                child: Text('Belum ada bahan.\nTambah di Lainnya → Kelola.'));
          }
          final kritis = <Map<String, Object>>[];
          final aman = <Map<String, Object>>[];
          for (final ing in ings) {
            final s = sm[ing.id] ?? 0;
            final e = {'ing': ing, 'stok': s};
            if (s < ing.stokMin) {
              kritis.add(e);
            } else {
              aman.add(e);
            }
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              if (kritis.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(
                    '⚠️ ${kritis.length} bahan mau habis — waktunya belanja!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800,
                        fontSize: 15),
                  ),
                ),
                const SizedBox(height: 8),
                for (final e in kritis)
                  _baris(e['ing'] as Ingredient, e['stok'] as double),
                const SizedBox(height: 12),
              ] else
                const Card(
                  child: ListTile(
                    leading:
                        Text('✅', style: TextStyle(fontSize: 30)),
                    title: Text('Semua stok aman',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Tidak ada yang perlu dibeli'),
                  ),
                ),
              if (aman.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('Stok aman',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                for (final e in aman)
                  _baris(e['ing'] as Ingredient, e['stok'] as double),
              ],
              const SizedBox(height: 8),
              const Text(
                'Ketuk salah satu untuk lihat riwayat / betulkan jumlah.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _baris(Ingredient ing, double s) {
    final kritis = s < ing.stokMin;
    final habis = s <= 0;
    final warna = habis
        ? Colors.red
        : kritis
            ? Colors.orange.shade800
            : Colors.green;
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: FotoItem(path: ing.fotoPath, emoji: habis ? '🔴' : kritis ? '🟡' : '🟢'),
        title: Text(ing.nama,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
          '${qtyStr(s, ing.satuan)}${kritis ? ' • perlu dibeli!' : ''}',
          style: TextStyle(
              color: kritis ? Colors.red.shade700 : null,
              fontWeight: kritis ? FontWeight.bold : null),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(habis ? 'HABIS' : kritis ? 'MENIPIS' : 'Aman',
                style: TextStyle(
                    color: warna,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
          ],
        ),
        onTap: () => _detail(ing, s),
      ),
    );
  }
}
