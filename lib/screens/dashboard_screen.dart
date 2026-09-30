import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository.dart';
import '../providers.dart';
import '../utils/format.dart';

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
        return (today.subtract(const Duration(days: 1)), today);
      case '7 hari':
        return (today.subtract(const Duration(days: 6)), today.add(const Duration(days: 1)));
      case 'Bulan ini':
        return (DateTime(now.year, now.month, 1), today.add(const Duration(days: 1)));
      default:
        return (today, today.add(const Duration(days: 1)));
    }
  }

  Future<void> _aturPin() async {
    final c = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atur PIN keamanan'),
        content: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'PIN 4-6 digit (untuk void)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
        ],
      ),
    );
    if (ok == true && c.text.trim().length >= 4) {
      await ref.read(repoProvider).setPin(c.text.trim());
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN disimpan')));
    } else if (ok == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN minimal 4 digit')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(repoProvider);
    final (start, end) = _rentang();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
        actions: [
          IconButton(icon: const Icon(Icons.key), tooltip: 'Atur PIN', onPressed: _aturPin),
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => setState(() => _nonce++)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          DropdownButtonFormField<String>(
            value: _periode,
            decoration: const InputDecoration(labelText: 'Periode', border: OutlineInputBorder()),
            items: const ['Hari ini', 'Kemarin', '7 hari', 'Bulan ini']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _periode = v ?? 'Hari ini'),
          ),
          const SizedBox(height: 12),
          FutureBuilder(
            key: ValueSync(_periode, _nonce),
            future: Future.wait([repo.dashboard(start, end), repo.nilaiStok()]),
            builder: (ctx, snap) {
              if (!snap.hasData) return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()));
              final d = snap.data![0] as DashboardData;
              final stok = snap.data![1] as int;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.6,
                    children: [
                      _kartu('Omzet', rupiah(d.omzet), Colors.green),
                      _kartu('Laba kotor', rupiah(d.labaKotor), Colors.teal),
                      _kartu('Pengeluaran', rupiah(d.pengeluaran), Colors.orange),
                      _kartu('Laba bersih', rupiah(d.labaBersih), d.labaBersih >= 0 ? Colors.blue : Colors.red),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.receipt_long),
                      title: Text('${d.transaksi} transaksi'),
                      subtitle: Text('Nilai stok: ${rupiah(stok)}'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Menu terlaris', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  if (d.terlaris.isEmpty)
                    const Card(child: ListTile(title: Text('Belum ada penjualan periode ini')))
                  else
                    for (final e in d.terlaris)
                      Card(child: ListTile(title: Text(e.key), trailing: Text('${e.value}x', style: const TextStyle(fontWeight: FontWeight.bold)))),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _kartu(String label, String nilai, Color warna) {
    return Card(
      color: warna.withValues(alpha: 0.12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(color: warna, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(nilai, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class ValueSync extends ValueKey<String> {
  ValueSync(String a, int b) : super('$a-$b');
}
