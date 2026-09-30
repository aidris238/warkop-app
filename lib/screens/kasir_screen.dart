import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import '../utils/format.dart';

class KasirScreen extends ConsumerStatefulWidget {
  const KasirScreen({super.key});
  @override
  ConsumerState<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends ConsumerState<KasirScreen> {
  final Map<int, int> _cart = {};
  int _nonce = 0;

  Future<void> _bayar(List<Product> menus) async {
    if (_cart.isEmpty) return;
    final repo = ref.read(repoProvider);
    final db = ref.read(dbProvider);
    String metode = 'tunai';
    int? customerId;
    final uangC = TextEditingController();
    final mejaC = TextEditingController();
    final customers =
        await (db.select(db.customers)..orderBy([(t) => OrderingTerm(expression: t.nama)])).get();
    if (!mounted) return;
    final bayar = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) {
          final total = _total(menus);
          final uang = int.tryParse(uangC.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
          return AlertDialog(
            title: Text('Bayar • ${rupiah(total)}'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SegmentedButton<String>(
                    segments: [
                      ButtonSegment(value: 'tunai', label: Text('Tunai'), icon: Icon(Icons.payments)),
                      ButtonSegment(value: 'qris', label: Text('QRIS'), icon: Icon(Icons.qr_code)),
                      ButtonSegment(value: 'kasbon', label: Text('Kasbon'), icon: Icon(Icons.book)),
                    ],
                    selected: {metode},
                    onSelectionChanged: (s) => setS(() => metode = s.first),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: mejaC,
                    decoration: const InputDecoration(labelText: 'Meja / nama (opsional)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  if (metode == 'tunai') ...[
                    TextField(
                      controller: uangC,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Uang diterima', border: OutlineInputBorder(), prefixText: 'Rp '),
                      onChanged: (_) => setS(() {}),
                    ),
                    const SizedBox(height: 8),
                    Text('Kembalian: ${rupiah((uang - total).clamp(0, 1 << 60))}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                  if (metode == 'kasbon')
                    DropdownButtonFormField<int>(
                      value: customerId,
                      decoration: const InputDecoration(labelText: 'Pelanggan', border: OutlineInputBorder()),
                      items: customers
                          .map((c) => DropdownMenuItem(value: c.id, child: Text('${c.nama} (${rupiah(c.saldoKasbon)})')))
                          .toList(),
                      onChanged: (v) => setS(() => customerId = v),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
              FilledButton(
                onPressed: () {
                  if (metode == 'kasbon' && customerId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih pelanggan untuk kasbon')));
                    return;
                  }
                  Navigator.pop(ctx, true);
                },
                child: const Text('Selesai'),
              ),
            ],
          );
        },
      ),
    );
    if (bayar != true) return;
    await repo.recordSale(
      lines: _cart.entries.map((e) => SaleLine(productId: e.key, qty: e.value)).toList(),
      metode: metode,
      customerId: metode == 'kasbon' ? customerId : null,
      meja: mejaC.text.trim().isEmpty ? null : mejaC.text.trim(),
    );
    _cart.clear();
    _nonce++;
    setState(() {});
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaksi tersimpan')));
  }

  Future<void> _hold(List<Product> menus) async {
    if (_cart.isEmpty) return;
    final repo = ref.read(repoProvider);
    final mejaC = TextEditingController();
    final nama = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hold pesanan'),
        content: TextField(controller: mejaC, decoration: const InputDecoration(labelText: 'Meja / nama', border: OutlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, mejaC.text.trim()), child: const Text('Hold')),
        ],
      ),
    );
    if (nama == null || nama.isEmpty) return;
    await repo.recordSale(
      lines: _cart.entries.map((e) => SaleLine(productId: e.key, qty: e.value)).toList(),
      meja: nama,
      status: 'hold',
    );
    _cart.clear();
    _nonce++;
    setState(() {});
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pesanan $nama di-hold')));
  }

