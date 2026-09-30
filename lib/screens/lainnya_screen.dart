import 'package:flutter/material.dart';

import 'belanja_screen.dart';
import 'masuk_screen.dart';
import 'master_screen.dart';
import 'pengeluaran_screen.dart';

// Menu "Lainnya": jalan ke layar yang jarang dibuka tiap hari.
class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lainnya 📋')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _item(
            context,
            emoji: '🛒',
            judul: 'Daftar Belanja',
            sub: 'Lihat yang habis, catat harga, jadi stok',
            tujuan: const BelanjaScreen(),
          ),
          _item(
            context,
            emoji: '📥',
            judul: 'Kulakan (Barang Masuk)',
            sub: 'Catat belanjaan / kiriman bahan',
            tujuan: const MasukScreen(),
          ),
          _item(
            context,
            emoji: '🧾',
            judul: 'Biaya (Pengeluaran)',
            sub: 'Listrik, sewa, gaji, iuran...',
            tujuan: const PengeluaranScreen(),
          ),
          _item(
            context,
            emoji: '⚙️',
            judul: 'Kelola Menu & Bahan',
            sub: 'Tambah menu, bahan, resep, harga',
            tujuan: const MasterScreen(),
          ),
          const SizedBox(height: 8),
          Card(
            color: Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.5),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '💡 Urutan kerja tiap hari:\n1. Buka Stok → lihat yang menipis\n2. Belanja → centang & isi harga\n3. Jual seperti biasa di menu Jual',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context,
      {required String emoji,
      required String judul,
      required String sub,
      required Widget tujuan}) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Text(emoji, style: const TextStyle(fontSize: 36)),
        title: Text(judul,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.chevron_right, size: 30),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => tujuan)),
      ),
    );
  }
}
