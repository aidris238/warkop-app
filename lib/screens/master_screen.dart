import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../providers.dart';
import '../utils/format.dart';

class MasterScreen extends ConsumerStatefulWidget {
  const MasterScreen({super.key});
  @override
  ConsumerState<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends ConsumerState<MasterScreen> {
  int _nonce = 0;
  void _segarkan() => setState(() => _nonce++);

  // ---------- bahan ----------
  Future<void> _formBahan([Ingredient? b]) async {
    final db = ref.read(dbProvider);
    final namaC = TextEditingController(text: b?.nama ?? '');
    final katC = TextEditingController(text: b?.kategori ?? 'Lainnya');
    final satC = TextEditingController(text: b?.satuan ?? 'pcs');
    final minC = TextEditingController(text: b?.stokMin.toString() ?? '0');
    final tgtC = TextEditingController(text: b?.stokTarget.toString() ?? '0');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(b == null ? 'Bahan baru' : 'Ubah bahan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder())),
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
    );
    if (ok != true || namaC.text.trim().isEmpty) return;
    final comp = IngredientsCompanion(
      nama: Value(namaC.text.trim()),
      kategori: Value(katC.text.trim().isEmpty ? 'Lainnya' : katC.text.trim()),
      satuan: Value(satC.text.trim().isEmpty ? 'pcs' : satC.text.trim()),
      stokMin: Value(double.tryParse(minC.text.replaceAll(',', '.')) ?? 0),
      stokTarget: Value(double.tryParse(tgtC.text.replaceAll(',', '.')) ?? 0),
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
    final namaC = TextEditingController(text: p?.nama ?? '');
    final katC = TextEditingController(text: p?.kategori ?? 'Lainnya');
    final hargaC = TextEditingController(text: p?.hargaJual.toString() ?? '');
    String tipe = p?.tipe ?? 'resep';
    final ings = await (db.select(db.ingredients)..where((t) => t.aktif.equals(true))).get();
    int? ingId = p?.ingredientId;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text(p == null ? 'Menu baru' : 'Ubah menu'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: namaC, decoration: const InputDecoration(labelText: 'Nama menu', border: OutlineInputBorder())),
                const SizedBox(height: 8),
                TextField(controller: katC, decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder())),
                const SizedBox(height: 8),
                TextField(controller: hargaC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Harga jual', border: OutlineInputBorder(), prefixText: 'Rp ')),
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
    final comp = ProductsCompanion(
      nama: Value(namaC.text.trim()),
      kategori: Value(katC.text.trim().isEmpty ? 'Lainnya' : katC.text.trim()),
      hargaJual: Value(int.tryParse(hargaC.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0),
      tipe: Value(tipe),
      ingredientId: Value(ingId),
    );
    if (p == null) {
      await db.into(db.products).insert(comp);
    } else {
      await (db.update(db.products)..where((t) => t.id.equals(p.id))).write(comp);
    }
    _segarkan();
  }

  // ---------- resep ----------
  Future<void> _kelolaResep(Product p) async {
    final db = ref.read(dbProvider);
    final ings = await (db.select(db.ingredients)..where((t) => t.aktif.equals(true))).get();
    final byId = {for (final e in ings) e.id: e};
    var items = await (db.select(db.recipeItems)..where((t) => t.productId.equals(p.id))).get();
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text('Resep • ${p.nama}'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (items.isEmpty) const Text('Belum ada bahan. Tambah di bawah.'),
                for (final ri in items)
                  ListTile(
                    dense: true,
                    title: Text(byId[ri.ingredientId]?.nama ?? '?'),
                    subtitle: Text(qtyStr(ri.takaran, byId[ri.ingredientId]?.satuan ?? '')),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await (db.delete(db.recipeItems)..where((t) => t.id.equals(ri.id))).go();
                        items = await (db.select(db.recipeItems)..where((t) => t.productId.equals(p.id))).get();
                        setS(() {});
                        _segarkan();
                      },
                    ),
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
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Tutup'))],
        ),
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
          title: const Text('Kelola Menu & Bahan ⚙️'),
          bottom: const TabBar(tabs: [Tab(text: 'Bahan'), Tab(text: 'Menu'), Tab(text: 'HPP')]),
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
                        title: Text(m.nama, style: TextStyle(decoration: m.aktif ? null : TextDecoration.lineThrough)),
                        subtitle: Text('${m.kategori} • ${m.tipe}'),
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
                        final margin = m.hargaJual > 0 ? ((m.hargaJual - hpp) * 100 / m.hargaJual).round() : 0;
                        return Card(
                          child: ListTile(
                            title: Text(m.nama),
                            subtitle: Text('HPP ${rupiah(hpp)} • margin $margin%'),
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
    return Row(
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
          child: TextField(controller: _takC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Takaran', border: OutlineInputBorder(), isDense: true)),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle, size: 32),
          onPressed: () async {
            final tak = double.tryParse(_takC.text.replaceAll(',', '.'));
            if (_ingId == null || tak == null || tak <= 0) return;
            await widget.onAdd(_ingId!, tak);
            _takC.clear();
            setState(() => _ingId = null);
          },
        ),
      ],
    );
  }
}
