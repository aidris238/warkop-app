import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository.dart';
import '../providers.dart';
import '../utils/format.dart';
import '../widgets/logo_header.dart';

// Beranda: sapaan + kartu untung hari ini + jalan pintas + menu laris.
// Bahasa dibuat awam: "Omzet" -> "Uang masuk", dst.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String _periode = 'Hari ini';
  int _nonce = 0;

  (DateTime, DateTime) _rentang() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    switch (_periode) {
      case 'Kemarin':
        return (
          today.subtract(const Duration(days: 1)),
          today,
        );
      case '7 hari':
        return (
          today.subtract(const Duration(days: 6)),
          today.add(const Duration(days: 1)),
        );
      case 'Bulan ini':
        return (
          DateTime(now.year, now.month, 1),
          today.add(const Duration(days: 1)),
        );
      default:
        return (today, today.add(const Duration(days: 1)));
    }
  }

  Future<void> _aturPin() async {
    final c = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kunci keamanan (PIN)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'PIN dipakai saat membatalkan transaksi.\nCukup atur sekali.'),
            const SizedBox(height: 12),
            TextField(
              controller: c,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: 'PIN 4-6 angka',
                border: OutlineInputBorder(),
              ),
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
    );
    if (ok == true && c.text.trim().length >= 4) {
      await ref.read(repoProvider).setPin(c.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('PIN tersimpan')));
      }
    } else if (ok == true && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('PIN minimal 4 angka')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(repoProvider);
    final (start, end) = _rentang();
    final skema = Theme.of(context).colorScheme;
    final jam = DateTime.now().hour;
    final sapa = jam < 11
        ? 'Selamat pagi'
        : jam < 15
            ? 'Selamat siang'
            : jam < 19
                ? 'Selamat sore'
                : 'Selamat malam';
    return Scaffold(
      appBar: barWarkop(
        'Warkop Saya',
        aksi: [
          IconButton(
              icon: const Icon(Icons.lock_outline),
              tooltip: 'Atur PIN',
              onPressed: _aturPin),
          IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Muat ulang',
              onPressed: () => setState(() => _nonce++)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(sapa,
              style: const TextStyle(fontSize: 15, color: Colors.grey)),
          const Text('Bagaimana jualan hari ini?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final p in ['Hari ini', 'Kemarin', '7 hari', 'Bulan ini'])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(p,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      selected: _periode == p,
                      onSelected: (_) => setState(() => _periode = p),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          FutureBuilder(
            key: ValueKey('$_periode-$_nonce'),
            future:
                Future.wait([repo.dashboard(start, end), repo.nilaiStok()]),
            builder: (ctx, snap) {
              if (snap.hasError) {
                return _kosong(
                  ikon: Icons.cloud_off,
                  judul: 'Belum bisa memuat',
                  sub: 'Periksa lagi sebentar atau muat ulang.',
                );
              }
              if (!snap.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final d = snap.data![0] as DashboardData;
              final stok = snap.data![1] as int;
              if (d.transaksi == 0 && d.pengeluaran == 0) {
                return Column(
                  children: [
                    _kartuUntung(d, skema, kosong: true),
                    _kosong(
                      ikon: Icons.point_of_sale,
                      judul: 'Belum ada jualan $_periodeLabel()',
                      sub: 'Ketuk tombol "Jual" di bawah untuk mencatat penjualan pertama.',
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _kartuUntung(d, skema),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _mini(
                              '💰 Uang masuk', rupiah(d.omzet), Colors.green)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _mini('🧾 Belanja & biaya',
                              rupiah(d.pengeluaran + d.hpp), Colors.orange)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: _mini('🧺 Modal barang laku',
                              rupiah(d.hpp), Colors.teal)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _mini('📦 Nilai stok',
                              rupiah(stok), Colors.blueGrey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.receipt_long, size: 20),
                      const SizedBox(width: 6),
                      Text('${d.transaksi} kali jualan',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text('Paling laris',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  if (d.terlaris.isEmpty)
                    const Card(
                        child: ListTile(
                            title: Text('Belum ada menu yang laku'))),
                  for (var k = 0; k < d.terlaris.length; k++)
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: k == 0
                              ? Colors.amber.shade200
                              : skema.surfaceContainerHighest,
                          child: Text('${k + 1}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        title: Text(d.terlaris[k].key,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        trailing: Text('${d.terlaris[k].value} porsi',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _periodeLabel() =>
      _periode == 'Hari ini' ? 'hari ini' : _periode.toLowerCase();

  Widget _kartuUntung(DashboardData d, ColorScheme skema,
      {bool kosong = false}) {
    final untung = d.labaBersih;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: untung >= 0
              ? [const Color(0xFF7C4A12), const Color(0xFFB9791F)]
              : [const Color(0xFF7F1D1D), const Color(0xFFB91C1C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kosong
                ? 'Untung bersih $_periodeLabel'
                : 'Untung bersih • ${_periode.toLowerCase()}',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            kosong ? 'Rp0' : rupiah(untung),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              kosong
                  ? 'Mulai catat jualan biar untungnya kelihatan'
                  : untung >= 0
                      ? 'Alhamdulillah, untung 👍'
                      : 'Awas, lagi rugi — cek pengeluaran',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mini(String label, String nilai, Color warna) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    color: warna,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            const SizedBox(height: 4),
            Text(nilai,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _kosong(
      {required IconData ikon, required String judul, required String sub}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        child: Column(
          children: [
            Icon(ikon, size: 56, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(judul,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(sub,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
