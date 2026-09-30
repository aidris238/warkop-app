// Bantuan foto: ambil dari kamera/galeri, simpan ke folder app,
// kembalikan path-nya. Nama file unik per item.
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String?> ambilFoto(ImageSource sumber, String awalan) async {
  final ambil = ImagePicker();
  final hasil = await ambil.pickImage(
    source: sumber,
    maxWidth: 1024,
    imageQuality: 80,
  );
  if (hasil == null) return null;
  final dir = await getApplicationDocumentsDirectory();
  final folder = Directory(p.join(dir.path, 'foto'));
  if (!await folder.exists()) await folder.create(recursive: true);
  final nama =
      '${awalan}_${DateTime.now().millisecondsSinceEpoch}.jpg';
  final tujuan = File(p.join(folder.path, nama));
  await File(hasil.path).copy(tujuan.path);
  return tujuan.path;
}
