// Skema database (drift) — sesuai tabel "Model data" di PRD.
// Stok = jumlah semua pergerakan di stock_movements (tidak ada kolom stok).
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get kategori => text().withDefault(const Constant('Lainnya'))();
  TextColumn get satuan => text().withDefault(const Constant('pcs'))();
  RealColumn get stokMin => real().withDefault(const Constant(0))();
  RealColumn get stokTarget => real().withDefault(const Constant(0))();
  IntColumn get hargaTerakhir => integer().withDefault(const Constant(0))();
  IntColumn get hargaRata2 => integer().withDefault(const Constant(0))();
  BoolColumn get aktif => boolean().withDefault(const Constant(true))();
}

class UnitConversions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  TextColumn get satuanBeli => text()();
  RealColumn get faktor => real()();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get kategori => text().withDefault(const Constant('Lainnya'))();
  IntColumn get hargaJual => integer().withDefault(const Constant(0))();
  // 'resep' = kurangi beberapa bahan, 'langsung' = 1:1 ke satu bahan
  TextColumn get tipe => text().withDefault(const Constant('resep'))();
  IntColumn get ingredientId => integer().nullable().references(Ingredients, #id)();
  BoolColumn get aktif => boolean().withDefault(const Constant(true))();
}

class RecipeItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  RealColumn get takaran => real()();
}

class Modifiers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  IntColumn get hargaTambah => integer().withDefault(const Constant(0))();
  // JSON: [{"ingredientId":1,"takaran":5}]
  TextColumn get resepTambahan => text().nullable()();
}

class Purchases extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get tanggal => dateTime()();
  TextColumn get supplier => text().nullable()();
  IntColumn get total => integer().withDefault(const Constant(0))();
  TextColumn get sumberDana => text().withDefault(const Constant('laci'))();
  TextColumn get fotoNota => text().nullable()();
}

class PurchaseItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get purchaseId => integer().references(Purchases, #id)();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  RealColumn get qty => real()();
  TextColumn get satuanBeli => text()();
  IntColumn get harga => integer()();
}

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get noHp => text().nullable()();
  IntColumn get saldoKasbon => integer().withDefault(const Constant(0))();
}

class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get waktu => dateTime()();
  IntColumn get total => integer().withDefault(const Constant(0))();
  TextColumn get metodeBayar => text().withDefault(const Constant('tunai'))();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  // lunas | hold | void
  TextColumn get status => text().withDefault(const Constant('lunas'))();
  TextColumn get meja => text().nullable()();
  TextColumn get catatan => text().nullable()();
}

class SaleItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sales, #id)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get qty => integer()();
  IntColumn get harga => integer()();
  // HPP per porsi saat transaksi — disimpan permanen (PRD)
  IntColumn get hpp => integer().withDefault(const Constant(0))();
  TextColumn get modifiers => text().nullable()();
}

class StockMovements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  // IN | OUT | ADJ | OPNAME | WASTE
  TextColumn get tipe => text()();
  RealColumn get qty => real()();
  TextColumn get refTabel => text().nullable()();
  IntColumn get refId => integer().nullable()();
  TextColumn get alasan => text().nullable()();
  DateTimeColumn get waktu => dateTime()();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get tanggal => dateTime()();
  TextColumn get kategori => text()();
  IntColumn get nominal => integer()();
  TextColumn get sumberDana => text().withDefault(const Constant('laci'))();
  TextColumn get catatan => text().nullable()();
  BoolColumn get rutin => boolean().withDefault(const Constant(false))();
}

class DebtPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  DateTimeColumn get tanggal => dateTime()();
  IntColumn get nominal => integer()();
}

class ShoppingListItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ingredientId => integer().references(Ingredients, #id)();
  RealColumn get qtySaran => real().withDefault(const Constant(0))();
  RealColumn get qtyBeli => real().nullable()();
  IntColumn get hargaAktual => integer().nullable()();
  BoolColumn get dicentang => boolean().withDefault(const Constant(false))();
}

class AppSettings extends Table {
  TextColumn get kunci => text()();
  TextColumn get nilai => text().nullable()();
  @override
  Set<Column> get primaryKey => {kunci};
}

@DriftDatabase(
  tables: [
    Ingredients,
    UnitConversions,
    Products,
    RecipeItems,
    Modifiers,
    Purchases,
    PurchaseItems,
    Customers,
    Sales,
    SaleItems,
    StockMovements,
    Expenses,
    DebtPayments,
    ShoppingListItems,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'warkop.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
