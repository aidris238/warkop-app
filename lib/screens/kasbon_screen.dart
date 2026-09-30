import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';

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
    final hpC = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pelanggan baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            TextField(controller: hpC, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'No. HP (opsional)', border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
        ],
      ),
    );
    if (ok != true || namaC.text.trim().isEmpty) return;
    await db.into(db.customers).insert(CustomersCompanion.insert(
          nama: namaC.text.trim(),
          noHp: Value(hpC.text.trim().isEmpty ? null : hpC.text.trim()),
        ));
    setState(() => _nonce++);
  }

  Future<void> _detail(Customer c) async {
    final db = ref.read(dbProvider);
    final repo = ref.read(repoProvider);
    final sales = await (db.select(db.sales)
          ..where((t) => t.customerId.equals(c.id) & t.metodeBayar.equals('kasbon') & t.status.equals('lunas'))
          ..orderBy([(t) => OrderingTerm.desc(t.waktu)]))
        .get();
    final pays = await (db.select(db.debtPayments)
          ..where((t) => t.customerId.equals(c.id))
          ..orderBy([(t) => OrderingTerm.desc(t.tanggal)]))
        .get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${c.nama} • ${rupiah(c.saldoKasbon)}'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Kasbon:', style: TextStyle(fontWeight: FontWeight.bold)),
                if (sales.isEmpty) const Text('- tidak ada -'),
                for (final s in sales) Text('• ${tgl(s.waktu)} — ${rupiah(s.total)}'),
                const SizedBox(height: 8),
                const Text('Pembayaran:', style: TextStyle(fontWeight: FontWeight.bold)),
                if (pays.isEmpty) const Text('- belum ada -'),
                for (final p in pays) Text('• ${tgl(p.tanggal)} — ${rupiah(p.nominal)}'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Share.share('Halo ${c.nama}, kasbon di warkop kini sebesar ${rupiah(c.saldoKasbon)}. Mohon dibayar ya, terima kasih 🙏');
            },
            child: const Text('Ingatkan WA'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _bayar(c);
            },
            child: const Text('Bayar'),
          ),
        ],
      ),
    );
  }

  Future<void> _bayar(Customer c) async {
    final repo = ref.read(repoProvider);
    final nomC = TextEditingController(text: c.saldoKasbon.toString());
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Bayar kasbon • ${c.nama}'),
        content: TextField(controller: nomC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nominal', border: OutlineInputBorder(), prefixText: 'Rp ')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
        ],
      ),
    );
    if (ok != true) return;
    final nom = int.tryParse(nomC.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (nom <= 0) return;
    await repo.bayarKasbon(c.id, nom);
    setState(() => _nonce++);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pembayaran kasbon tersimpan')));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Kasbon')),
      floatingActionButton: FloatingActionButton(onPressed: _tambah, child: const Icon(Icons.person_add)),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: (db.select(db.customers)..orderBy([(t) => OrderingTerm.desc(t.saldoKasbon)])).get(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final cs = snap.data!;
          if (cs.isEmpty) return const Center(child: Text('Belum ada pelanggan kasbon'));
          return ListView.builder(
            itemCount: cs.length,
            itemBuilder: (_, i) {
              final c = cs[i];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(c.nama),
                  subtitle: Text(c.noHp ?? '-'),
                  trailing: Text(rupiah(c.saldoKasbon),
                      style: TextStyle(fontWeight: FontWeight.bold, color: c.saldoKasbon > 0 ? Colors.red : Colors.green)),
                  onTap: () => _detail(c),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