  Future<void> _daftarHold() async {
    final db = ref.read(dbProvider);
    final repo = ref.read(repoProvider);
    final holds = await (db.select(db.sales)..where((t) => t.status.equals('hold'))..orderBy([(t) => OrderingTerm.desc(t.waktu)]))
        .get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pesanan hold'),
        content: SizedBox(
          width: double.maxFinite,
          child: holds.isEmpty
              ? const Text('Tidak ada pesanan hold')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: holds.length,
                  itemBuilder: (_, i) {
                    final h = holds[i];
                    return ListTile(
                      title: Text(h.meja ?? 'Tanpa nama'),
                      subtitle: Text('${tglJam(h.waktu)} • ${rupiah(h.total)}'),
                      trailing: FilledButton(
                        onPressed: () async {
                          await repo.lunaskanHold(h.id);
                          if (ctx.mounted) Navigator.pop(ctx);
                          _nonce++;
                          setState(() {});
                          if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pesanan dilunasi')));
                        },
                        child: const Text('Lunas'),
                      ),
                    );
                  },
                ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup'))],
      ),
    );
  }

  Future<void> _void() async {
    final repo = ref.read(repoProvider);
    final db = ref.read(dbProvider);
    final pinC = TextEditingController();
    final alasanC = TextEditingController();
    final idC = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Void transaksi (owner)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ID transaksi (lihat di Laporan/hold)', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            TextField(controller: pinC, keyboardType: TextInputType.number, obscureText: true, decoration: const InputDecoration(labelText: 'PIN owner', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            TextField(controller: alasanC, decoration: const InputDecoration(labelText: 'Alasan (wajib)', border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Void')),
        ],
      ),
    );
    if (ok != true) return;
    final sid = int.tryParse(idC.text.trim());
    if (sid == null || alasanC.text.trim().isEmpty) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ID dan alasan wajib diisi')));
      return;
    }
    if (!await repo.verifyPin(pinC.text.trim())) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN salah')));
      return;
    }
    try {
      await repo.voidSale(sid, alasanC.text.trim());
      await db.select(db.sales).get();
      _nonce++;
      setState(() {});
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaksi di-void, stok dikembalikan')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: $e')));
    }
  }

  int _total(List<Product> menus) {
    final h = {for (final m in menus) m.id: m.hargaJual};
    var t = 0;
    _cart.forEach((id, q) => t += (h[id] ?? 0) * q);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
        actions: [
          IconButton(icon: const Icon(Icons.hourglass_empty), tooltip: 'Pesanan hold', onPressed: _daftarHold),
          IconButton(icon: const Icon(Icons.cancel), tooltip: 'Void', onPressed: _void),
        ],
      ),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: (db.select(db.products)..where((t) => t.aktif.equals(true))..orderBy([(t) => OrderingTerm(expression: t.kategori), (t) => OrderingTerm(expression: t.nama)])).get(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final menus = snap.data!;
          final total = _total(menus);
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.85,
                  ),
                  itemCount: menus.length,
                  itemBuilder: (_, i) {
                    final m = menus[i];
                    final q = _cart[m.id] ?? 0;
                    return InkWell(
                      onTap: () => setState(() => _cart[m.id] = q + 1),
                      onLongPress: () {
                        if (q > 0) setState(() => _cart.remove(m.id));
                      },
                      child: Card(
                        color: q > 0 ? Theme.of(context).colorScheme.primaryContainer : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (q > 0)
                                Badge(label: Text('$q'), child: const Icon(Icons.shopping_basket, size: 28))
                              else
                                const Icon(Icons.fastfood, size: 28),
                              const SizedBox(height: 6),
                              Text(m.nama, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              Text(rupiah(m.hargaJual), style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_cart.isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final m in menus.where((e) => _cart.containsKey(e.id)))
                        Row(
                          children: [
                            Expanded(child: Text('${m.nama} × ${_cart[m.id]}')),
                            IconButton(
                              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                              icon: const Icon(Icons.remove), onPressed: () => setState(() {
                                final q = _cart[m.id]! - 1;
                                if (q <= 0) {
                                  _cart.remove(m.id);
                                } else {
                                  _cart[m.id] = q;
                                }
                              }),
                            ),
                            Text(rupiah(m.hargaJual * _cart[m.id]!)),
                            IconButton(
                              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                              icon: const Icon(Icons.add), onPressed: () => setState(() => _cart[m.id] = _cart[m.id]! + 1),
                            ),
                          ],
                        ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(child: Text('Total: ${rupiah(total)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          OutlinedButton(onPressed: () => _hold(menus), child: const Text('Hold')),
                          const SizedBox(width: 8),
                          FilledButton(
                            style: FilledButton.styleFrom(minimumSize: const Size(120, 48)),
                            onPressed: () => _bayar(menus),
                            child: const Text('Bayar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
