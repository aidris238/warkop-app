import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';
import '../widgets/logo_header.dart';

// Bon: siapa yang utang, berapa, lunasin, ingatkan WA.
class KasbonScreen extends ConsumerStatefulWidget {
  const KasbonScreen({super.key});
  @override
  ConsumerState<KasbonScreen> createState() => _KasbonState();
}

class _KasbonState extends ConsumerState<KasbonScreen> {
  int _nonce = 0;

  Future<void> _tambah() async {
    final db = ref.read(dbProvider);
    final namaC = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah nama yang boleh bon'),
        content: TextField(
          controller: namaC,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Nama, mis. Bang Udin',
            border: OutlineInputBorder(),
          ),
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
    );
    if (ok != true || namaC.text.trim().isEmpty) return;
    await db.into(db.customers).insert(
        CustomersCompanion.insert(nama: namaC.text.trim()));
    setState(() => _nonce++);
  }

  Future<void> _detail(Customer c) async {
    final db = ref.read(dbProvider);
    final sales = await (db.select(db.sales)
          ..where((t) =>
              t.customerId.equals(c.id) &
              t.metodeBayar.equals('kasbon') &
              t.status.equals('lunas'))
          ..orderBy([(t) => OrderingTerm.desc(t.waktu)]))
        .get();
    final pays = await (db.select(db.debtPayments)
          ..where((t) => t.customerId.equals(c.id))
          ..orderBy([(t) => OrderingTerm.desc(t.tanggal)]))
        .get();
    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('📒 ${c.nama}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                c.saldoKasbon > 0
                    ? 'Masih utang ${rupiah(c.saldoKasbon)}'
                    : 'Lunas, tidak ada utang ✅',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: c.saldoKasbon > 0 ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              if (sales.isNotEmpty) ...[
                const Text('Jajan yang belum dibayar:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                for (final s in sales)
                  Text('• ${tgl(s.waktu)} — ${rupiah(s.total)}'),
                const SizedBox(height: 8),
              ],
              if (pays.isNotEmpty) ...[
                const Text('Yang sudah dibayar:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                for (final p in pays)
                  Text('• ${tgl(p.tanggal)} — ${rupiah(p.nominal)}'),
              ],
              const SizedBox(height: 16),
              if (c.saldoKasbon > 0)
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _bayar(c);
                  },
                  icon: const Icon(Icons.payments),
                  label: const Text('Catat bayar'),
                ),
              if (c.saldoKasbon > 0) const SizedBox(height: 8),
              if (c.saldoKasbon > 0)
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Share.share(
                        'Halo ${c.nama}, bon di warkop kini ${rupiah(c.saldoKasbon)}. Ditunggu pembayarannya ya, terima kasih 🙏');
                  },
                  icon: const Icon(Icons.chat),
                  label: const Text('Ingatkan lewat WA'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bayar(Customer c) async {
    final repoBaca = ref.read(repoProvider);
    int? pilih;
    final bebasC = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text('${c.nama} bayar berapa?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Utang: ${rupiah(c.saldoKasbon)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Lunas semua'),
                    selected: pilih == c.saldoKasbon,
                    onSelected: (_) =>
                        setS(() => pilih = c.saldoKasbon),
                  ),
                  ChoiceChip(
                    label: const Text('Separuh'),
                    selected: pilih == (c.saldoKasbon / 2).round(),
                    onSelected: (_) => setS(
                        () => pilih = (c.saldoKasbon / 2).round()),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: bebasC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Atau isi sendiri',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                onChanged: (_) => setS(() => pilih = null),
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
    final nom = pilih ??
        int.tryParse(bebasC.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    if (nom <= 0) return;
    await repoBaca.bayarKasbon(c.id, nom);
    setState(() => _nonce++);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pembayaran tercatat ✅')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: barWarkop('Bon'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambah,
        icon: const Icon(Icons.person_add),
        label: const Text('Tambah nama'),
      ),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: (db.select(db.customers)
              ..orderBy([(t) => OrderingTerm.desc(t.saldoKasbon)]))
            .get(),
        builder: (ctx, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final cs = snap.data!;
          final total =
              cs.fold<int>(0, (a, c) => a + c.saldoKasbon);
          if (cs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('📒', style: TextStyle(fontSize: 64)),
                    SizedBox(height: 12),
                    Text('Belum ada yang bon',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      'Kalau ada yang jajan tapi bayar belakangan, catat di sini lewat tombol di bawah.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: total > 0
                      ? Colors.red.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  total > 0
                      ? '💸 Total bon di luar: ${rupiah(total)}'
                      : '✅ Semua lunas, tidak ada bon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: total > 0
                        ? Colors.red.shade800
                        : Colors.green.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              for (final c in cs)
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    leading: CircleAvatar(
                      backgroundColor: c.saldoKasbon > 0
                          ? Colors.red.shade100
                          : Colors.green.shade100,
                      child: Text(
                        c.nama.isEmpty ? '?' : c.nama[0].toUpperCase(),
                        style:
                            const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(c.nama,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: c.saldoKasbon > 0
                        ? const Text('Belum lunas')
                        : const Text('Lunas ✅'),
                    trailing: Text(
                      rupiah(c.saldoKasbon),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: c.saldoKasbon > 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                    onTap: () => _detail(c),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
