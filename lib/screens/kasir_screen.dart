import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/repository.dart';
import '../providers.dart';
import '../utils/format.dart';
import '../widgets/logo_header.dart';

// Kasir: ketuk menu = tambah 1. Bayar lewat panel bawah.
class KasirScreen extends ConsumerStatefulWidget {
  const KasirScreen({super.key});
  @override
  ConsumerState<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends ConsumerState<KasirScreen> {
  final Map<int, int> _cart = {};
  String _kat = 'Semua';
  int _nonce = 0;

  String _emoji(String kategori) {
    final k = kategori.toLowerCase();
    if (k.contains('panas') || k.contains('kopi')) return '☕';
    if (k.contains('dingin') || k.contains('es')) return '🥤';
    if (k.contains('makan') || k.contains('mie') || k.contains('indomie')) {
      return '🍜';
    }
    if (k.contains('rokok')) return '🚬';
    if (k.contains('snack') || k.contains('jajan')) return '🍪';
    return '🍽';
  }

  int _total(List<Product> menus) {
    final h = {for (final m in menus) m.id: m.hargaJual};
    var t = 0;
    _cart.forEach((id, q) => t += (h[id] ?? 0) * q);
    return t;
  }

  int _jumlah() => _cart.values.fold(0, (a, b) => a + b);

  Future<void> _bayar(List<Product> menus) async {
    if (_cart.isEmpty) return;
    final repo = ref.read(repoProvider);
    final db = ref.read(dbProvider);
    final customers = await (db.select(db.customers)
          ..orderBy([(t) => OrderingTerm(expression: t.nama)]))
        .get();
    if (!mounted) return;
    String metode = 'tunai';
    int? customerId;
    final uangC = TextEditingController();
    final mejaC = TextEditingController();
    final total = _total(menus);
    final hasil = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) {
          final uang = int.tryParse(
                  uangC.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
              0;
          final kembali = (uang - total).clamp(0, 1 << 60);
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 12,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
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
                  const Text('Pembayaran',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  Text(rupiah(total),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(ctx).colorScheme.primary)),
                  const SizedBox(height: 12),
                  const Text('Dibayar pakai apa?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      for (final m in [
                        ('tunai', '💵', 'Cash'),
                        ('qris', '📱', 'QRIS'),
                        ('kasbon', '📒', 'Bon'),
                      ])
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () => setS(() => metode = m.$1),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
                                decoration: BoxDecoration(
                                  color: metode == m.$1
                                      ? Theme.of(ctx)
                                          .colorScheme
                                          .primaryContainer
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: metode == m.$1
                                        ? Theme.of(ctx).colorScheme.primary
                                        : Colors.grey.shade300,
                                    width: metode == m.$1 ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(m.$2,
                                        style: const TextStyle(fontSize: 28)),
                                    Text(m.$3,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: mejaC,
                    decoration: const InputDecoration(
                      labelText: 'Meja / nama pembeli (boleh kosong)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.table_restaurant),
                    ),
                  ),
                  if (metode == 'tunai') ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: uangC,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'Uang yang diterima',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp ',
                      ),
                      onChanged: (_) => setS(() {}),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final n in [total, 10000, 20000, 50000, 100000])
                          if (n > 0)
                            ActionChip(
                              label: Text(n == total
                                  ? 'Uang pas'
                                  : rupiah(n)),
                              onPressed: () => setS(
                                  () => uangC.text = n.toString()),
                            ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: kembali > 0 || uang >= total
                            ? Colors.green.shade50
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        uang == 0
                            ? 'Isi uang yang diterima dulu'
                            : uang < total
                                ? 'Kurang ${rupiah(total - uang)}'
                                : 'Kembalian: ${rupiah(kembali)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: uang != 0 && uang < total
                              ? Colors.red
                              : Colors.green.shade800,
                        ),
                      ),
                    ),
                  ],
                  if (metode == 'qris')
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Tunjukkan QR penjual ke pembeli, pastikan sudah masuk sebelum ketuk Selesai.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  if (metode == 'kasbon')
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: customers.isEmpty
                          ? const Text(
                              'Belum ada pelanggan. Tambah dulu di menu Bon.')
                          : DropdownButtonFormField<int>(
                              value: customerId,
                              decoration: const InputDecoration(
                                labelText: 'Siapa yang bon?',
                                border: OutlineInputBorder(),
                              ),
                              items: customers
                                  .map((c) => DropdownMenuItem(
                                        value: c.id,
                                        child: Text(
                                            '${c.nama} (${rupiah(c.saldoKasbon)})'),
                                      ))
                                  .toList(),
                              onChanged: (v) =>
                                  setS(() => customerId = v),
                            ),
                    ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      if (metode == 'tunai' && uang < total) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Uangnya kurang, cek lagi')));
                        return;
                      }
                      if (metode == 'kasbon' && customerId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Pilih dulu siapa yang bon')));
                        return;
                      }
                      Navigator.pop(ctx, true);
                    },
                    child: Text('Selesai • ${rupiah(total)}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    if (hasil != true) return;
    await repo.recordSale(
      lines: _cart.entries
          .map((e) => SaleLine(productId: e.key, qty: e.value))
          .toList(),
      metode: metode,
      customerId: metode == 'kasbon' ? customerId : null,
      meja: mejaC.text.trim().isEmpty ? null : mejaC.text.trim(),
    );
    _cart.clear();
    _nonce++;
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Jualan tercatat ✅ Stok otomatis berkurang')),
      );
    }
  }

  Future<void> _tahan(List<Product> menus) async {
    if (_cart.isEmpty) return;
    final repo = ref.read(repoProvider);
    final mejaC = TextEditingController();
    final nama = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tahan dulu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Buat pembeli yang makan dulu, bayar belakangan.'),
            const SizedBox(height: 12),
            TextField(
              controller: mejaC,
              decoration: const InputDecoration(
                labelText: 'Meja / nama, mis. Meja 3',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, mejaC.text.trim()),
              child: const Text('Tahan')),
        ],
      ),
    );
    if (nama == null || nama.isEmpty) return;
    await repo.recordSale(
      lines: _cart.entries
          .map((e) => SaleLine(productId: e.key, qty: e.value))
          .toList(),
      meja: nama,
      status: 'hold',
    );
    _cart.clear();
    _nonce++;
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pesanan $nama ditahan ⏸')));
    }
  }

  Future<void> _daftarTahan() async {
    final db = ref.read(dbProvider);
    final repo = ref.read(repoProvider);
    final holds = await (db.select(db.sales)
          ..where((t) => t.status.equals('hold'))
          ..orderBy([(t) => OrderingTerm.desc(t.waktu)]))
        .get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('⏸ Pesanan yang ditahan'),
        content: SizedBox(
          width: double.maxFinite,
          child: holds.isEmpty
              ? const Text('Tidak ada. Pesanan yang ditahan muncul di sini.')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: holds.length,
                  itemBuilder: (_, i) {
                    final h = holds[i];
                    return Card(
                      child: ListTile(
                        title: Text(h.meja ?? 'Tanpa nama',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        subtitle:
                            Text('${tglJam(h.waktu)} • ${rupiah(h.total)}'),
                        trailing: FilledButton(
                          onPressed: () async {
                            await repo.lunaskanHold(h.id);
                            if (ctx.mounted) Navigator.pop(ctx);
                            _nonce++;
                            setState(() {});
                            if (mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text('Sudah dibayar ✅')));
                            }
                          },
                          child: const Text('Bayar'),
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Tutup'))
        ],
      ),
    );
  }

  Future<void> _batalkan() async {
    final repo = ref.read(repoProvider);
    final pinC = TextEditingController();
    final alasanC = TextEditingController();
    final idC = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Batalkan jualan (khusus pemilik)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: idC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Nomor transaksi', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            TextField(
                controller: pinC,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'PIN pemilik', border: OutlineInputBorder())),
            const SizedBox(height: 8),
            TextField(
                controller: alasanC,
                decoration: const InputDecoration(
                    labelText: 'Alasan (wajib diisi)',
                    border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Batalkan')),
        ],
      ),
    );
    if (ok != true) return;
    final sid = int.tryParse(idC.text.trim());
    if (sid == null || alasanC.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Nomor transaksi dan alasan wajib diisi')));
      }
      return;
    }
    if (!await repo.verifyPin(pinC.text.trim())) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('PIN salah')));
      }
      return;
    }
    try {
      await repo.voidSale(sid, alasanC.text.trim());
      _nonce++;
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dibatalkan, stok dikembalikan ✅')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    return Scaffold(
      appBar: barWarkop(
        'Jual',
        aksi: [
          IconButton(
              icon: const Icon(Icons.hourglass_empty),
              tooltip: 'Pesanan yang ditahan',
              onPressed: _daftarTahan),
          IconButton(
              icon: const Icon(Icons.cancel_outlined),
              tooltip: 'Batalkan jualan',
              onPressed: _batalkan),
        ],
      ),
      body: FutureBuilder(
        key: ValueKey(_nonce),
        future: (db.select(db.products)
              ..where((t) => t.aktif.equals(true))
              ..orderBy([
                (t) => OrderingTerm(expression: t.kategori),
                (t) => OrderingTerm(expression: t.nama),
              ]))
            .get(),
        builder: (ctx, snap) {
          if (snap.hasError) {
            return const Center(
                child: Text('Gagal memuat menu. Coba buka ulang.'));
          }
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final semua = snap.data!;
          if (semua.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('🍽', style: TextStyle(fontSize: 64)),
                    SizedBox(height: 12),
                    Text('Belum ada menu',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      'Tambah menu di Lainnya → Kelola Menu & Bahan.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          final kats = [
            'Semua',
            ...{for (final m in semua) m.kategori}
          ];
          final menus = _kat == 'Semua'
              ? semua
              : semua.where((m) => m.kategori == _kat).toList();
          final total = _total(semua);
          return Column(
            children: [
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    for (final k in kats)
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 6),
                        child: ChoiceChip(
                          label: Text(k,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                          selected: _kat == k,
                          onSelected: (_) => setState(() => _kat = k),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: menus.length,
                  itemBuilder: (_, i) {
                    final m = menus[i];
                    final q = _cart[m.id] ?? 0;
                    final skema = Theme.of(context).colorScheme;
                    return InkWell(
                      onTap: () => setState(() => _cart[m.id] = q + 1),
                      borderRadius: BorderRadius.circular(20),
                      child: Card(
                        color: q > 0 ? skema.primaryContainer : null,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FotoItem(
                                path: m.fotoPath,
                                emoji:
                                    _emoji('${m.kategori} ${m.nama}'),
                                ukuran: 64,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                m.nama,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(rupiah(m.hargaJual),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: skema.primary,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              if (q == 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: skema.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text('+ Tambah',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                )
                              else
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _tombolKecil(Icons.remove, () {
                                      setState(() {
                                        final nq = q - 1;
                                        if (nq <= 0) {
                                          _cart.remove(m.id);
                                        } else {
                                          _cart[m.id] = nq;
                                        }
                                      });
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text('$q',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    _tombolKecil(Icons.add, () {
                                      setState(() => _cart[m.id] = q + 1);
                                    }),
                                  ],
                                ),
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
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  '${_jumlah()} porsi • ${rupiah(total)}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const Text('Ketuk Bayar untuk lanjut',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => _tahan(semua),
                          child: const Text('⏸ Tahan'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () => _bayar(semua),
                          child: const Text('Bayar 💵'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _tombolKecil(IconData ikon, VoidCallback aksi) {
    return InkWell(
      onTap: aksi,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.7),
        ),
        child: Icon(ikon),
      ),
    );
  }
}
