import 'package:drift/drift.dart' hide Column, Table;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';
import '../utils/foto.dart';
import '../widgets/logo_header.dart';

class MasterScreen extends ConsumerStatefulWidget {
  const MasterScreen({super.key});
  @override
  ConsumerState<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends ConsumerState<MasterScreen> {
  int _nonce = 0;
  void _segarkan() => setState(() => _nonce++);

  // ---------- tombol foto (kamera / galeri) ----------
  Widget _tombolFoto(String? path, StateSetter setS, void Function(String?) ganti) {
    return Row(
      children: [
        FotoItem(path: path, emoji: '📷', ukuran: 64),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  final p = await ambilFoto(ImageSource.camera, 'item');
                  if (p != null) setS(() => ganti(p));
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Foto kamera'),
              ),
              const SizedBox(height: 6),
              OutlinedButton.icon(
                onPressed: () async {
                  final p = await ambilFoto(ImageSource.gallery, 'item');
                  if (p != null) setS(() => ganti(p));
                },
                icon: const Icon(Icons.photo),
                label: const Text('Pilih galeri'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- bahan ----------
  Future<void> _formBahan([Ingredient? b]) async {
    final db = ref.read(dbProvider);
    final namaC = TextEditingController(text: b?.nama ?? '');
    final katC = TextEditingController(text: b?.kategori ?? 'Lainnya');
    final satC = TextEditingController(text: b?.satuan ?? 'pcs');
    final minC = TextEditingController(text: b?.stokMin.toString() ?? '0');
    final tgtC = TextEditingController(text: b?.stokTarget.toString() ?? '0');
    String? foto = b?.fotoPath;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text(b == null ? 'Bahan baru' : 'Ubah bahan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _tombolFoto(foto, setS, (p) => foto = p),
                const SizedBox(height: 8),
                TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama, mis. Kopi Kapal Api', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: katC, decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: satC, decoration: const InputDecoration(labelText: 'Satuan stok (gram/ml/pcs/...)', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: minC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stok minimum', border: OutlineInputBorder())),
              const SizedBox(height: 8),
              TextField(controller: tgtC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stok target', border: OutlineInputBorder())),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
          ],
        ),
      ),
    );
    if (ok != true || namaC.text.trim().isEmpty) return;
    final comp = IngredientsCompanion(
      nama: Value(namaC.text.trim()),
      kategori: Value(katC.text.trim().isEmpty ? 'Lainnya' : katC.text.trim()),
      satuan: Value(satC.text.trim().isEmpty ? 'pcs' : satC.text.trim()),
      stokMin: Value(double.tryParse(minC.text.replaceAll(',', '.')) ?? 0),
      stokTarget: Value(double.tryParse(tgtC.text.replaceAll(',', '.')) ?? 0),
      fotoPath: Value(foto),
    );
    if (b == null) {
      await db.into(db.ingredients).insert(comp);
    } else {
      await (db.update(db.ingredients)..where((t) => t.id.equals(b.id))).write(comp);
    }
    _segarkan();
  }

  // ---------- menu ----------
  Future<void> _formMenu([Product? p]) async {
    final db = ref.read(dbProvider);
    final repo = ref.read(repoProvider);
    final namaC = TextEditingController(text: p?.nama ?? '');
    final katC = TextEditingController(text: p?.kategori ?? 'Lainnya');
    final hargaC = TextEditingController(text: p?.hargaJual.toString() ?? '');
    String tipe = p?.tipe ?? 'resep';
    String? foto = p?.fotoPath;
    final ings = await (db.select(db.ingredients)..where((t) => t.aktif.equals(true))).get();
    final byId = {for (final e in ings) e.id: e};
    int? ingId = p?.ingredientId;
    final modalResep = p == null ? 0 : await repo.hppOf(p.id);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) {
          // Hitung otomatis: modal + untung + margin.
          var modal = modalResep;
          if (tipe == 'langsung' && ingId != null) {
            modal = byId[ingId]?.hargaTerakhir ?? 0;
          }
          final harga = int.tryParse(hargaC.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
          final untung = harga - modal;
          final margin = harga > 0 ? (untung * 100 / harga).round() : 0;
          return AlertDialog(
          title: Text(p == null ? 'Menu baru' : 'Ubah menu'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _tombolFoto(foto, setS, (x) => foto = x),
                const SizedBox(height: 8),
                TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama menu, mis. Kopi Tubruk', border: OutlineInputBorder())),
                const SizedBox(height: 8),
                TextField(controller: katC, decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder())),
                const SizedBox(height: 8),
                TextField(
                  controller: hargaC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Harga jual', border: OutlineInputBorder(), prefixText: 'Rp '),
                  onChanged: (_) => setS(() {}),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: tipe,
                  decoration: const InputDecoration(labelText: 'Tipe', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'resep', child: Text('Resep (racikan)')),
                    DropdownMenuItem(value: 'langsung', child: Text('Jual langsung 1:1')),
                  ],
                  onChanged: (v) => setS(() => tipe = v ?? 'resep'),
                ),
                if (tipe == 'langsung') ...[
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: ingId,
                    decoration: const InputDecoration(labelText: 'Bahan terkait', border: OutlineInputBorder()),
                    items: ings.map((e) => DropdownMenuItem(value: e.id, child: Text('${e.nama} (${e.satuan})'))).toList(),
                    onChanged: (v) => setS(() => ingId = v),
                  ),
                ],
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.primaryContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🧮 Modal: ${rupiah(modal)} / porsi',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        harga > 0
                            ? 'Untung: ${rupiah(untung)} ($margin%)'
                            : 'Isi harga jual biar untungnya kehitung',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: untung >= 0 ? Colors.green.shade800 : Colors.red,
                        ),
                      ),
                      if (tipe == 'resep')
                        const Text('Resep diatur lewat ketuk menu → atur resep.',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Simpan')),
          ],
        );
        },
      ),
    );
    if (ok != true || namaC.text.trim().isEmpty) return;
    final comp = ProductsCompanion(
      nama: Value(namaC.text.trim()),
      kategori: Value(katC.text.trim().isEmpty ? 'Lainnya' : katC.text.trim()),
      hargaJual: Value(int.tryParse(hargaC.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0),
      tipe: Value(tipe),
      ingredientId: Value(ingId),
      fotoPath: Value(foto),
    );
    if (p == null) {
      await db.into(db.products).insert(comp);
    } else {
      await (db.update(db.products)..where((t) => t.id.equals(p.id))).write(comp);
    }
    _segarkan();
  }

  // ---------- resep: tabel biaya otomatis ----------
  Future<void> _kelolaResep(Product p) async {
    final db = ref.read(dbProvider);
    final ings = await (db.select(db.ingredients)..where((t) => t.aktif.equals(true))).get();
    final byId = {for (final e in ings) e.id: e};
    var items = await (db.select(db.recipeItems)..where((t) => t.productId.equals(p.id))).get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) {
          // Total modal terhitung otomatis dari semua baris.
          var modal = 0;
          for (final ri in items) {
            modal += ((byId[ri.ingredientId]?.hargaTerakhir ?? 0) * ri.takaran).round();
          }
          final untung = p.hargaJual - modal;
          final margin = p.hargaJual > 0 ? (untung * 100 / p.hargaJual).round() : 0;
          return AlertDialog(
            title: Text('Resep • ${p.nama}'),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(ctx).colorScheme.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        '🧮 Modal: ${rupiah(modal)} • Jual: ${rupiah(p.hargaJual)}\nUntung ${rupiah(untung)} ($margin%)',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (items.isEmpty) const Text('Belum ada bahan. Tambah di bawah.'),
                    Table(
                      columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(2), 2: FlexColumnWidth(2)},
                      children: [
                        const TableRow(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('Bahan', style: TextStyle(fontWeight: FontWeight.bold))),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('Takaran', style: TextStyle(fontWeight: FontWeight.bold))),
                            Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('Biaya', style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                        ),
                        for (final ri in items)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(byId[ri.ingredientId]?.nama ?? '?')),
                                    InkWell(
                                      child: const Icon(Icons.delete, color: Colors.red, size: 22),
                                      onTap: () async {
                                        await (db.delete(db.recipeItems)..where((t) => t.id.equals(ri.id))).go();
                                        items = await (db.select(db.recipeItems)..where((t) => t.productId.equals(p.id))).get();
                                        setS(() {});
                                        _segarkan();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Text(qtyStr(ri.takaran, byId[ri.ingredientId]?.satuan ?? '')),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Text(rupiah(((byId[ri.ingredientId]?.hargaTerakhir ?? 0) * ri.takaran).round())),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const Divider(),
                    _TambahResep(
                      ings: ings,
                      onAdd: (ingId, takaran) async {
                        await db.into(db.recipeItems).insert(RecipeItemsCompanion.insert(
                              productId: p.id,
                              ingredientId: ingId,
                              takaran: takaran,
                            ));
                        items = await (db.select(db.recipeItems)..where((t) => t.productId.equals(p.id))).get();
                        setS(() {});
                        _segarkan();
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup'))],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider);
    final repo = ref.watch(repoProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Padding(padding: EdgeInsets.all(8), child: LogoWarkop(ukuran: 40)),
          titleSpacing: 0,
          title: const Text('Kelola'),
          bottom: const TabBar(tabs: [Tab(text: 'Bahan'), Tab(text: 'Menu'), Tab(text: 'Hitung modal')]),
          actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _segarkan)],
        ),
        body: TabBarView(
          children: [
            // TAB BAHAN
            FutureBuilder(
              key: ValueKey('b$_nonce'),
              future: (db.select(db.ingredients)..orderBy([(t) => OrderingTerm(expression: t.nama)])).get(),
              builder: (ctx, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final ings = snap.data!;
                return ListView.builder(
                  itemCount: ings.length + 1,
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: FilledButton.icon(onPressed: () => _formBahan(), icon: const Icon(Icons.add), label: const Text('Tambah bahan')),
                      );
                    }
                    final b = ings[i - 1];
                    return Card(
                      child: ListTile(
                        leading: FotoItem(path: b.fotoPath, emoji: '🧂'),
                        title: Text(b.nama, style: TextStyle(decoration: b.aktif ? null : TextDecoration.lineThrough)),
                        subtitle: Text('${b.kategori} • ${b.satuan} • min ${qtyStr(b.stokMin, b.satuan)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: const Icon(Icons.edit), onPressed: () => _formBahan(b)),
                            IconButton(
                              icon: Icon(b.aktif ? Icons.visibility_off : Icons.visibility),
                              onPressed: () async {
                                await (db.update(db.ingredients)..where((t) => t.id.equals(b.id)))
                                    .write(IngredientsCompanion(aktif: Value(!b.aktif)));
                                _segarkan();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            // TAB MENU
            FutureBuilder(
              key: ValueKey('m$_nonce'),
              future: (db.select(db.products)..orderBy([(t) => OrderingTerm(expression: t.nama)])).get(),
              builder: (ctx, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final menus = snap.data!;
                return ListView.builder(
                  itemCount: menus.length + 1,
                  itemBuilder: (_, i) {
                    if (i == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: FilledButton.icon(onPressed: () => _formMenu(), icon: const Icon(Icons.add), label: const Text('Tambah menu')),
                      );
                    }
                    final m = menus[i - 1];
                    return Card(
                      child: ListTile(
                        leading: FotoItem(path: m.fotoPath, emoji: '🍽'),
                        title: Text(m.nama, style: TextStyle(decoration: m.aktif ? null : TextDecoration.lineThrough)),
                        subtitle: Text('${m.kategori} • ${m.tipe == 'resep' ? 'racikan — ketuk untuk atur resep' : 'langsung'}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(rupiah(m.hargaJual), style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(icon: const Icon(Icons.edit), onPressed: () => _formMenu(m)),
                            IconButton(
                              icon: Icon(m.aktif ? Icons.visibility_off : Icons.visibility),
                              onPressed: () async {
                                await (db.update(db.products)..where((t) => t.id.equals(m.id)))
                                    .write(ProductsCompanion(aktif: Value(!m.aktif)));
                                _segarkan();
                              },
                            ),
                          ],
                        ),
                        onTap: () => _kelolaResep(m),
                      ),
                    );
                  },
                );
              },
            ),
            // TAB HPP
            FutureBuilder(
              key: ValueKey('h$_nonce'),
              future: (db.select(db.products)..where((t) => t.aktif.equals(true))).get(),
              builder: (ctx, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final menus = snap.data!;
                return ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (_, i) {
                    final m = menus[i];
                    return FutureBuilder(
                      future: repo.hppOf(m.id),
                      builder: (c2, h) {
                        if (!h.hasData) return const Card(child: ListTile(title: Text('...')));
                        final hpp = h.data!;
                        final untung = m.hargaJual - hpp;
                        final margin = m.hargaJual > 0 ? (untung * 100 / m.hargaJual).round() : 0;
                        return Card(
                          child: ListTile(
                            leading: FotoItem(path: m.fotoPath, emoji: '🍽'),
                            title: Text(m.nama),
                            subtitle: Text('Modal ${rupiah(hpp)} • untung ${rupiah(untung)} ($margin%)'),
                            trailing: Text(rupiah(m.hargaJual), style: const TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () => _kelolaResep(m),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TambahResep extends StatefulWidget {
  final List<Ingredient> ings;
  final Future<void> Function(int, double) onAdd;
  const _TambahResep({required this.ings, required this.onAdd});
  @override
  State<_TambahResep> createState() => _TambahResepState();
}

class _TambahResepState extends State<_TambahResep> {
  int? _ingId;
  final _takC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Pratinjau biaya otomatis saat bahan + takaran dipilih.
    final ing = _ingId == null ? null : widget.ings.where((e) => e.id == _ingId).firstOrNull;
    final tak = double.tryParse(_takC.text.replaceAll(',', '.'));
    final biaya = (ing == null || tak == null) ? 0 : (ing.hargaTerakhir * tak).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DropdownButtonFormField<int>(
                value: _ingId,
                decoration: const InputDecoration(labelText: 'Bahan', border: OutlineInputBorder(), isDense: true),
                items: widget.ings.map((e) => DropdownMenuItem(value: e.id, child: Text(e.nama, overflow: TextOverflow.ellipsis))).toList(),
                onChanged: (v) => setState(() => _ingId = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _takC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Takaran', border: OutlineInputBorder(), isDense: true),
                onChanged: (_) => setState(() {}),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, size: 32),
              onPressed: () async {
                final t = double.tryParse(_takC.text.replaceAll(',', '.'));
                if (_ingId == null || t == null || t <= 0) return;
                await widget.onAdd(_ingId!, t);
                _takC.clear();
                setState(() => _ingId = null);
              },
            ),
          ],
        ),
        if (biaya > 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('= ${rupiah(biaya)} (otomatis: ${qtyStr(tak ?? 0, ing?.satuan ?? '')} × ${rupiah(ing?.hargaTerakhir ?? 0)})',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
      ],
    );
  }
}
