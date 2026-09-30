import 'package:intl/intl.dart';

final _rp = NumberFormat('#,##0', 'id_ID');
final _tgl = DateFormat('dd/MM/yyyy');
final _tglJam = DateFormat('dd/MM/yyyy HH:mm');

String rupiah(int n) => 'Rp${_rp.format(n)}';
String tgl(DateTime d) => _tgl.format(d);
String tglJam(DateTime d) => _tglJam.format(d);

/// "1.5 kg" style — hilangkan .0
String qtyStr(double q, String satuan) {
  final s = q == q.roundToDouble() ? q.toInt().toString() : q.toString();
  return '$s $satuan';
}
