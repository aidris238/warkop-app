// Logo + header seragam: semua layar pakai AppBar yang sama,
// tidak ada lagi ikon default / judul polos yang terlihat aneh.
import 'dart:io';

import 'package:flutter/material.dart';

class LogoWarkop extends StatelessWidget {
  final double ukuran;
  const LogoWarkop({super.key, this.ukuran = 36});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ukuran * 0.28),
      child: Image.asset(
        'assets/icon.png',
        width: ukuran,
        height: ukuran,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Text(
          '☕',
          style: TextStyle(fontSize: ukuran * 0.8),
        ),
      ),
    );
  }
}

/// Foto produk/bahan: tampilkan file bila ada, emoji bila belum difoto.
class FotoItem extends StatelessWidget {
  final String? path;
  final String emoji;
  final double ukuran;
  const FotoItem(
      {super.key, this.path, required this.emoji, this.ukuran = 52});

  @override
  Widget build(BuildContext context) {
    if (path != null && path!.isNotEmpty && File(path!).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.file(
          File(path!),
          width: ukuran,
          height: ukuran,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              Text(emoji, style: const TextStyle(fontSize: 32)),
        ),
      );
    }
    return Container(
      width: ukuran,
      height: ukuran,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 28)),
      ),
    );
  }
}

/// AppBar seragam: logo + judul + aksi.
AppBar barWarkop(String judul, {List<Widget>? aksi}) {
  return AppBar(
    leading: const Padding(
      padding: EdgeInsets.all(8),
      child: LogoWarkop(ukuran: 40),
    ),
    title: Text(judul),
    titleSpacing: 0,
    actions: aksi,
  );
}
