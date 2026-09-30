// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Lainnya'),
  );
  static const VerificationMeta _satuanMeta = const VerificationMeta('satuan');
  @override
  late final GeneratedColumn<String> satuan = GeneratedColumn<String>(
    'satuan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pcs'),
  );
  static const VerificationMeta _stokMinMeta = const VerificationMeta(
    'stokMin',
  );
  @override
  late final GeneratedColumn<double> stokMin = GeneratedColumn<double>(
    'stok_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stokTargetMeta = const VerificationMeta(
    'stokTarget',
  );
  @override
  late final GeneratedColumn<double> stokTarget = GeneratedColumn<double>(
    'stok_target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hargaTerakhirMeta = const VerificationMeta(
    'hargaTerakhir',
  );
  @override
  late final GeneratedColumn<int> hargaTerakhir = GeneratedColumn<int>(
    'harga_terakhir',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hargaRata2Meta = const VerificationMeta(
    'hargaRata2',
  );
  @override
  late final GeneratedColumn<int> hargaRata2 = GeneratedColumn<int>(
    'harga_rata2',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
    'aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aktif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    kategori,
    satuan,
    stokMin,
    stokTarget,
    hargaTerakhir,
    hargaRata2,
    aktif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    }
    if (data.containsKey('satuan')) {
      context.handle(
        _satuanMeta,
        satuan.isAcceptableOrUnknown(data['satuan']!, _satuanMeta),
      );
    }
    if (data.containsKey('stok_min')) {
      context.handle(
        _stokMinMeta,
        stokMin.isAcceptableOrUnknown(data['stok_min']!, _stokMinMeta),
      );
    }
    if (data.containsKey('stok_target')) {
      context.handle(
        _stokTargetMeta,
        stokTarget.isAcceptableOrUnknown(data['stok_target']!, _stokTargetMeta),
      );
    }
    if (data.containsKey('harga_terakhir')) {
      context.handle(
        _hargaTerakhirMeta,
        hargaTerakhir.isAcceptableOrUnknown(
          data['harga_terakhir']!,
          _hargaTerakhirMeta,
        ),
      );
    }
    if (data.containsKey('harga_rata2')) {
      context.handle(
        _hargaRata2Meta,
        hargaRata2.isAcceptableOrUnknown(data['harga_rata2']!, _hargaRata2Meta),
      );
    }
    if (data.containsKey('aktif')) {
      context.handle(
        _aktifMeta,
        aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      )!,
      satuan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}satuan'],
      )!,
      stokMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stok_min'],
      )!,
      stokTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stok_target'],
      )!,
      hargaTerakhir: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_terakhir'],
      )!,
      hargaRata2: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_rata2'],
      )!,
      aktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aktif'],
      )!,
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String nama;
  final String kategori;
  final String satuan;
  final double stokMin;
  final double stokTarget;
  final int hargaTerakhir;
  final int hargaRata2;
  final bool aktif;
  const Ingredient({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.satuan,
    required this.stokMin,
    required this.stokTarget,
    required this.hargaTerakhir,
    required this.hargaRata2,
    required this.aktif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['kategori'] = Variable<String>(kategori);
    map['satuan'] = Variable<String>(satuan);
    map['stok_min'] = Variable<double>(stokMin);
    map['stok_target'] = Variable<double>(stokTarget);
    map['harga_terakhir'] = Variable<int>(hargaTerakhir);
    map['harga_rata2'] = Variable<int>(hargaRata2);
    map['aktif'] = Variable<bool>(aktif);
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      nama: Value(nama),
      kategori: Value(kategori),
      satuan: Value(satuan),
      stokMin: Value(stokMin),
      stokTarget: Value(stokTarget),
      hargaTerakhir: Value(hargaTerakhir),
      hargaRata2: Value(hargaRata2),
      aktif: Value(aktif),
    );
  }

  factory Ingredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      kategori: serializer.fromJson<String>(json['kategori']),
      satuan: serializer.fromJson<String>(json['satuan']),
      stokMin: serializer.fromJson<double>(json['stokMin']),
      stokTarget: serializer.fromJson<double>(json['stokTarget']),
      hargaTerakhir: serializer.fromJson<int>(json['hargaTerakhir']),
      hargaRata2: serializer.fromJson<int>(json['hargaRata2']),
      aktif: serializer.fromJson<bool>(json['aktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'kategori': serializer.toJson<String>(kategori),
      'satuan': serializer.toJson<String>(satuan),
      'stokMin': serializer.toJson<double>(stokMin),
      'stokTarget': serializer.toJson<double>(stokTarget),
      'hargaTerakhir': serializer.toJson<int>(hargaTerakhir),
      'hargaRata2': serializer.toJson<int>(hargaRata2),
      'aktif': serializer.toJson<bool>(aktif),
    };
  }

  Ingredient copyWith({
    int? id,
    String? nama,
    String? kategori,
    String? satuan,
    double? stokMin,
    double? stokTarget,
    int? hargaTerakhir,
    int? hargaRata2,
    bool? aktif,
  }) => Ingredient(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    kategori: kategori ?? this.kategori,
    satuan: satuan ?? this.satuan,
    stokMin: stokMin ?? this.stokMin,
    stokTarget: stokTarget ?? this.stokTarget,
    hargaTerakhir: hargaTerakhir ?? this.hargaTerakhir,
    hargaRata2: hargaRata2 ?? this.hargaRata2,
    aktif: aktif ?? this.aktif,
  );
  Ingredient copyWithCompanion(IngredientsCompanion data) {
    return Ingredient(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      satuan: data.satuan.present ? data.satuan.value : this.satuan,
      stokMin: data.stokMin.present ? data.stokMin.value : this.stokMin,
      stokTarget: data.stokTarget.present
          ? data.stokTarget.value
          : this.stokTarget,
      hargaTerakhir: data.hargaTerakhir.present
          ? data.hargaTerakhir.value
          : this.hargaTerakhir,
      hargaRata2: data.hargaRata2.present
          ? data.hargaRata2.value
          : this.hargaRata2,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kategori: $kategori, ')
          ..write('satuan: $satuan, ')
          ..write('stokMin: $stokMin, ')
          ..write('stokTarget: $stokTarget, ')
          ..write('hargaTerakhir: $hargaTerakhir, ')
          ..write('hargaRata2: $hargaRata2, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nama,
    kategori,
    satuan,
    stokMin,
    stokTarget,
    hargaTerakhir,
    hargaRata2,
    aktif,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.kategori == this.kategori &&
          other.satuan == this.satuan &&
          other.stokMin == this.stokMin &&
          other.stokTarget == this.stokTarget &&
          other.hargaTerakhir == this.hargaTerakhir &&
          other.hargaRata2 == this.hargaRata2 &&
          other.aktif == this.aktif);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String> kategori;
  final Value<String> satuan;
  final Value<double> stokMin;
  final Value<double> stokTarget;
  final Value<int> hargaTerakhir;
  final Value<int> hargaRata2;
  final Value<bool> aktif;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.kategori = const Value.absent(),
    this.satuan = const Value.absent(),
    this.stokMin = const Value.absent(),
    this.stokTarget = const Value.absent(),
    this.hargaTerakhir = const Value.absent(),
    this.hargaRata2 = const Value.absent(),
    this.aktif = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.kategori = const Value.absent(),
    this.satuan = const Value.absent(),
    this.stokMin = const Value.absent(),
    this.stokTarget = const Value.absent(),
    this.hargaTerakhir = const Value.absent(),
    this.hargaRata2 = const Value.absent(),
    this.aktif = const Value.absent(),
  }) : nama = Value(nama);
  static Insertable<Ingredient> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? kategori,
    Expression<String>? satuan,
    Expression<double>? stokMin,
    Expression<double>? stokTarget,
    Expression<int>? hargaTerakhir,
    Expression<int>? hargaRata2,
    Expression<bool>? aktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (kategori != null) 'kategori': kategori,
      if (satuan != null) 'satuan': satuan,
      if (stokMin != null) 'stok_min': stokMin,
      if (stokTarget != null) 'stok_target': stokTarget,
      if (hargaTerakhir != null) 'harga_terakhir': hargaTerakhir,
      if (hargaRata2 != null) 'harga_rata2': hargaRata2,
      if (aktif != null) 'aktif': aktif,
    });
  }

  IngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String>? kategori,
    Value<String>? satuan,
    Value<double>? stokMin,
    Value<double>? stokTarget,
    Value<int>? hargaTerakhir,
    Value<int>? hargaRata2,
    Value<bool>? aktif,
  }) {
    return IngredientsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      satuan: satuan ?? this.satuan,
      stokMin: stokMin ?? this.stokMin,
      stokTarget: stokTarget ?? this.stokTarget,
      hargaTerakhir: hargaTerakhir ?? this.hargaTerakhir,
      hargaRata2: hargaRata2 ?? this.hargaRata2,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (satuan.present) {
      map['satuan'] = Variable<String>(satuan.value);
    }
    if (stokMin.present) {
      map['stok_min'] = Variable<double>(stokMin.value);
    }
    if (stokTarget.present) {
      map['stok_target'] = Variable<double>(stokTarget.value);
    }
    if (hargaTerakhir.present) {
      map['harga_terakhir'] = Variable<int>(hargaTerakhir.value);
    }
    if (hargaRata2.present) {
      map['harga_rata2'] = Variable<int>(hargaRata2.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kategori: $kategori, ')
          ..write('satuan: $satuan, ')
          ..write('stokMin: $stokMin, ')
          ..write('stokTarget: $stokTarget, ')
          ..write('hargaTerakhir: $hargaTerakhir, ')
          ..write('hargaRata2: $hargaRata2, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }
}

class $UnitConversionsTable extends UnitConversions
    with TableInfo<$UnitConversionsTable, UnitConversion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitConversionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _satuanBeliMeta = const VerificationMeta(
    'satuanBeli',
  );
  @override
  late final GeneratedColumn<String> satuanBeli = GeneratedColumn<String>(
    'satuan_beli',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _faktorMeta = const VerificationMeta('faktor');
  @override
  late final GeneratedColumn<double> faktor = GeneratedColumn<double>(
    'faktor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ingredientId, satuanBeli, faktor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unit_conversions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnitConversion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('satuan_beli')) {
      context.handle(
        _satuanBeliMeta,
        satuanBeli.isAcceptableOrUnknown(data['satuan_beli']!, _satuanBeliMeta),
      );
    } else if (isInserting) {
      context.missing(_satuanBeliMeta);
    }
    if (data.containsKey('faktor')) {
      context.handle(
        _faktorMeta,
        faktor.isAcceptableOrUnknown(data['faktor']!, _faktorMeta),
      );
    } else if (isInserting) {
      context.missing(_faktorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitConversion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitConversion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      satuanBeli: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}satuan_beli'],
      )!,
      faktor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}faktor'],
      )!,
    );
  }

  @override
  $UnitConversionsTable createAlias(String alias) {
    return $UnitConversionsTable(attachedDatabase, alias);
  }
}

class UnitConversion extends DataClass implements Insertable<UnitConversion> {
  final int id;
  final int ingredientId;
  final String satuanBeli;
  final double faktor;
  const UnitConversion({
    required this.id,
    required this.ingredientId,
    required this.satuanBeli,
    required this.faktor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['satuan_beli'] = Variable<String>(satuanBeli);
    map['faktor'] = Variable<double>(faktor);
    return map;
  }

  UnitConversionsCompanion toCompanion(bool nullToAbsent) {
    return UnitConversionsCompanion(
      id: Value(id),
      ingredientId: Value(ingredientId),
      satuanBeli: Value(satuanBeli),
      faktor: Value(faktor),
    );
  }

  factory UnitConversion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitConversion(
      id: serializer.fromJson<int>(json['id']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      satuanBeli: serializer.fromJson<String>(json['satuanBeli']),
      faktor: serializer.fromJson<double>(json['faktor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'satuanBeli': serializer.toJson<String>(satuanBeli),
      'faktor': serializer.toJson<double>(faktor),
    };
  }

  UnitConversion copyWith({
    int? id,
    int? ingredientId,
    String? satuanBeli,
    double? faktor,
  }) => UnitConversion(
    id: id ?? this.id,
    ingredientId: ingredientId ?? this.ingredientId,
    satuanBeli: satuanBeli ?? this.satuanBeli,
    faktor: faktor ?? this.faktor,
  );
  UnitConversion copyWithCompanion(UnitConversionsCompanion data) {
    return UnitConversion(
      id: data.id.present ? data.id.value : this.id,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      satuanBeli: data.satuanBeli.present
          ? data.satuanBeli.value
          : this.satuanBeli,
      faktor: data.faktor.present ? data.faktor.value : this.faktor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitConversion(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('satuanBeli: $satuanBeli, ')
          ..write('faktor: $faktor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ingredientId, satuanBeli, faktor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitConversion &&
          other.id == this.id &&
          other.ingredientId == this.ingredientId &&
          other.satuanBeli == this.satuanBeli &&
          other.faktor == this.faktor);
}

class UnitConversionsCompanion extends UpdateCompanion<UnitConversion> {
  final Value<int> id;
  final Value<int> ingredientId;
  final Value<String> satuanBeli;
  final Value<double> faktor;
  const UnitConversionsCompanion({
    this.id = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.satuanBeli = const Value.absent(),
    this.faktor = const Value.absent(),
  });
  UnitConversionsCompanion.insert({
    this.id = const Value.absent(),
    required int ingredientId,
    required String satuanBeli,
    required double faktor,
  }) : ingredientId = Value(ingredientId),
       satuanBeli = Value(satuanBeli),
       faktor = Value(faktor);
  static Insertable<UnitConversion> custom({
    Expression<int>? id,
    Expression<int>? ingredientId,
    Expression<String>? satuanBeli,
    Expression<double>? faktor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (satuanBeli != null) 'satuan_beli': satuanBeli,
      if (faktor != null) 'faktor': faktor,
    });
  }

  UnitConversionsCompanion copyWith({
    Value<int>? id,
    Value<int>? ingredientId,
    Value<String>? satuanBeli,
    Value<double>? faktor,
  }) {
    return UnitConversionsCompanion(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      satuanBeli: satuanBeli ?? this.satuanBeli,
      faktor: faktor ?? this.faktor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (satuanBeli.present) {
      map['satuan_beli'] = Variable<String>(satuanBeli.value);
    }
    if (faktor.present) {
      map['faktor'] = Variable<double>(faktor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitConversionsCompanion(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('satuanBeli: $satuanBeli, ')
          ..write('faktor: $faktor')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Lainnya'),
  );
  static const VerificationMeta _hargaJualMeta = const VerificationMeta(
    'hargaJual',
  );
  @override
  late final GeneratedColumn<int> hargaJual = GeneratedColumn<int>(
    'harga_jual',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tipeMeta = const VerificationMeta('tipe');
  @override
  late final GeneratedColumn<String> tipe = GeneratedColumn<String>(
    'tipe',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('resep'),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
    'aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aktif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    kategori,
    hargaJual,
    tipe,
    ingredientId,
    aktif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    }
    if (data.containsKey('harga_jual')) {
      context.handle(
        _hargaJualMeta,
        hargaJual.isAcceptableOrUnknown(data['harga_jual']!, _hargaJualMeta),
      );
    }
    if (data.containsKey('tipe')) {
      context.handle(
        _tipeMeta,
        tipe.isAcceptableOrUnknown(data['tipe']!, _tipeMeta),
      );
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('aktif')) {
      context.handle(
        _aktifMeta,
        aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      )!,
      hargaJual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_jual'],
      )!,
      tipe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipe'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      ),
      aktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aktif'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String nama;
  final String kategori;
  final int hargaJual;
  final String tipe;
  final int? ingredientId;
  final bool aktif;
  const Product({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.hargaJual,
    required this.tipe,
    this.ingredientId,
    required this.aktif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['kategori'] = Variable<String>(kategori);
    map['harga_jual'] = Variable<int>(hargaJual);
    map['tipe'] = Variable<String>(tipe);
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<int>(ingredientId);
    }
    map['aktif'] = Variable<bool>(aktif);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      nama: Value(nama),
      kategori: Value(kategori),
      hargaJual: Value(hargaJual),
      tipe: Value(tipe),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      aktif: Value(aktif),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      kategori: serializer.fromJson<String>(json['kategori']),
      hargaJual: serializer.fromJson<int>(json['hargaJual']),
      tipe: serializer.fromJson<String>(json['tipe']),
      ingredientId: serializer.fromJson<int?>(json['ingredientId']),
      aktif: serializer.fromJson<bool>(json['aktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'kategori': serializer.toJson<String>(kategori),
      'hargaJual': serializer.toJson<int>(hargaJual),
      'tipe': serializer.toJson<String>(tipe),
      'ingredientId': serializer.toJson<int?>(ingredientId),
      'aktif': serializer.toJson<bool>(aktif),
    };
  }

  Product copyWith({
    int? id,
    String? nama,
    String? kategori,
    int? hargaJual,
    String? tipe,
    Value<int?> ingredientId = const Value.absent(),
    bool? aktif,
  }) => Product(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    kategori: kategori ?? this.kategori,
    hargaJual: hargaJual ?? this.hargaJual,
    tipe: tipe ?? this.tipe,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    aktif: aktif ?? this.aktif,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      hargaJual: data.hargaJual.present ? data.hargaJual.value : this.hargaJual,
      tipe: data.tipe.present ? data.tipe.value : this.tipe,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kategori: $kategori, ')
          ..write('hargaJual: $hargaJual, ')
          ..write('tipe: $tipe, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nama, kategori, hargaJual, tipe, ingredientId, aktif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.kategori == this.kategori &&
          other.hargaJual == this.hargaJual &&
          other.tipe == this.tipe &&
          other.ingredientId == this.ingredientId &&
          other.aktif == this.aktif);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String> kategori;
  final Value<int> hargaJual;
  final Value<String> tipe;
  final Value<int?> ingredientId;
  final Value<bool> aktif;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.kategori = const Value.absent(),
    this.hargaJual = const Value.absent(),
    this.tipe = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.aktif = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.kategori = const Value.absent(),
    this.hargaJual = const Value.absent(),
    this.tipe = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.aktif = const Value.absent(),
  }) : nama = Value(nama);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? kategori,
    Expression<int>? hargaJual,
    Expression<String>? tipe,
    Expression<int>? ingredientId,
    Expression<bool>? aktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (kategori != null) 'kategori': kategori,
      if (hargaJual != null) 'harga_jual': hargaJual,
      if (tipe != null) 'tipe': tipe,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (aktif != null) 'aktif': aktif,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String>? kategori,
    Value<int>? hargaJual,
    Value<String>? tipe,
    Value<int?>? ingredientId,
    Value<bool>? aktif,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      hargaJual: hargaJual ?? this.hargaJual,
      tipe: tipe ?? this.tipe,
      ingredientId: ingredientId ?? this.ingredientId,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (hargaJual.present) {
      map['harga_jual'] = Variable<int>(hargaJual.value);
    }
    if (tipe.present) {
      map['tipe'] = Variable<String>(tipe.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kategori: $kategori, ')
          ..write('hargaJual: $hargaJual, ')
          ..write('tipe: $tipe, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }
}

class $RecipeItemsTable extends RecipeItems
    with TableInfo<$RecipeItemsTable, RecipeItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takaranMeta = const VerificationMeta(
    'takaran',
  );
  @override
  late final GeneratedColumn<double> takaran = GeneratedColumn<double>(
    'takaran',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, productId, ingredientId, takaran];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('takaran')) {
      context.handle(
        _takaranMeta,
        takaran.isAcceptableOrUnknown(data['takaran']!, _takaranMeta),
      );
    } else if (isInserting) {
      context.missing(_takaranMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      takaran: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}takaran'],
      )!,
    );
  }

  @override
  $RecipeItemsTable createAlias(String alias) {
    return $RecipeItemsTable(attachedDatabase, alias);
  }
}

class RecipeItem extends DataClass implements Insertable<RecipeItem> {
  final int id;
  final int productId;
  final int ingredientId;
  final double takaran;
  const RecipeItem({
    required this.id,
    required this.productId,
    required this.ingredientId,
    required this.takaran,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['takaran'] = Variable<double>(takaran);
    return map;
  }

  RecipeItemsCompanion toCompanion(bool nullToAbsent) {
    return RecipeItemsCompanion(
      id: Value(id),
      productId: Value(productId),
      ingredientId: Value(ingredientId),
      takaran: Value(takaran),
    );
  }

  factory RecipeItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeItem(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      takaran: serializer.fromJson<double>(json['takaran']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'takaran': serializer.toJson<double>(takaran),
    };
  }

  RecipeItem copyWith({
    int? id,
    int? productId,
    int? ingredientId,
    double? takaran,
  }) => RecipeItem(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    ingredientId: ingredientId ?? this.ingredientId,
    takaran: takaran ?? this.takaran,
  );
  RecipeItem copyWithCompanion(RecipeItemsCompanion data) {
    return RecipeItem(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      takaran: data.takaran.present ? data.takaran.value : this.takaran,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeItem(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('takaran: $takaran')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, ingredientId, takaran);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeItem &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.ingredientId == this.ingredientId &&
          other.takaran == this.takaran);
}

class RecipeItemsCompanion extends UpdateCompanion<RecipeItem> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> ingredientId;
  final Value<double> takaran;
  const RecipeItemsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.takaran = const Value.absent(),
  });
  RecipeItemsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int ingredientId,
    required double takaran,
  }) : productId = Value(productId),
       ingredientId = Value(ingredientId),
       takaran = Value(takaran);
  static Insertable<RecipeItem> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? ingredientId,
    Expression<double>? takaran,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (takaran != null) 'takaran': takaran,
    });
  }

  RecipeItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? ingredientId,
    Value<double>? takaran,
  }) {
    return RecipeItemsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      ingredientId: ingredientId ?? this.ingredientId,
      takaran: takaran ?? this.takaran,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (takaran.present) {
      map['takaran'] = Variable<double>(takaran.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeItemsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('takaran: $takaran')
          ..write(')'))
        .toString();
  }
}

class $ModifiersTable extends Modifiers
    with TableInfo<$ModifiersTable, Modifier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModifiersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaTambahMeta = const VerificationMeta(
    'hargaTambah',
  );
  @override
  late final GeneratedColumn<int> hargaTambah = GeneratedColumn<int>(
    'harga_tambah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _resepTambahanMeta = const VerificationMeta(
    'resepTambahan',
  );
  @override
  late final GeneratedColumn<String> resepTambahan = GeneratedColumn<String>(
    'resep_tambahan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nama, hargaTambah, resepTambahan];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'modifiers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Modifier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('harga_tambah')) {
      context.handle(
        _hargaTambahMeta,
        hargaTambah.isAcceptableOrUnknown(
          data['harga_tambah']!,
          _hargaTambahMeta,
        ),
      );
    }
    if (data.containsKey('resep_tambahan')) {
      context.handle(
        _resepTambahanMeta,
        resepTambahan.isAcceptableOrUnknown(
          data['resep_tambahan']!,
          _resepTambahanMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Modifier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Modifier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      hargaTambah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_tambah'],
      )!,
      resepTambahan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resep_tambahan'],
      ),
    );
  }

  @override
  $ModifiersTable createAlias(String alias) {
    return $ModifiersTable(attachedDatabase, alias);
  }
}

class Modifier extends DataClass implements Insertable<Modifier> {
  final int id;
  final String nama;
  final int hargaTambah;
  final String? resepTambahan;
  const Modifier({
    required this.id,
    required this.nama,
    required this.hargaTambah,
    this.resepTambahan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['harga_tambah'] = Variable<int>(hargaTambah);
    if (!nullToAbsent || resepTambahan != null) {
      map['resep_tambahan'] = Variable<String>(resepTambahan);
    }
    return map;
  }

  ModifiersCompanion toCompanion(bool nullToAbsent) {
    return ModifiersCompanion(
      id: Value(id),
      nama: Value(nama),
      hargaTambah: Value(hargaTambah),
      resepTambahan: resepTambahan == null && nullToAbsent
          ? const Value.absent()
          : Value(resepTambahan),
    );
  }

  factory Modifier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Modifier(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      hargaTambah: serializer.fromJson<int>(json['hargaTambah']),
      resepTambahan: serializer.fromJson<String?>(json['resepTambahan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'hargaTambah': serializer.toJson<int>(hargaTambah),
      'resepTambahan': serializer.toJson<String?>(resepTambahan),
    };
  }

  Modifier copyWith({
    int? id,
    String? nama,
    int? hargaTambah,
    Value<String?> resepTambahan = const Value.absent(),
  }) => Modifier(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    hargaTambah: hargaTambah ?? this.hargaTambah,
    resepTambahan: resepTambahan.present
        ? resepTambahan.value
        : this.resepTambahan,
  );
  Modifier copyWithCompanion(ModifiersCompanion data) {
    return Modifier(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      hargaTambah: data.hargaTambah.present
          ? data.hargaTambah.value
          : this.hargaTambah,
      resepTambahan: data.resepTambahan.present
          ? data.resepTambahan.value
          : this.resepTambahan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Modifier(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('hargaTambah: $hargaTambah, ')
          ..write('resepTambahan: $resepTambahan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, hargaTambah, resepTambahan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Modifier &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.hargaTambah == this.hargaTambah &&
          other.resepTambahan == this.resepTambahan);
}

class ModifiersCompanion extends UpdateCompanion<Modifier> {
  final Value<int> id;
  final Value<String> nama;
  final Value<int> hargaTambah;
  final Value<String?> resepTambahan;
  const ModifiersCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.hargaTambah = const Value.absent(),
    this.resepTambahan = const Value.absent(),
  });
  ModifiersCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.hargaTambah = const Value.absent(),
    this.resepTambahan = const Value.absent(),
  }) : nama = Value(nama);
  static Insertable<Modifier> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<int>? hargaTambah,
    Expression<String>? resepTambahan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (hargaTambah != null) 'harga_tambah': hargaTambah,
      if (resepTambahan != null) 'resep_tambahan': resepTambahan,
    });
  }

  ModifiersCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<int>? hargaTambah,
    Value<String?>? resepTambahan,
  }) {
    return ModifiersCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      hargaTambah: hargaTambah ?? this.hargaTambah,
      resepTambahan: resepTambahan ?? this.resepTambahan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (hargaTambah.present) {
      map['harga_tambah'] = Variable<int>(hargaTambah.value);
    }
    if (resepTambahan.present) {
      map['resep_tambahan'] = Variable<String>(resepTambahan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModifiersCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('hargaTambah: $hargaTambah, ')
          ..write('resepTambahan: $resepTambahan')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierMeta = const VerificationMeta(
    'supplier',
  );
  @override
  late final GeneratedColumn<String> supplier = GeneratedColumn<String>(
    'supplier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sumberDanaMeta = const VerificationMeta(
    'sumberDana',
  );
  @override
  late final GeneratedColumn<String> sumberDana = GeneratedColumn<String>(
    'sumber_dana',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('laci'),
  );
  static const VerificationMeta _fotoNotaMeta = const VerificationMeta(
    'fotoNota',
  );
  @override
  late final GeneratedColumn<String> fotoNota = GeneratedColumn<String>(
    'foto_nota',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tanggal,
    supplier,
    total,
    sumberDana,
    fotoNota,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Purchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('supplier')) {
      context.handle(
        _supplierMeta,
        supplier.isAcceptableOrUnknown(data['supplier']!, _supplierMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('sumber_dana')) {
      context.handle(
        _sumberDanaMeta,
        sumberDana.isAcceptableOrUnknown(data['sumber_dana']!, _sumberDanaMeta),
      );
    }
    if (data.containsKey('foto_nota')) {
      context.handle(
        _fotoNotaMeta,
        fotoNota.isAcceptableOrUnknown(data['foto_nota']!, _fotoNotaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      supplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier'],
      ),
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      sumberDana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sumber_dana'],
      )!,
      fotoNota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foto_nota'],
      ),
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final int id;
  final DateTime tanggal;
  final String? supplier;
  final int total;
  final String sumberDana;
  final String? fotoNota;
  const Purchase({
    required this.id,
    required this.tanggal,
    this.supplier,
    required this.total,
    required this.sumberDana,
    this.fotoNota,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tanggal'] = Variable<DateTime>(tanggal);
    if (!nullToAbsent || supplier != null) {
      map['supplier'] = Variable<String>(supplier);
    }
    map['total'] = Variable<int>(total);
    map['sumber_dana'] = Variable<String>(sumberDana);
    if (!nullToAbsent || fotoNota != null) {
      map['foto_nota'] = Variable<String>(fotoNota);
    }
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      tanggal: Value(tanggal),
      supplier: supplier == null && nullToAbsent
          ? const Value.absent()
          : Value(supplier),
      total: Value(total),
      sumberDana: Value(sumberDana),
      fotoNota: fotoNota == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoNota),
    );
  }

  factory Purchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<int>(json['id']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      supplier: serializer.fromJson<String?>(json['supplier']),
      total: serializer.fromJson<int>(json['total']),
      sumberDana: serializer.fromJson<String>(json['sumberDana']),
      fotoNota: serializer.fromJson<String?>(json['fotoNota']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'supplier': serializer.toJson<String?>(supplier),
      'total': serializer.toJson<int>(total),
      'sumberDana': serializer.toJson<String>(sumberDana),
      'fotoNota': serializer.toJson<String?>(fotoNota),
    };
  }

  Purchase copyWith({
    int? id,
    DateTime? tanggal,
    Value<String?> supplier = const Value.absent(),
    int? total,
    String? sumberDana,
    Value<String?> fotoNota = const Value.absent(),
  }) => Purchase(
    id: id ?? this.id,
    tanggal: tanggal ?? this.tanggal,
    supplier: supplier.present ? supplier.value : this.supplier,
    total: total ?? this.total,
    sumberDana: sumberDana ?? this.sumberDana,
    fotoNota: fotoNota.present ? fotoNota.value : this.fotoNota,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      supplier: data.supplier.present ? data.supplier.value : this.supplier,
      total: data.total.present ? data.total.value : this.total,
      sumberDana: data.sumberDana.present
          ? data.sumberDana.value
          : this.sumberDana,
      fotoNota: data.fotoNota.present ? data.fotoNota.value : this.fotoNota,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('tanggal: $tanggal, ')
          ..write('supplier: $supplier, ')
          ..write('total: $total, ')
          ..write('sumberDana: $sumberDana, ')
          ..write('fotoNota: $fotoNota')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tanggal, supplier, total, sumberDana, fotoNota);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.tanggal == this.tanggal &&
          other.supplier == this.supplier &&
          other.total == this.total &&
          other.sumberDana == this.sumberDana &&
          other.fotoNota == this.fotoNota);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<int> id;
  final Value<DateTime> tanggal;
  final Value<String?> supplier;
  final Value<int> total;
  final Value<String> sumberDana;
  final Value<String?> fotoNota;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.supplier = const Value.absent(),
    this.total = const Value.absent(),
    this.sumberDana = const Value.absent(),
    this.fotoNota = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime tanggal,
    this.supplier = const Value.absent(),
    this.total = const Value.absent(),
    this.sumberDana = const Value.absent(),
    this.fotoNota = const Value.absent(),
  }) : tanggal = Value(tanggal);
  static Insertable<Purchase> custom({
    Expression<int>? id,
    Expression<DateTime>? tanggal,
    Expression<String>? supplier,
    Expression<int>? total,
    Expression<String>? sumberDana,
    Expression<String>? fotoNota,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tanggal != null) 'tanggal': tanggal,
      if (supplier != null) 'supplier': supplier,
      if (total != null) 'total': total,
      if (sumberDana != null) 'sumber_dana': sumberDana,
      if (fotoNota != null) 'foto_nota': fotoNota,
    });
  }

  PurchasesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? tanggal,
    Value<String?>? supplier,
    Value<int>? total,
    Value<String>? sumberDana,
    Value<String?>? fotoNota,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      supplier: supplier ?? this.supplier,
      total: total ?? this.total,
      sumberDana: sumberDana ?? this.sumberDana,
      fotoNota: fotoNota ?? this.fotoNota,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (supplier.present) {
      map['supplier'] = Variable<String>(supplier.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (sumberDana.present) {
      map['sumber_dana'] = Variable<String>(sumberDana.value);
    }
    if (fotoNota.present) {
      map['foto_nota'] = Variable<String>(fotoNota.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('tanggal: $tanggal, ')
          ..write('supplier: $supplier, ')
          ..write('total: $total, ')
          ..write('sumberDana: $sumberDana, ')
          ..write('fotoNota: $fotoNota')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _satuanBeliMeta = const VerificationMeta(
    'satuanBeli',
  );
  @override
  late final GeneratedColumn<String> satuanBeli = GeneratedColumn<String>(
    'satuan_beli',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<int> harga = GeneratedColumn<int>(
    'harga',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    ingredientId,
    qty,
    satuanBeli,
    harga,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('satuan_beli')) {
      context.handle(
        _satuanBeliMeta,
        satuanBeli.isAcceptableOrUnknown(data['satuan_beli']!, _satuanBeliMeta),
      );
    } else if (isInserting) {
      context.missing(_satuanBeliMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
        _hargaMeta,
        harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      satuanBeli: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}satuan_beli'],
      )!,
      harga: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga'],
      )!,
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final int id;
  final int purchaseId;
  final int ingredientId;
  final double qty;
  final String satuanBeli;
  final int harga;
  const PurchaseItem({
    required this.id,
    required this.purchaseId,
    required this.ingredientId,
    required this.qty,
    required this.satuanBeli,
    required this.harga,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['qty'] = Variable<double>(qty);
    map['satuan_beli'] = Variable<String>(satuanBeli);
    map['harga'] = Variable<int>(harga);
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      ingredientId: Value(ingredientId),
      qty: Value(qty),
      satuanBeli: Value(satuanBeli),
      harga: Value(harga),
    );
  }

  factory PurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      qty: serializer.fromJson<double>(json['qty']),
      satuanBeli: serializer.fromJson<String>(json['satuanBeli']),
      harga: serializer.fromJson<int>(json['harga']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'qty': serializer.toJson<double>(qty),
      'satuanBeli': serializer.toJson<String>(satuanBeli),
      'harga': serializer.toJson<int>(harga),
    };
  }

  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    int? ingredientId,
    double? qty,
    String? satuanBeli,
    int? harga,
  }) => PurchaseItem(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    ingredientId: ingredientId ?? this.ingredientId,
    qty: qty ?? this.qty,
    satuanBeli: satuanBeli ?? this.satuanBeli,
    harga: harga ?? this.harga,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      qty: data.qty.present ? data.qty.value : this.qty,
      satuanBeli: data.satuanBeli.present
          ? data.satuanBeli.value
          : this.satuanBeli,
      harga: data.harga.present ? data.harga.value : this.harga,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('qty: $qty, ')
          ..write('satuanBeli: $satuanBeli, ')
          ..write('harga: $harga')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, purchaseId, ingredientId, qty, satuanBeli, harga);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.ingredientId == this.ingredientId &&
          other.qty == this.qty &&
          other.satuanBeli == this.satuanBeli &&
          other.harga == this.harga);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<int> ingredientId;
  final Value<double> qty;
  final Value<String> satuanBeli;
  final Value<int> harga;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.qty = const Value.absent(),
    this.satuanBeli = const Value.absent(),
    this.harga = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required int ingredientId,
    required double qty,
    required String satuanBeli,
    required int harga,
  }) : purchaseId = Value(purchaseId),
       ingredientId = Value(ingredientId),
       qty = Value(qty),
       satuanBeli = Value(satuanBeli),
       harga = Value(harga);
  static Insertable<PurchaseItem> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<int>? ingredientId,
    Expression<double>? qty,
    Expression<String>? satuanBeli,
    Expression<int>? harga,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (qty != null) 'qty': qty,
      if (satuanBeli != null) 'satuan_beli': satuanBeli,
      if (harga != null) 'harga': harga,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<int>? ingredientId,
    Value<double>? qty,
    Value<String>? satuanBeli,
    Value<int>? harga,
  }) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      ingredientId: ingredientId ?? this.ingredientId,
      qty: qty ?? this.qty,
      satuanBeli: satuanBeli ?? this.satuanBeli,
      harga: harga ?? this.harga,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (satuanBeli.present) {
      map['satuan_beli'] = Variable<String>(satuanBeli.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('qty: $qty, ')
          ..write('satuanBeli: $satuanBeli, ')
          ..write('harga: $harga')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noHpMeta = const VerificationMeta('noHp');
  @override
  late final GeneratedColumn<String> noHp = GeneratedColumn<String>(
    'no_hp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saldoKasbonMeta = const VerificationMeta(
    'saldoKasbon',
  );
  @override
  late final GeneratedColumn<int> saldoKasbon = GeneratedColumn<int>(
    'saldo_kasbon',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nama, noHp, saldoKasbon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('no_hp')) {
      context.handle(
        _noHpMeta,
        noHp.isAcceptableOrUnknown(data['no_hp']!, _noHpMeta),
      );
    }
    if (data.containsKey('saldo_kasbon')) {
      context.handle(
        _saldoKasbonMeta,
        saldoKasbon.isAcceptableOrUnknown(
          data['saldo_kasbon']!,
          _saldoKasbonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      noHp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}no_hp'],
      ),
      saldoKasbon: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_kasbon'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String nama;
  final String? noHp;
  final int saldoKasbon;
  const Customer({
    required this.id,
    required this.nama,
    this.noHp,
    required this.saldoKasbon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || noHp != null) {
      map['no_hp'] = Variable<String>(noHp);
    }
    map['saldo_kasbon'] = Variable<int>(saldoKasbon);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      nama: Value(nama),
      noHp: noHp == null && nullToAbsent ? const Value.absent() : Value(noHp),
      saldoKasbon: Value(saldoKasbon),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      noHp: serializer.fromJson<String?>(json['noHp']),
      saldoKasbon: serializer.fromJson<int>(json['saldoKasbon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'noHp': serializer.toJson<String?>(noHp),
      'saldoKasbon': serializer.toJson<int>(saldoKasbon),
    };
  }

  Customer copyWith({
    int? id,
    String? nama,
    Value<String?> noHp = const Value.absent(),
    int? saldoKasbon,
  }) => Customer(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    noHp: noHp.present ? noHp.value : this.noHp,
    saldoKasbon: saldoKasbon ?? this.saldoKasbon,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      noHp: data.noHp.present ? data.noHp.value : this.noHp,
      saldoKasbon: data.saldoKasbon.present
          ? data.saldoKasbon.value
          : this.saldoKasbon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('noHp: $noHp, ')
          ..write('saldoKasbon: $saldoKasbon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, noHp, saldoKasbon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.noHp == this.noHp &&
          other.saldoKasbon == this.saldoKasbon);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String?> noHp;
  final Value<int> saldoKasbon;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.noHp = const Value.absent(),
    this.saldoKasbon = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.noHp = const Value.absent(),
    this.saldoKasbon = const Value.absent(),
  }) : nama = Value(nama);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? noHp,
    Expression<int>? saldoKasbon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (noHp != null) 'no_hp': noHp,
      if (saldoKasbon != null) 'saldo_kasbon': saldoKasbon,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String?>? noHp,
    Value<int>? saldoKasbon,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      noHp: noHp ?? this.noHp,
      saldoKasbon: saldoKasbon ?? this.saldoKasbon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (noHp.present) {
      map['no_hp'] = Variable<String>(noHp.value);
    }
    if (saldoKasbon.present) {
      map['saldo_kasbon'] = Variable<int>(saldoKasbon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('noHp: $noHp, ')
          ..write('saldoKasbon: $saldoKasbon')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _metodeBayarMeta = const VerificationMeta(
    'metodeBayar',
  );
  @override
  late final GeneratedColumn<String> metodeBayar = GeneratedColumn<String>(
    'metode_bayar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('tunai'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('lunas'),
  );
  static const VerificationMeta _mejaMeta = const VerificationMeta('meja');
  @override
  late final GeneratedColumn<String> meja = GeneratedColumn<String>(
    'meja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    waktu,
    total,
    metodeBayar,
    customerId,
    status,
    meja,
    catatan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('metode_bayar')) {
      context.handle(
        _metodeBayarMeta,
        metodeBayar.isAcceptableOrUnknown(
          data['metode_bayar']!,
          _metodeBayarMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('meja')) {
      context.handle(
        _mejaMeta,
        meja.isAcceptableOrUnknown(data['meja']!, _mejaMeta),
      );
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      metodeBayar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metode_bayar'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      meja: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meja'],
      ),
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final DateTime waktu;
  final int total;
  final String metodeBayar;
  final int? customerId;
  final String status;
  final String? meja;
  final String? catatan;
  const Sale({
    required this.id,
    required this.waktu,
    required this.total,
    required this.metodeBayar,
    this.customerId,
    required this.status,
    this.meja,
    this.catatan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['waktu'] = Variable<DateTime>(waktu);
    map['total'] = Variable<int>(total);
    map['metode_bayar'] = Variable<String>(metodeBayar);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || meja != null) {
      map['meja'] = Variable<String>(meja);
    }
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      waktu: Value(waktu),
      total: Value(total),
      metodeBayar: Value(metodeBayar),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      status: Value(status),
      meja: meja == null && nullToAbsent ? const Value.absent() : Value(meja),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
      total: serializer.fromJson<int>(json['total']),
      metodeBayar: serializer.fromJson<String>(json['metodeBayar']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      status: serializer.fromJson<String>(json['status']),
      meja: serializer.fromJson<String?>(json['meja']),
      catatan: serializer.fromJson<String?>(json['catatan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'waktu': serializer.toJson<DateTime>(waktu),
      'total': serializer.toJson<int>(total),
      'metodeBayar': serializer.toJson<String>(metodeBayar),
      'customerId': serializer.toJson<int?>(customerId),
      'status': serializer.toJson<String>(status),
      'meja': serializer.toJson<String?>(meja),
      'catatan': serializer.toJson<String?>(catatan),
    };
  }

  Sale copyWith({
    int? id,
    DateTime? waktu,
    int? total,
    String? metodeBayar,
    Value<int?> customerId = const Value.absent(),
    String? status,
    Value<String?> meja = const Value.absent(),
    Value<String?> catatan = const Value.absent(),
  }) => Sale(
    id: id ?? this.id,
    waktu: waktu ?? this.waktu,
    total: total ?? this.total,
    metodeBayar: metodeBayar ?? this.metodeBayar,
    customerId: customerId.present ? customerId.value : this.customerId,
    status: status ?? this.status,
    meja: meja.present ? meja.value : this.meja,
    catatan: catatan.present ? catatan.value : this.catatan,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
      total: data.total.present ? data.total.value : this.total,
      metodeBayar: data.metodeBayar.present
          ? data.metodeBayar.value
          : this.metodeBayar,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      status: data.status.present ? data.status.value : this.status,
      meja: data.meja.present ? data.meja.value : this.meja,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('waktu: $waktu, ')
          ..write('total: $total, ')
          ..write('metodeBayar: $metodeBayar, ')
          ..write('customerId: $customerId, ')
          ..write('status: $status, ')
          ..write('meja: $meja, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    waktu,
    total,
    metodeBayar,
    customerId,
    status,
    meja,
    catatan,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.waktu == this.waktu &&
          other.total == this.total &&
          other.metodeBayar == this.metodeBayar &&
          other.customerId == this.customerId &&
          other.status == this.status &&
          other.meja == this.meja &&
          other.catatan == this.catatan);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<DateTime> waktu;
  final Value<int> total;
  final Value<String> metodeBayar;
  final Value<int?> customerId;
  final Value<String> status;
  final Value<String?> meja;
  final Value<String?> catatan;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.waktu = const Value.absent(),
    this.total = const Value.absent(),
    this.metodeBayar = const Value.absent(),
    this.customerId = const Value.absent(),
    this.status = const Value.absent(),
    this.meja = const Value.absent(),
    this.catatan = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime waktu,
    this.total = const Value.absent(),
    this.metodeBayar = const Value.absent(),
    this.customerId = const Value.absent(),
    this.status = const Value.absent(),
    this.meja = const Value.absent(),
    this.catatan = const Value.absent(),
  }) : waktu = Value(waktu);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<DateTime>? waktu,
    Expression<int>? total,
    Expression<String>? metodeBayar,
    Expression<int>? customerId,
    Expression<String>? status,
    Expression<String>? meja,
    Expression<String>? catatan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (waktu != null) 'waktu': waktu,
      if (total != null) 'total': total,
      if (metodeBayar != null) 'metode_bayar': metodeBayar,
      if (customerId != null) 'customer_id': customerId,
      if (status != null) 'status': status,
      if (meja != null) 'meja': meja,
      if (catatan != null) 'catatan': catatan,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? waktu,
    Value<int>? total,
    Value<String>? metodeBayar,
    Value<int?>? customerId,
    Value<String>? status,
    Value<String?>? meja,
    Value<String?>? catatan,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      waktu: waktu ?? this.waktu,
      total: total ?? this.total,
      metodeBayar: metodeBayar ?? this.metodeBayar,
      customerId: customerId ?? this.customerId,
      status: status ?? this.status,
      meja: meja ?? this.meja,
      catatan: catatan ?? this.catatan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (metodeBayar.present) {
      map['metode_bayar'] = Variable<String>(metodeBayar.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (meja.present) {
      map['meja'] = Variable<String>(meja.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('waktu: $waktu, ')
          ..write('total: $total, ')
          ..write('metodeBayar: $metodeBayar, ')
          ..write('customerId: $customerId, ')
          ..write('status: $status, ')
          ..write('meja: $meja, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<int> harga = GeneratedColumn<int>(
    'harga',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hppMeta = const VerificationMeta('hpp');
  @override
  late final GeneratedColumn<int> hpp = GeneratedColumn<int>(
    'hpp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _modifiersMeta = const VerificationMeta(
    'modifiers',
  );
  @override
  late final GeneratedColumn<String> modifiers = GeneratedColumn<String>(
    'modifiers',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    productId,
    qty,
    harga,
    hpp,
    modifiers,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
        _hargaMeta,
        harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    if (data.containsKey('hpp')) {
      context.handle(
        _hppMeta,
        hpp.isAcceptableOrUnknown(data['hpp']!, _hppMeta),
      );
    }
    if (data.containsKey('modifiers')) {
      context.handle(
        _modifiersMeta,
        modifiers.isAcceptableOrUnknown(data['modifiers']!, _modifiersMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      harga: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga'],
      )!,
      hpp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hpp'],
      )!,
      modifiers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modifiers'],
      ),
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final int id;
  final int saleId;
  final int productId;
  final int qty;
  final int harga;
  final int hpp;
  final String? modifiers;
  const SaleItem({
    required this.id,
    required this.saleId,
    required this.productId,
    required this.qty,
    required this.harga,
    required this.hpp,
    this.modifiers,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['product_id'] = Variable<int>(productId);
    map['qty'] = Variable<int>(qty);
    map['harga'] = Variable<int>(harga);
    map['hpp'] = Variable<int>(hpp);
    if (!nullToAbsent || modifiers != null) {
      map['modifiers'] = Variable<String>(modifiers);
    }
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productId: Value(productId),
      qty: Value(qty),
      harga: Value(harga),
      hpp: Value(hpp),
      modifiers: modifiers == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiers),
    );
  }

  factory SaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      productId: serializer.fromJson<int>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
      harga: serializer.fromJson<int>(json['harga']),
      hpp: serializer.fromJson<int>(json['hpp']),
      modifiers: serializer.fromJson<String?>(json['modifiers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'productId': serializer.toJson<int>(productId),
      'qty': serializer.toJson<int>(qty),
      'harga': serializer.toJson<int>(harga),
      'hpp': serializer.toJson<int>(hpp),
      'modifiers': serializer.toJson<String?>(modifiers),
    };
  }

  SaleItem copyWith({
    int? id,
    int? saleId,
    int? productId,
    int? qty,
    int? harga,
    int? hpp,
    Value<String?> modifiers = const Value.absent(),
  }) => SaleItem(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    harga: harga ?? this.harga,
    hpp: hpp ?? this.hpp,
    modifiers: modifiers.present ? modifiers.value : this.modifiers,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      harga: data.harga.present ? data.harga.value : this.harga,
      hpp: data.hpp.present ? data.hpp.value : this.hpp,
      modifiers: data.modifiers.present ? data.modifiers.value : this.modifiers,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('harga: $harga, ')
          ..write('hpp: $hpp, ')
          ..write('modifiers: $modifiers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, saleId, productId, qty, harga, hpp, modifiers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.harga == this.harga &&
          other.hpp == this.hpp &&
          other.modifiers == this.modifiers);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<int> productId;
  final Value<int> qty;
  final Value<int> harga;
  final Value<int> hpp;
  final Value<String?> modifiers;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.harga = const Value.absent(),
    this.hpp = const Value.absent(),
    this.modifiers = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required int productId,
    required int qty,
    required int harga,
    this.hpp = const Value.absent(),
    this.modifiers = const Value.absent(),
  }) : saleId = Value(saleId),
       productId = Value(productId),
       qty = Value(qty),
       harga = Value(harga);
  static Insertable<SaleItem> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<int>? productId,
    Expression<int>? qty,
    Expression<int>? harga,
    Expression<int>? hpp,
    Expression<String>? modifiers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (harga != null) 'harga': harga,
      if (hpp != null) 'hpp': hpp,
      if (modifiers != null) 'modifiers': modifiers,
    });
  }

  SaleItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<int>? productId,
    Value<int>? qty,
    Value<int>? harga,
    Value<int>? hpp,
    Value<String?>? modifiers,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      harga: harga ?? this.harga,
      hpp: hpp ?? this.hpp,
      modifiers: modifiers ?? this.modifiers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    if (hpp.present) {
      map['hpp'] = Variable<int>(hpp.value);
    }
    if (modifiers.present) {
      map['modifiers'] = Variable<String>(modifiers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('harga: $harga, ')
          ..write('hpp: $hpp, ')
          ..write('modifiers: $modifiers')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipeMeta = const VerificationMeta('tipe');
  @override
  late final GeneratedColumn<String> tipe = GeneratedColumn<String>(
    'tipe',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<double> qty = GeneratedColumn<double>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refTabelMeta = const VerificationMeta(
    'refTabel',
  );
  @override
  late final GeneratedColumn<String> refTabel = GeneratedColumn<String>(
    'ref_tabel',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<int> refId = GeneratedColumn<int>(
    'ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alasanMeta = const VerificationMeta('alasan');
  @override
  late final GeneratedColumn<String> alasan = GeneratedColumn<String>(
    'alasan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ingredientId,
    tipe,
    qty,
    refTabel,
    refId,
    alasan,
    waktu,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('tipe')) {
      context.handle(
        _tipeMeta,
        tipe.isAcceptableOrUnknown(data['tipe']!, _tipeMeta),
      );
    } else if (isInserting) {
      context.missing(_tipeMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('ref_tabel')) {
      context.handle(
        _refTabelMeta,
        refTabel.isAcceptableOrUnknown(data['ref_tabel']!, _refTabelMeta),
      );
    }
    if (data.containsKey('ref_id')) {
      context.handle(
        _refIdMeta,
        refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta),
      );
    }
    if (data.containsKey('alasan')) {
      context.handle(
        _alasanMeta,
        alasan.isAcceptableOrUnknown(data['alasan']!, _alasanMeta),
      );
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      tipe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipe'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty'],
      )!,
      refTabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_tabel'],
      ),
      refId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ref_id'],
      ),
      alasan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alasan'],
      ),
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final int id;
  final int ingredientId;
  final String tipe;
  final double qty;
  final String? refTabel;
  final int? refId;
  final String? alasan;
  final DateTime waktu;
  const StockMovement({
    required this.id,
    required this.ingredientId,
    required this.tipe,
    required this.qty,
    this.refTabel,
    this.refId,
    this.alasan,
    required this.waktu,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['tipe'] = Variable<String>(tipe);
    map['qty'] = Variable<double>(qty);
    if (!nullToAbsent || refTabel != null) {
      map['ref_tabel'] = Variable<String>(refTabel);
    }
    if (!nullToAbsent || refId != null) {
      map['ref_id'] = Variable<int>(refId);
    }
    if (!nullToAbsent || alasan != null) {
      map['alasan'] = Variable<String>(alasan);
    }
    map['waktu'] = Variable<DateTime>(waktu);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      ingredientId: Value(ingredientId),
      tipe: Value(tipe),
      qty: Value(qty),
      refTabel: refTabel == null && nullToAbsent
          ? const Value.absent()
          : Value(refTabel),
      refId: refId == null && nullToAbsent
          ? const Value.absent()
          : Value(refId),
      alasan: alasan == null && nullToAbsent
          ? const Value.absent()
          : Value(alasan),
      waktu: Value(waktu),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<int>(json['id']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      tipe: serializer.fromJson<String>(json['tipe']),
      qty: serializer.fromJson<double>(json['qty']),
      refTabel: serializer.fromJson<String?>(json['refTabel']),
      refId: serializer.fromJson<int?>(json['refId']),
      alasan: serializer.fromJson<String?>(json['alasan']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'tipe': serializer.toJson<String>(tipe),
      'qty': serializer.toJson<double>(qty),
      'refTabel': serializer.toJson<String?>(refTabel),
      'refId': serializer.toJson<int?>(refId),
      'alasan': serializer.toJson<String?>(alasan),
      'waktu': serializer.toJson<DateTime>(waktu),
    };
  }

  StockMovement copyWith({
    int? id,
    int? ingredientId,
    String? tipe,
    double? qty,
    Value<String?> refTabel = const Value.absent(),
    Value<int?> refId = const Value.absent(),
    Value<String?> alasan = const Value.absent(),
    DateTime? waktu,
  }) => StockMovement(
    id: id ?? this.id,
    ingredientId: ingredientId ?? this.ingredientId,
    tipe: tipe ?? this.tipe,
    qty: qty ?? this.qty,
    refTabel: refTabel.present ? refTabel.value : this.refTabel,
    refId: refId.present ? refId.value : this.refId,
    alasan: alasan.present ? alasan.value : this.alasan,
    waktu: waktu ?? this.waktu,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      tipe: data.tipe.present ? data.tipe.value : this.tipe,
      qty: data.qty.present ? data.qty.value : this.qty,
      refTabel: data.refTabel.present ? data.refTabel.value : this.refTabel,
      refId: data.refId.present ? data.refId.value : this.refId,
      alasan: data.alasan.present ? data.alasan.value : this.alasan,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('tipe: $tipe, ')
          ..write('qty: $qty, ')
          ..write('refTabel: $refTabel, ')
          ..write('refId: $refId, ')
          ..write('alasan: $alasan, ')
          ..write('waktu: $waktu')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ingredientId, tipe, qty, refTabel, refId, alasan, waktu);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.ingredientId == this.ingredientId &&
          other.tipe == this.tipe &&
          other.qty == this.qty &&
          other.refTabel == this.refTabel &&
          other.refId == this.refId &&
          other.alasan == this.alasan &&
          other.waktu == this.waktu);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<int> id;
  final Value<int> ingredientId;
  final Value<String> tipe;
  final Value<double> qty;
  final Value<String?> refTabel;
  final Value<int?> refId;
  final Value<String?> alasan;
  final Value<DateTime> waktu;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.tipe = const Value.absent(),
    this.qty = const Value.absent(),
    this.refTabel = const Value.absent(),
    this.refId = const Value.absent(),
    this.alasan = const Value.absent(),
    this.waktu = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    required int ingredientId,
    required String tipe,
    required double qty,
    this.refTabel = const Value.absent(),
    this.refId = const Value.absent(),
    this.alasan = const Value.absent(),
    required DateTime waktu,
  }) : ingredientId = Value(ingredientId),
       tipe = Value(tipe),
       qty = Value(qty),
       waktu = Value(waktu);
  static Insertable<StockMovement> custom({
    Expression<int>? id,
    Expression<int>? ingredientId,
    Expression<String>? tipe,
    Expression<double>? qty,
    Expression<String>? refTabel,
    Expression<int>? refId,
    Expression<String>? alasan,
    Expression<DateTime>? waktu,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (tipe != null) 'tipe': tipe,
      if (qty != null) 'qty': qty,
      if (refTabel != null) 'ref_tabel': refTabel,
      if (refId != null) 'ref_id': refId,
      if (alasan != null) 'alasan': alasan,
      if (waktu != null) 'waktu': waktu,
    });
  }

  StockMovementsCompanion copyWith({
    Value<int>? id,
    Value<int>? ingredientId,
    Value<String>? tipe,
    Value<double>? qty,
    Value<String?>? refTabel,
    Value<int?>? refId,
    Value<String?>? alasan,
    Value<DateTime>? waktu,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      tipe: tipe ?? this.tipe,
      qty: qty ?? this.qty,
      refTabel: refTabel ?? this.refTabel,
      refId: refId ?? this.refId,
      alasan: alasan ?? this.alasan,
      waktu: waktu ?? this.waktu,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (tipe.present) {
      map['tipe'] = Variable<String>(tipe.value);
    }
    if (qty.present) {
      map['qty'] = Variable<double>(qty.value);
    }
    if (refTabel.present) {
      map['ref_tabel'] = Variable<String>(refTabel.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<int>(refId.value);
    }
    if (alasan.present) {
      map['alasan'] = Variable<String>(alasan.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('tipe: $tipe, ')
          ..write('qty: $qty, ')
          ..write('refTabel: $refTabel, ')
          ..write('refId: $refId, ')
          ..write('alasan: $alasan, ')
          ..write('waktu: $waktu')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sumberDanaMeta = const VerificationMeta(
    'sumberDana',
  );
  @override
  late final GeneratedColumn<String> sumberDana = GeneratedColumn<String>(
    'sumber_dana',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('laci'),
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rutinMeta = const VerificationMeta('rutin');
  @override
  late final GeneratedColumn<bool> rutin = GeneratedColumn<bool>(
    'rutin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("rutin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tanggal,
    kategori,
    nominal,
    sumberDana,
    catatan,
    rutin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    } else if (isInserting) {
      context.missing(_kategoriMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('sumber_dana')) {
      context.handle(
        _sumberDanaMeta,
        sumberDana.isAcceptableOrUnknown(data['sumber_dana']!, _sumberDanaMeta),
      );
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('rutin')) {
      context.handle(
        _rutinMeta,
        rutin.isAcceptableOrUnknown(data['rutin']!, _rutinMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
      sumberDana: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sumber_dana'],
      )!,
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      rutin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}rutin'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final DateTime tanggal;
  final String kategori;
  final int nominal;
  final String sumberDana;
  final String? catatan;
  final bool rutin;
  const Expense({
    required this.id,
    required this.tanggal,
    required this.kategori,
    required this.nominal,
    required this.sumberDana,
    this.catatan,
    required this.rutin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tanggal'] = Variable<DateTime>(tanggal);
    map['kategori'] = Variable<String>(kategori);
    map['nominal'] = Variable<int>(nominal);
    map['sumber_dana'] = Variable<String>(sumberDana);
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    map['rutin'] = Variable<bool>(rutin);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      tanggal: Value(tanggal),
      kategori: Value(kategori),
      nominal: Value(nominal),
      sumberDana: Value(sumberDana),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      rutin: Value(rutin),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      kategori: serializer.fromJson<String>(json['kategori']),
      nominal: serializer.fromJson<int>(json['nominal']),
      sumberDana: serializer.fromJson<String>(json['sumberDana']),
      catatan: serializer.fromJson<String?>(json['catatan']),
      rutin: serializer.fromJson<bool>(json['rutin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'kategori': serializer.toJson<String>(kategori),
      'nominal': serializer.toJson<int>(nominal),
      'sumberDana': serializer.toJson<String>(sumberDana),
      'catatan': serializer.toJson<String?>(catatan),
      'rutin': serializer.toJson<bool>(rutin),
    };
  }

  Expense copyWith({
    int? id,
    DateTime? tanggal,
    String? kategori,
    int? nominal,
    String? sumberDana,
    Value<String?> catatan = const Value.absent(),
    bool? rutin,
  }) => Expense(
    id: id ?? this.id,
    tanggal: tanggal ?? this.tanggal,
    kategori: kategori ?? this.kategori,
    nominal: nominal ?? this.nominal,
    sumberDana: sumberDana ?? this.sumberDana,
    catatan: catatan.present ? catatan.value : this.catatan,
    rutin: rutin ?? this.rutin,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      sumberDana: data.sumberDana.present
          ? data.sumberDana.value
          : this.sumberDana,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      rutin: data.rutin.present ? data.rutin.value : this.rutin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('tanggal: $tanggal, ')
          ..write('kategori: $kategori, ')
          ..write('nominal: $nominal, ')
          ..write('sumberDana: $sumberDana, ')
          ..write('catatan: $catatan, ')
          ..write('rutin: $rutin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tanggal, kategori, nominal, sumberDana, catatan, rutin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.tanggal == this.tanggal &&
          other.kategori == this.kategori &&
          other.nominal == this.nominal &&
          other.sumberDana == this.sumberDana &&
          other.catatan == this.catatan &&
          other.rutin == this.rutin);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<DateTime> tanggal;
  final Value<String> kategori;
  final Value<int> nominal;
  final Value<String> sumberDana;
  final Value<String?> catatan;
  final Value<bool> rutin;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.kategori = const Value.absent(),
    this.nominal = const Value.absent(),
    this.sumberDana = const Value.absent(),
    this.catatan = const Value.absent(),
    this.rutin = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime tanggal,
    required String kategori,
    required int nominal,
    this.sumberDana = const Value.absent(),
    this.catatan = const Value.absent(),
    this.rutin = const Value.absent(),
  }) : tanggal = Value(tanggal),
       kategori = Value(kategori),
       nominal = Value(nominal);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<DateTime>? tanggal,
    Expression<String>? kategori,
    Expression<int>? nominal,
    Expression<String>? sumberDana,
    Expression<String>? catatan,
    Expression<bool>? rutin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tanggal != null) 'tanggal': tanggal,
      if (kategori != null) 'kategori': kategori,
      if (nominal != null) 'nominal': nominal,
      if (sumberDana != null) 'sumber_dana': sumberDana,
      if (catatan != null) 'catatan': catatan,
      if (rutin != null) 'rutin': rutin,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? tanggal,
    Value<String>? kategori,
    Value<int>? nominal,
    Value<String>? sumberDana,
    Value<String?>? catatan,
    Value<bool>? rutin,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      kategori: kategori ?? this.kategori,
      nominal: nominal ?? this.nominal,
      sumberDana: sumberDana ?? this.sumberDana,
      catatan: catatan ?? this.catatan,
      rutin: rutin ?? this.rutin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (sumberDana.present) {
      map['sumber_dana'] = Variable<String>(sumberDana.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (rutin.present) {
      map['rutin'] = Variable<bool>(rutin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('tanggal: $tanggal, ')
          ..write('kategori: $kategori, ')
          ..write('nominal: $nominal, ')
          ..write('sumberDana: $sumberDana, ')
          ..write('catatan: $catatan, ')
          ..write('rutin: $rutin')
          ..write(')'))
        .toString();
  }
}

class $DebtPaymentsTable extends DebtPayments
    with TableInfo<$DebtPaymentsTable, DebtPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, customerId, tanggal, nominal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DebtPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
    );
  }

  @override
  $DebtPaymentsTable createAlias(String alias) {
    return $DebtPaymentsTable(attachedDatabase, alias);
  }
}

class DebtPayment extends DataClass implements Insertable<DebtPayment> {
  final int id;
  final int customerId;
  final DateTime tanggal;
  final int nominal;
  const DebtPayment({
    required this.id,
    required this.customerId,
    required this.tanggal,
    required this.nominal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['tanggal'] = Variable<DateTime>(tanggal);
    map['nominal'] = Variable<int>(nominal);
    return map;
  }

  DebtPaymentsCompanion toCompanion(bool nullToAbsent) {
    return DebtPaymentsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      tanggal: Value(tanggal),
      nominal: Value(nominal),
    );
  }

  factory DebtPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtPayment(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      nominal: serializer.fromJson<int>(json['nominal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'nominal': serializer.toJson<int>(nominal),
    };
  }

  DebtPayment copyWith({
    int? id,
    int? customerId,
    DateTime? tanggal,
    int? nominal,
  }) => DebtPayment(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    tanggal: tanggal ?? this.tanggal,
    nominal: nominal ?? this.nominal,
  );
  DebtPayment copyWithCompanion(DebtPaymentsCompanion data) {
    return DebtPayment(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtPayment(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('tanggal: $tanggal, ')
          ..write('nominal: $nominal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, tanggal, nominal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtPayment &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.tanggal == this.tanggal &&
          other.nominal == this.nominal);
}

class DebtPaymentsCompanion extends UpdateCompanion<DebtPayment> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<DateTime> tanggal;
  final Value<int> nominal;
  const DebtPaymentsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.nominal = const Value.absent(),
  });
  DebtPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required DateTime tanggal,
    required int nominal,
  }) : customerId = Value(customerId),
       tanggal = Value(tanggal),
       nominal = Value(nominal);
  static Insertable<DebtPayment> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<DateTime>? tanggal,
    Expression<int>? nominal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (tanggal != null) 'tanggal': tanggal,
      if (nominal != null) 'nominal': nominal,
    });
  }

  DebtPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<DateTime>? tanggal,
    Value<int>? nominal,
  }) {
    return DebtPaymentsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      tanggal: tanggal ?? this.tanggal,
      nominal: nominal ?? this.nominal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('tanggal: $tanggal, ')
          ..write('nominal: $nominal')
          ..write(')'))
        .toString();
  }
}

class $ShoppingListItemsTable extends ShoppingListItems
    with TableInfo<$ShoppingListItemsTable, ShoppingListItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingListItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtySaranMeta = const VerificationMeta(
    'qtySaran',
  );
  @override
  late final GeneratedColumn<double> qtySaran = GeneratedColumn<double>(
    'qty_saran',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _qtyBeliMeta = const VerificationMeta(
    'qtyBeli',
  );
  @override
  late final GeneratedColumn<double> qtyBeli = GeneratedColumn<double>(
    'qty_beli',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hargaAktualMeta = const VerificationMeta(
    'hargaAktual',
  );
  @override
  late final GeneratedColumn<int> hargaAktual = GeneratedColumn<int>(
    'harga_aktual',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dicentangMeta = const VerificationMeta(
    'dicentang',
  );
  @override
  late final GeneratedColumn<bool> dicentang = GeneratedColumn<bool>(
    'dicentang',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dicentang" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ingredientId,
    qtySaran,
    qtyBeli,
    hargaAktual,
    dicentang,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_list_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingListItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('qty_saran')) {
      context.handle(
        _qtySaranMeta,
        qtySaran.isAcceptableOrUnknown(data['qty_saran']!, _qtySaranMeta),
      );
    }
    if (data.containsKey('qty_beli')) {
      context.handle(
        _qtyBeliMeta,
        qtyBeli.isAcceptableOrUnknown(data['qty_beli']!, _qtyBeliMeta),
      );
    }
    if (data.containsKey('harga_aktual')) {
      context.handle(
        _hargaAktualMeta,
        hargaAktual.isAcceptableOrUnknown(
          data['harga_aktual']!,
          _hargaAktualMeta,
        ),
      );
    }
    if (data.containsKey('dicentang')) {
      context.handle(
        _dicentangMeta,
        dicentang.isAcceptableOrUnknown(data['dicentang']!, _dicentangMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingListItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingListItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      qtySaran: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty_saran'],
      )!,
      qtyBeli: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}qty_beli'],
      ),
      hargaAktual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_aktual'],
      ),
      dicentang: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dicentang'],
      )!,
    );
  }

  @override
  $ShoppingListItemsTable createAlias(String alias) {
    return $ShoppingListItemsTable(attachedDatabase, alias);
  }
}

class ShoppingListItem extends DataClass
    implements Insertable<ShoppingListItem> {
  final int id;
  final int ingredientId;
  final double qtySaran;
  final double? qtyBeli;
  final int? hargaAktual;
  final bool dicentang;
  const ShoppingListItem({
    required this.id,
    required this.ingredientId,
    required this.qtySaran,
    this.qtyBeli,
    this.hargaAktual,
    required this.dicentang,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['qty_saran'] = Variable<double>(qtySaran);
    if (!nullToAbsent || qtyBeli != null) {
      map['qty_beli'] = Variable<double>(qtyBeli);
    }
    if (!nullToAbsent || hargaAktual != null) {
      map['harga_aktual'] = Variable<int>(hargaAktual);
    }
    map['dicentang'] = Variable<bool>(dicentang);
    return map;
  }

  ShoppingListItemsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingListItemsCompanion(
      id: Value(id),
      ingredientId: Value(ingredientId),
      qtySaran: Value(qtySaran),
      qtyBeli: qtyBeli == null && nullToAbsent
          ? const Value.absent()
          : Value(qtyBeli),
      hargaAktual: hargaAktual == null && nullToAbsent
          ? const Value.absent()
          : Value(hargaAktual),
      dicentang: Value(dicentang),
    );
  }

  factory ShoppingListItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingListItem(
      id: serializer.fromJson<int>(json['id']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      qtySaran: serializer.fromJson<double>(json['qtySaran']),
      qtyBeli: serializer.fromJson<double?>(json['qtyBeli']),
      hargaAktual: serializer.fromJson<int?>(json['hargaAktual']),
      dicentang: serializer.fromJson<bool>(json['dicentang']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'qtySaran': serializer.toJson<double>(qtySaran),
      'qtyBeli': serializer.toJson<double?>(qtyBeli),
      'hargaAktual': serializer.toJson<int?>(hargaAktual),
      'dicentang': serializer.toJson<bool>(dicentang),
    };
  }

  ShoppingListItem copyWith({
    int? id,
    int? ingredientId,
    double? qtySaran,
    Value<double?> qtyBeli = const Value.absent(),
    Value<int?> hargaAktual = const Value.absent(),
    bool? dicentang,
  }) => ShoppingListItem(
    id: id ?? this.id,
    ingredientId: ingredientId ?? this.ingredientId,
    qtySaran: qtySaran ?? this.qtySaran,
    qtyBeli: qtyBeli.present ? qtyBeli.value : this.qtyBeli,
    hargaAktual: hargaAktual.present ? hargaAktual.value : this.hargaAktual,
    dicentang: dicentang ?? this.dicentang,
  );
  ShoppingListItem copyWithCompanion(ShoppingListItemsCompanion data) {
    return ShoppingListItem(
      id: data.id.present ? data.id.value : this.id,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      qtySaran: data.qtySaran.present ? data.qtySaran.value : this.qtySaran,
      qtyBeli: data.qtyBeli.present ? data.qtyBeli.value : this.qtyBeli,
      hargaAktual: data.hargaAktual.present
          ? data.hargaAktual.value
          : this.hargaAktual,
      dicentang: data.dicentang.present ? data.dicentang.value : this.dicentang,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItem(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('qtySaran: $qtySaran, ')
          ..write('qtyBeli: $qtyBeli, ')
          ..write('hargaAktual: $hargaAktual, ')
          ..write('dicentang: $dicentang')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ingredientId, qtySaran, qtyBeli, hargaAktual, dicentang);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingListItem &&
          other.id == this.id &&
          other.ingredientId == this.ingredientId &&
          other.qtySaran == this.qtySaran &&
          other.qtyBeli == this.qtyBeli &&
          other.hargaAktual == this.hargaAktual &&
          other.dicentang == this.dicentang);
}

class ShoppingListItemsCompanion extends UpdateCompanion<ShoppingListItem> {
  final Value<int> id;
  final Value<int> ingredientId;
  final Value<double> qtySaran;
  final Value<double?> qtyBeli;
  final Value<int?> hargaAktual;
  final Value<bool> dicentang;
  const ShoppingListItemsCompanion({
    this.id = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.qtySaran = const Value.absent(),
    this.qtyBeli = const Value.absent(),
    this.hargaAktual = const Value.absent(),
    this.dicentang = const Value.absent(),
  });
  ShoppingListItemsCompanion.insert({
    this.id = const Value.absent(),
    required int ingredientId,
    this.qtySaran = const Value.absent(),
    this.qtyBeli = const Value.absent(),
    this.hargaAktual = const Value.absent(),
    this.dicentang = const Value.absent(),
  }) : ingredientId = Value(ingredientId);
  static Insertable<ShoppingListItem> custom({
    Expression<int>? id,
    Expression<int>? ingredientId,
    Expression<double>? qtySaran,
    Expression<double>? qtyBeli,
    Expression<int>? hargaAktual,
    Expression<bool>? dicentang,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (qtySaran != null) 'qty_saran': qtySaran,
      if (qtyBeli != null) 'qty_beli': qtyBeli,
      if (hargaAktual != null) 'harga_aktual': hargaAktual,
      if (dicentang != null) 'dicentang': dicentang,
    });
  }

  ShoppingListItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? ingredientId,
    Value<double>? qtySaran,
    Value<double?>? qtyBeli,
    Value<int?>? hargaAktual,
    Value<bool>? dicentang,
  }) {
    return ShoppingListItemsCompanion(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      qtySaran: qtySaran ?? this.qtySaran,
      qtyBeli: qtyBeli ?? this.qtyBeli,
      hargaAktual: hargaAktual ?? this.hargaAktual,
      dicentang: dicentang ?? this.dicentang,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (qtySaran.present) {
      map['qty_saran'] = Variable<double>(qtySaran.value);
    }
    if (qtyBeli.present) {
      map['qty_beli'] = Variable<double>(qtyBeli.value);
    }
    if (hargaAktual.present) {
      map['harga_aktual'] = Variable<int>(hargaAktual.value);
    }
    if (dicentang.present) {
      map['dicentang'] = Variable<bool>(dicentang.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemsCompanion(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('qtySaran: $qtySaran, ')
          ..write('qtyBeli: $qtyBeli, ')
          ..write('hargaAktual: $hargaAktual, ')
          ..write('dicentang: $dicentang')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kunciMeta = const VerificationMeta('kunci');
  @override
  late final GeneratedColumn<String> kunci = GeneratedColumn<String>(
    'kunci',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nilaiMeta = const VerificationMeta('nilai');
  @override
  late final GeneratedColumn<String> nilai = GeneratedColumn<String>(
    'nilai',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [kunci, nilai];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kunci')) {
      context.handle(
        _kunciMeta,
        kunci.isAcceptableOrUnknown(data['kunci']!, _kunciMeta),
      );
    } else if (isInserting) {
      context.missing(_kunciMeta);
    }
    if (data.containsKey('nilai')) {
      context.handle(
        _nilaiMeta,
        nilai.isAcceptableOrUnknown(data['nilai']!, _nilaiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {kunci};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      kunci: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kunci'],
      )!,
      nilai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nilai'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String kunci;
  final String? nilai;
  const AppSetting({required this.kunci, this.nilai});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kunci'] = Variable<String>(kunci);
    if (!nullToAbsent || nilai != null) {
      map['nilai'] = Variable<String>(nilai);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      kunci: Value(kunci),
      nilai: nilai == null && nullToAbsent
          ? const Value.absent()
          : Value(nilai),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      kunci: serializer.fromJson<String>(json['kunci']),
      nilai: serializer.fromJson<String?>(json['nilai']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kunci': serializer.toJson<String>(kunci),
      'nilai': serializer.toJson<String?>(nilai),
    };
  }

  AppSetting copyWith({
    String? kunci,
    Value<String?> nilai = const Value.absent(),
  }) => AppSetting(
    kunci: kunci ?? this.kunci,
    nilai: nilai.present ? nilai.value : this.nilai,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      kunci: data.kunci.present ? data.kunci.value : this.kunci,
      nilai: data.nilai.present ? data.nilai.value : this.nilai,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('kunci: $kunci, ')
          ..write('nilai: $nilai')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kunci, nilai);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.kunci == this.kunci &&
          other.nilai == this.nilai);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> kunci;
  final Value<String?> nilai;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.kunci = const Value.absent(),
    this.nilai = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String kunci,
    this.nilai = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : kunci = Value(kunci);
  static Insertable<AppSetting> custom({
    Expression<String>? kunci,
    Expression<String>? nilai,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kunci != null) 'kunci': kunci,
      if (nilai != null) 'nilai': nilai,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? kunci,
    Value<String?>? nilai,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      kunci: kunci ?? this.kunci,
      nilai: nilai ?? this.nilai,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kunci.present) {
      map['kunci'] = Variable<String>(kunci.value);
    }
    if (nilai.present) {
      map['nilai'] = Variable<String>(nilai.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('kunci: $kunci, ')
          ..write('nilai: $nilai, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $UnitConversionsTable unitConversions = $UnitConversionsTable(
    this,
  );
  late final $ProductsTable products = $ProductsTable(this);
  late final $RecipeItemsTable recipeItems = $RecipeItemsTable(this);
  late final $ModifiersTable modifiers = $ModifiersTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $DebtPaymentsTable debtPayments = $DebtPaymentsTable(this);
  late final $ShoppingListItemsTable shoppingListItems =
      $ShoppingListItemsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    ingredients,
    unitConversions,
    products,
    recipeItems,
    modifiers,
    purchases,
    purchaseItems,
    customers,
    sales,
    saleItems,
    stockMovements,
    expenses,
    debtPayments,
    shoppingListItems,
    appSettings,
  ];
}

typedef $$IngredientsTableCreateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      required String nama,
      Value<String> kategori,
      Value<String> satuan,
      Value<double> stokMin,
      Value<double> stokTarget,
      Value<int> hargaTerakhir,
      Value<int> hargaRata2,
      Value<bool> aktif,
    });
typedef $$IngredientsTableUpdateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String> kategori,
      Value<String> satuan,
      Value<double> stokMin,
      Value<double> stokTarget,
      Value<int> hargaTerakhir,
      Value<int> hargaRata2,
      Value<bool> aktif,
    });

class $$IngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get satuan => $composableBuilder(
    column: $table.satuan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stokMin => $composableBuilder(
    column: $table.stokMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stokTarget => $composableBuilder(
    column: $table.stokTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaTerakhir => $composableBuilder(
    column: $table.hargaTerakhir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaRata2 => $composableBuilder(
    column: $table.hargaRata2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get satuan => $composableBuilder(
    column: $table.satuan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stokMin => $composableBuilder(
    column: $table.stokMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stokTarget => $composableBuilder(
    column: $table.stokTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaTerakhir => $composableBuilder(
    column: $table.hargaTerakhir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaRata2 => $composableBuilder(
    column: $table.hargaRata2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<String> get satuan =>
      $composableBuilder(column: $table.satuan, builder: (column) => column);

  GeneratedColumn<double> get stokMin =>
      $composableBuilder(column: $table.stokMin, builder: (column) => column);

  GeneratedColumn<double> get stokTarget => $composableBuilder(
    column: $table.stokTarget,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hargaTerakhir => $composableBuilder(
    column: $table.hargaTerakhir,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hargaRata2 => $composableBuilder(
    column: $table.hargaRata2,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);
}

class $$IngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientsTable,
          Ingredient,
          $$IngredientsTableFilterComposer,
          $$IngredientsTableOrderingComposer,
          $$IngredientsTableAnnotationComposer,
          $$IngredientsTableCreateCompanionBuilder,
          $$IngredientsTableUpdateCompanionBuilder,
          (
            Ingredient,
            BaseReferences<_$AppDatabase, $IngredientsTable, Ingredient>,
          ),
          Ingredient,
          PrefetchHooks Function()
        > {
  $$IngredientsTableTableManager(_$AppDatabase db, $IngredientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String> kategori = const Value.absent(),
                Value<String> satuan = const Value.absent(),
                Value<double> stokMin = const Value.absent(),
                Value<double> stokTarget = const Value.absent(),
                Value<int> hargaTerakhir = const Value.absent(),
                Value<int> hargaRata2 = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
              }) => IngredientsCompanion(
                id: id,
                nama: nama,
                kategori: kategori,
                satuan: satuan,
                stokMin: stokMin,
                stokTarget: stokTarget,
                hargaTerakhir: hargaTerakhir,
                hargaRata2: hargaRata2,
                aktif: aktif,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                Value<String> kategori = const Value.absent(),
                Value<String> satuan = const Value.absent(),
                Value<double> stokMin = const Value.absent(),
                Value<double> stokTarget = const Value.absent(),
                Value<int> hargaTerakhir = const Value.absent(),
                Value<int> hargaRata2 = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
              }) => IngredientsCompanion.insert(
                id: id,
                nama: nama,
                kategori: kategori,
                satuan: satuan,
                stokMin: stokMin,
                stokTarget: stokTarget,
                hargaTerakhir: hargaTerakhir,
                hargaRata2: hargaRata2,
                aktif: aktif,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientsTable,
      Ingredient,
      $$IngredientsTableFilterComposer,
      $$IngredientsTableOrderingComposer,
      $$IngredientsTableAnnotationComposer,
      $$IngredientsTableCreateCompanionBuilder,
      $$IngredientsTableUpdateCompanionBuilder,
      (
        Ingredient,
        BaseReferences<_$AppDatabase, $IngredientsTable, Ingredient>,
      ),
      Ingredient,
      PrefetchHooks Function()
    >;
typedef $$UnitConversionsTableCreateCompanionBuilder =
    UnitConversionsCompanion Function({
      Value<int> id,
      required int ingredientId,
      required String satuanBeli,
      required double faktor,
    });
typedef $$UnitConversionsTableUpdateCompanionBuilder =
    UnitConversionsCompanion Function({
      Value<int> id,
      Value<int> ingredientId,
      Value<String> satuanBeli,
      Value<double> faktor,
    });

class $$UnitConversionsTableFilterComposer
    extends Composer<_$AppDatabase, $UnitConversionsTable> {
  $$UnitConversionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get satuanBeli => $composableBuilder(
    column: $table.satuanBeli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get faktor => $composableBuilder(
    column: $table.faktor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnitConversionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitConversionsTable> {
  $$UnitConversionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get satuanBeli => $composableBuilder(
    column: $table.satuanBeli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get faktor => $composableBuilder(
    column: $table.faktor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnitConversionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitConversionsTable> {
  $$UnitConversionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get satuanBeli => $composableBuilder(
    column: $table.satuanBeli,
    builder: (column) => column,
  );

  GeneratedColumn<double> get faktor =>
      $composableBuilder(column: $table.faktor, builder: (column) => column);
}

class $$UnitConversionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitConversionsTable,
          UnitConversion,
          $$UnitConversionsTableFilterComposer,
          $$UnitConversionsTableOrderingComposer,
          $$UnitConversionsTableAnnotationComposer,
          $$UnitConversionsTableCreateCompanionBuilder,
          $$UnitConversionsTableUpdateCompanionBuilder,
          (
            UnitConversion,
            BaseReferences<
              _$AppDatabase,
              $UnitConversionsTable,
              UnitConversion
            >,
          ),
          UnitConversion,
          PrefetchHooks Function()
        > {
  $$UnitConversionsTableTableManager(
    _$AppDatabase db,
    $UnitConversionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitConversionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitConversionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitConversionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> satuanBeli = const Value.absent(),
                Value<double> faktor = const Value.absent(),
              }) => UnitConversionsCompanion(
                id: id,
                ingredientId: ingredientId,
                satuanBeli: satuanBeli,
                faktor: faktor,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ingredientId,
                required String satuanBeli,
                required double faktor,
              }) => UnitConversionsCompanion.insert(
                id: id,
                ingredientId: ingredientId,
                satuanBeli: satuanBeli,
                faktor: faktor,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnitConversionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitConversionsTable,
      UnitConversion,
      $$UnitConversionsTableFilterComposer,
      $$UnitConversionsTableOrderingComposer,
      $$UnitConversionsTableAnnotationComposer,
      $$UnitConversionsTableCreateCompanionBuilder,
      $$UnitConversionsTableUpdateCompanionBuilder,
      (
        UnitConversion,
        BaseReferences<_$AppDatabase, $UnitConversionsTable, UnitConversion>,
      ),
      UnitConversion,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String nama,
      Value<String> kategori,
      Value<int> hargaJual,
      Value<String> tipe,
      Value<int?> ingredientId,
      Value<bool> aktif,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String> kategori,
      Value<int> hargaJual,
      Value<String> tipe,
      Value<int?> ingredientId,
      Value<bool> aktif,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaJual => $composableBuilder(
    column: $table.hargaJual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaJual => $composableBuilder(
    column: $table.hargaJual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<int> get hargaJual =>
      $composableBuilder(column: $table.hargaJual, builder: (column) => column);

  GeneratedColumn<String> get tipe =>
      $composableBuilder(column: $table.tipe, builder: (column) => column);

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String> kategori = const Value.absent(),
                Value<int> hargaJual = const Value.absent(),
                Value<String> tipe = const Value.absent(),
                Value<int?> ingredientId = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                nama: nama,
                kategori: kategori,
                hargaJual: hargaJual,
                tipe: tipe,
                ingredientId: ingredientId,
                aktif: aktif,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                Value<String> kategori = const Value.absent(),
                Value<int> hargaJual = const Value.absent(),
                Value<String> tipe = const Value.absent(),
                Value<int?> ingredientId = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                nama: nama,
                kategori: kategori,
                hargaJual: hargaJual,
                tipe: tipe,
                ingredientId: ingredientId,
                aktif: aktif,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$RecipeItemsTableCreateCompanionBuilder =
    RecipeItemsCompanion Function({
      Value<int> id,
      required int productId,
      required int ingredientId,
      required double takaran,
    });
typedef $$RecipeItemsTableUpdateCompanionBuilder =
    RecipeItemsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> ingredientId,
      Value<double> takaran,
    });

class $$RecipeItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeItemsTable> {
  $$RecipeItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get takaran => $composableBuilder(
    column: $table.takaran,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipeItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeItemsTable> {
  $$RecipeItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get takaran => $composableBuilder(
    column: $table.takaran,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeItemsTable> {
  $$RecipeItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get takaran =>
      $composableBuilder(column: $table.takaran, builder: (column) => column);
}

class $$RecipeItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeItemsTable,
          RecipeItem,
          $$RecipeItemsTableFilterComposer,
          $$RecipeItemsTableOrderingComposer,
          $$RecipeItemsTableAnnotationComposer,
          $$RecipeItemsTableCreateCompanionBuilder,
          $$RecipeItemsTableUpdateCompanionBuilder,
          (
            RecipeItem,
            BaseReferences<_$AppDatabase, $RecipeItemsTable, RecipeItem>,
          ),
          RecipeItem,
          PrefetchHooks Function()
        > {
  $$RecipeItemsTableTableManager(_$AppDatabase db, $RecipeItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> takaran = const Value.absent(),
              }) => RecipeItemsCompanion(
                id: id,
                productId: productId,
                ingredientId: ingredientId,
                takaran: takaran,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int ingredientId,
                required double takaran,
              }) => RecipeItemsCompanion.insert(
                id: id,
                productId: productId,
                ingredientId: ingredientId,
                takaran: takaran,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipeItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeItemsTable,
      RecipeItem,
      $$RecipeItemsTableFilterComposer,
      $$RecipeItemsTableOrderingComposer,
      $$RecipeItemsTableAnnotationComposer,
      $$RecipeItemsTableCreateCompanionBuilder,
      $$RecipeItemsTableUpdateCompanionBuilder,
      (
        RecipeItem,
        BaseReferences<_$AppDatabase, $RecipeItemsTable, RecipeItem>,
      ),
      RecipeItem,
      PrefetchHooks Function()
    >;
typedef $$ModifiersTableCreateCompanionBuilder =
    ModifiersCompanion Function({
      Value<int> id,
      required String nama,
      Value<int> hargaTambah,
      Value<String?> resepTambahan,
    });
typedef $$ModifiersTableUpdateCompanionBuilder =
    ModifiersCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<int> hargaTambah,
      Value<String?> resepTambahan,
    });

class $$ModifiersTableFilterComposer
    extends Composer<_$AppDatabase, $ModifiersTable> {
  $$ModifiersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaTambah => $composableBuilder(
    column: $table.hargaTambah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resepTambahan => $composableBuilder(
    column: $table.resepTambahan,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ModifiersTableOrderingComposer
    extends Composer<_$AppDatabase, $ModifiersTable> {
  $$ModifiersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaTambah => $composableBuilder(
    column: $table.hargaTambah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resepTambahan => $composableBuilder(
    column: $table.resepTambahan,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ModifiersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModifiersTable> {
  $$ModifiersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get hargaTambah => $composableBuilder(
    column: $table.hargaTambah,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resepTambahan => $composableBuilder(
    column: $table.resepTambahan,
    builder: (column) => column,
  );
}

class $$ModifiersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModifiersTable,
          Modifier,
          $$ModifiersTableFilterComposer,
          $$ModifiersTableOrderingComposer,
          $$ModifiersTableAnnotationComposer,
          $$ModifiersTableCreateCompanionBuilder,
          $$ModifiersTableUpdateCompanionBuilder,
          (Modifier, BaseReferences<_$AppDatabase, $ModifiersTable, Modifier>),
          Modifier,
          PrefetchHooks Function()
        > {
  $$ModifiersTableTableManager(_$AppDatabase db, $ModifiersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModifiersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModifiersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModifiersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> hargaTambah = const Value.absent(),
                Value<String?> resepTambahan = const Value.absent(),
              }) => ModifiersCompanion(
                id: id,
                nama: nama,
                hargaTambah: hargaTambah,
                resepTambahan: resepTambahan,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                Value<int> hargaTambah = const Value.absent(),
                Value<String?> resepTambahan = const Value.absent(),
              }) => ModifiersCompanion.insert(
                id: id,
                nama: nama,
                hargaTambah: hargaTambah,
                resepTambahan: resepTambahan,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ModifiersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModifiersTable,
      Modifier,
      $$ModifiersTableFilterComposer,
      $$ModifiersTableOrderingComposer,
      $$ModifiersTableAnnotationComposer,
      $$ModifiersTableCreateCompanionBuilder,
      $$ModifiersTableUpdateCompanionBuilder,
      (Modifier, BaseReferences<_$AppDatabase, $ModifiersTable, Modifier>),
      Modifier,
      PrefetchHooks Function()
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      required DateTime tanggal,
      Value<String?> supplier,
      Value<int> total,
      Value<String> sumberDana,
      Value<String?> fotoNota,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      Value<DateTime> tanggal,
      Value<String?> supplier,
      Value<int> total,
      Value<String> sumberDana,
      Value<String?> fotoNota,
    });

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sumberDana => $composableBuilder(
    column: $table.sumberDana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotoNota => $composableBuilder(
    column: $table.fotoNota,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sumberDana => $composableBuilder(
    column: $table.sumberDana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotoNota => $composableBuilder(
    column: $table.fotoNota,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<String> get supplier =>
      $composableBuilder(column: $table.supplier, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get sumberDana => $composableBuilder(
    column: $table.sumberDana,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fotoNota =>
      $composableBuilder(column: $table.fotoNota, builder: (column) => column);
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
          Purchase,
          PrefetchHooks Function()
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<String?> supplier = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> sumberDana = const Value.absent(),
                Value<String?> fotoNota = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                tanggal: tanggal,
                supplier: supplier,
                total: total,
                sumberDana: sumberDana,
                fotoNota: fotoNota,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime tanggal,
                Value<String?> supplier = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> sumberDana = const Value.absent(),
                Value<String?> fotoNota = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                tanggal: tanggal,
                supplier: supplier,
                total: total,
                sumberDana: sumberDana,
                fotoNota: fotoNota,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, BaseReferences<_$AppDatabase, $PurchasesTable, Purchase>),
      Purchase,
      PrefetchHooks Function()
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<int> id,
      required int purchaseId,
      required int ingredientId,
      required double qty,
      required String satuanBeli,
      required int harga,
    });
typedef $$PurchaseItemsTableUpdateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<int> id,
      Value<int> purchaseId,
      Value<int> ingredientId,
      Value<double> qty,
      Value<String> satuanBeli,
      Value<int> harga,
    });

class $$PurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get satuanBeli => $composableBuilder(
    column: $table.satuanBeli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get satuanBeli => $composableBuilder(
    column: $table.satuanBeli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<String> get satuanBeli => $composableBuilder(
    column: $table.satuanBeli,
    builder: (column) => column,
  );

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (
            PurchaseItem,
            BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem>,
          ),
          PurchaseItem,
          PrefetchHooks Function()
        > {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<String> satuanBeli = const Value.absent(),
                Value<int> harga = const Value.absent(),
              }) => PurchaseItemsCompanion(
                id: id,
                purchaseId: purchaseId,
                ingredientId: ingredientId,
                qty: qty,
                satuanBeli: satuanBeli,
                harga: harga,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required int ingredientId,
                required double qty,
                required String satuanBeli,
                required int harga,
              }) => PurchaseItemsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                ingredientId: ingredientId,
                qty: qty,
                satuanBeli: satuanBeli,
                harga: harga,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (
        PurchaseItem,
        BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem>,
      ),
      PurchaseItem,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String nama,
      Value<String?> noHp,
      Value<int> saldoKasbon,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String?> noHp,
      Value<int> saldoKasbon,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoKasbon => $composableBuilder(
    column: $table.saldoKasbon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoKasbon => $composableBuilder(
    column: $table.saldoKasbon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get noHp =>
      $composableBuilder(column: $table.noHp, builder: (column) => column);

  GeneratedColumn<int> get saldoKasbon => $composableBuilder(
    column: $table.saldoKasbon,
    builder: (column) => column,
  );
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String?> noHp = const Value.absent(),
                Value<int> saldoKasbon = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                nama: nama,
                noHp: noHp,
                saldoKasbon: saldoKasbon,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                Value<String?> noHp = const Value.absent(),
                Value<int> saldoKasbon = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                nama: nama,
                noHp: noHp,
                saldoKasbon: saldoKasbon,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required DateTime waktu,
      Value<int> total,
      Value<String> metodeBayar,
      Value<int?> customerId,
      Value<String> status,
      Value<String?> meja,
      Value<String?> catatan,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<DateTime> waktu,
      Value<int> total,
      Value<String> metodeBayar,
      Value<int?> customerId,
      Value<String> status,
      Value<String?> meja,
      Value<String?> catatan,
    });

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodeBayar => $composableBuilder(
    column: $table.metodeBayar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meja => $composableBuilder(
    column: $table.meja,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodeBayar => $composableBuilder(
    column: $table.metodeBayar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meja => $composableBuilder(
    column: $table.meja,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get metodeBayar => $composableBuilder(
    column: $table.metodeBayar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get meja =>
      $composableBuilder(column: $table.meja, builder: (column) => column);

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
          Sale,
          PrefetchHooks Function()
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> metodeBayar = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> meja = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                waktu: waktu,
                total: total,
                metodeBayar: metodeBayar,
                customerId: customerId,
                status: status,
                meja: meja,
                catatan: catatan,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime waktu,
                Value<int> total = const Value.absent(),
                Value<String> metodeBayar = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> meja = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                waktu: waktu,
                total: total,
                metodeBayar: metodeBayar,
                customerId: customerId,
                status: status,
                meja: meja,
                catatan: catatan,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, BaseReferences<_$AppDatabase, $SalesTable, Sale>),
      Sale,
      PrefetchHooks Function()
    >;
typedef $$SaleItemsTableCreateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      required int saleId,
      required int productId,
      required int qty,
      required int harga,
      Value<int> hpp,
      Value<String?> modifiers,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      Value<int> saleId,
      Value<int> productId,
      Value<int> qty,
      Value<int> harga,
      Value<int> hpp,
      Value<String?> modifiers,
    });

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saleId => $composableBuilder(
    column: $table.saleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hpp => $composableBuilder(
    column: $table.hpp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modifiers => $composableBuilder(
    column: $table.modifiers,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saleId => $composableBuilder(
    column: $table.saleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hpp => $composableBuilder(
    column: $table.hpp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modifiers => $composableBuilder(
    column: $table.modifiers,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get saleId =>
      $composableBuilder(column: $table.saleId, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);

  GeneratedColumn<int> get hpp =>
      $composableBuilder(column: $table.hpp, builder: (column) => column);

  GeneratedColumn<String> get modifiers =>
      $composableBuilder(column: $table.modifiers, builder: (column) => column);
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem>),
          SaleItem,
          PrefetchHooks Function()
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> harga = const Value.absent(),
                Value<int> hpp = const Value.absent(),
                Value<String?> modifiers = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                saleId: saleId,
                productId: productId,
                qty: qty,
                harga: harga,
                hpp: hpp,
                modifiers: modifiers,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                required int productId,
                required int qty,
                required int harga,
                Value<int> hpp = const Value.absent(),
                Value<String?> modifiers = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                saleId: saleId,
                productId: productId,
                qty: qty,
                harga: harga,
                hpp: hpp,
                modifiers: modifiers,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem>),
      SaleItem,
      PrefetchHooks Function()
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      required int ingredientId,
      required String tipe,
      required double qty,
      Value<String?> refTabel,
      Value<int?> refId,
      Value<String?> alasan,
      required DateTime waktu,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      Value<int> ingredientId,
      Value<String> tipe,
      Value<double> qty,
      Value<String?> refTabel,
      Value<int?> refId,
      Value<String?> alasan,
      Value<DateTime> waktu,
    });

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refTabel => $composableBuilder(
    column: $table.refTabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alasan => $composableBuilder(
    column: $table.alasan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refTabel => $composableBuilder(
    column: $table.refTabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alasan => $composableBuilder(
    column: $table.alasan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipe =>
      $composableBuilder(column: $table.tipe, builder: (column) => column);

  GeneratedColumn<double> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<String> get refTabel =>
      $composableBuilder(column: $table.refTabel, builder: (column) => column);

  GeneratedColumn<int> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<String> get alasan =>
      $composableBuilder(column: $table.alasan, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (
            StockMovement,
            BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement>,
          ),
          StockMovement,
          PrefetchHooks Function()
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> tipe = const Value.absent(),
                Value<double> qty = const Value.absent(),
                Value<String?> refTabel = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<String?> alasan = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                ingredientId: ingredientId,
                tipe: tipe,
                qty: qty,
                refTabel: refTabel,
                refId: refId,
                alasan: alasan,
                waktu: waktu,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ingredientId,
                required String tipe,
                required double qty,
                Value<String?> refTabel = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<String?> alasan = const Value.absent(),
                required DateTime waktu,
              }) => StockMovementsCompanion.insert(
                id: id,
                ingredientId: ingredientId,
                tipe: tipe,
                qty: qty,
                refTabel: refTabel,
                refId: refId,
                alasan: alasan,
                waktu: waktu,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (
        StockMovement,
        BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement>,
      ),
      StockMovement,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required DateTime tanggal,
      required String kategori,
      required int nominal,
      Value<String> sumberDana,
      Value<String?> catatan,
      Value<bool> rutin,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> tanggal,
      Value<String> kategori,
      Value<int> nominal,
      Value<String> sumberDana,
      Value<String?> catatan,
      Value<bool> rutin,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sumberDana => $composableBuilder(
    column: $table.sumberDana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get rutin => $composableBuilder(
    column: $table.rutin,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sumberDana => $composableBuilder(
    column: $table.sumberDana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get rutin => $composableBuilder(
    column: $table.rutin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumn<String> get sumberDana => $composableBuilder(
    column: $table.sumberDana,
    builder: (column) => column,
  );

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<bool> get rutin =>
      $composableBuilder(column: $table.rutin, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<String> kategori = const Value.absent(),
                Value<int> nominal = const Value.absent(),
                Value<String> sumberDana = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<bool> rutin = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                tanggal: tanggal,
                kategori: kategori,
                nominal: nominal,
                sumberDana: sumberDana,
                catatan: catatan,
                rutin: rutin,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime tanggal,
                required String kategori,
                required int nominal,
                Value<String> sumberDana = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<bool> rutin = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                tanggal: tanggal,
                kategori: kategori,
                nominal: nominal,
                sumberDana: sumberDana,
                catatan: catatan,
                rutin: rutin,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$DebtPaymentsTableCreateCompanionBuilder =
    DebtPaymentsCompanion Function({
      Value<int> id,
      required int customerId,
      required DateTime tanggal,
      required int nominal,
    });
typedef $$DebtPaymentsTableUpdateCompanionBuilder =
    DebtPaymentsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<DateTime> tanggal,
      Value<int> nominal,
    });

class $$DebtPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DebtPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DebtPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);
}

class $$DebtPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtPaymentsTable,
          DebtPayment,
          $$DebtPaymentsTableFilterComposer,
          $$DebtPaymentsTableOrderingComposer,
          $$DebtPaymentsTableAnnotationComposer,
          $$DebtPaymentsTableCreateCompanionBuilder,
          $$DebtPaymentsTableUpdateCompanionBuilder,
          (
            DebtPayment,
            BaseReferences<_$AppDatabase, $DebtPaymentsTable, DebtPayment>,
          ),
          DebtPayment,
          PrefetchHooks Function()
        > {
  $$DebtPaymentsTableTableManager(_$AppDatabase db, $DebtPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<int> nominal = const Value.absent(),
              }) => DebtPaymentsCompanion(
                id: id,
                customerId: customerId,
                tanggal: tanggal,
                nominal: nominal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required DateTime tanggal,
                required int nominal,
              }) => DebtPaymentsCompanion.insert(
                id: id,
                customerId: customerId,
                tanggal: tanggal,
                nominal: nominal,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DebtPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtPaymentsTable,
      DebtPayment,
      $$DebtPaymentsTableFilterComposer,
      $$DebtPaymentsTableOrderingComposer,
      $$DebtPaymentsTableAnnotationComposer,
      $$DebtPaymentsTableCreateCompanionBuilder,
      $$DebtPaymentsTableUpdateCompanionBuilder,
      (
        DebtPayment,
        BaseReferences<_$AppDatabase, $DebtPaymentsTable, DebtPayment>,
      ),
      DebtPayment,
      PrefetchHooks Function()
    >;
typedef $$ShoppingListItemsTableCreateCompanionBuilder =
    ShoppingListItemsCompanion Function({
      Value<int> id,
      required int ingredientId,
      Value<double> qtySaran,
      Value<double?> qtyBeli,
      Value<int?> hargaAktual,
      Value<bool> dicentang,
    });
typedef $$ShoppingListItemsTableUpdateCompanionBuilder =
    ShoppingListItemsCompanion Function({
      Value<int> id,
      Value<int> ingredientId,
      Value<double> qtySaran,
      Value<double?> qtyBeli,
      Value<int?> hargaAktual,
      Value<bool> dicentang,
    });

class $$ShoppingListItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingListItemsTable> {
  $$ShoppingListItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qtySaran => $composableBuilder(
    column: $table.qtySaran,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qtyBeli => $composableBuilder(
    column: $table.qtyBeli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaAktual => $composableBuilder(
    column: $table.hargaAktual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dicentang => $composableBuilder(
    column: $table.dicentang,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShoppingListItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingListItemsTable> {
  $$ShoppingListItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qtySaran => $composableBuilder(
    column: $table.qtySaran,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qtyBeli => $composableBuilder(
    column: $table.qtyBeli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaAktual => $composableBuilder(
    column: $table.hargaAktual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dicentang => $composableBuilder(
    column: $table.dicentang,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShoppingListItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingListItemsTable> {
  $$ShoppingListItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ingredientId => $composableBuilder(
    column: $table.ingredientId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get qtySaran =>
      $composableBuilder(column: $table.qtySaran, builder: (column) => column);

  GeneratedColumn<double> get qtyBeli =>
      $composableBuilder(column: $table.qtyBeli, builder: (column) => column);

  GeneratedColumn<int> get hargaAktual => $composableBuilder(
    column: $table.hargaAktual,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get dicentang =>
      $composableBuilder(column: $table.dicentang, builder: (column) => column);
}

class $$ShoppingListItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingListItemsTable,
          ShoppingListItem,
          $$ShoppingListItemsTableFilterComposer,
          $$ShoppingListItemsTableOrderingComposer,
          $$ShoppingListItemsTableAnnotationComposer,
          $$ShoppingListItemsTableCreateCompanionBuilder,
          $$ShoppingListItemsTableUpdateCompanionBuilder,
          (
            ShoppingListItem,
            BaseReferences<
              _$AppDatabase,
              $ShoppingListItemsTable,
              ShoppingListItem
            >,
          ),
          ShoppingListItem,
          PrefetchHooks Function()
        > {
  $$ShoppingListItemsTableTableManager(
    _$AppDatabase db,
    $ShoppingListItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingListItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingListItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingListItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> qtySaran = const Value.absent(),
                Value<double?> qtyBeli = const Value.absent(),
                Value<int?> hargaAktual = const Value.absent(),
                Value<bool> dicentang = const Value.absent(),
              }) => ShoppingListItemsCompanion(
                id: id,
                ingredientId: ingredientId,
                qtySaran: qtySaran,
                qtyBeli: qtyBeli,
                hargaAktual: hargaAktual,
                dicentang: dicentang,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ingredientId,
                Value<double> qtySaran = const Value.absent(),
                Value<double?> qtyBeli = const Value.absent(),
                Value<int?> hargaAktual = const Value.absent(),
                Value<bool> dicentang = const Value.absent(),
              }) => ShoppingListItemsCompanion.insert(
                id: id,
                ingredientId: ingredientId,
                qtySaran: qtySaran,
                qtyBeli: qtyBeli,
                hargaAktual: hargaAktual,
                dicentang: dicentang,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShoppingListItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingListItemsTable,
      ShoppingListItem,
      $$ShoppingListItemsTableFilterComposer,
      $$ShoppingListItemsTableOrderingComposer,
      $$ShoppingListItemsTableAnnotationComposer,
      $$ShoppingListItemsTableCreateCompanionBuilder,
      $$ShoppingListItemsTableUpdateCompanionBuilder,
      (
        ShoppingListItem,
        BaseReferences<
          _$AppDatabase,
          $ShoppingListItemsTable,
          ShoppingListItem
        >,
      ),
      ShoppingListItem,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String kunci,
      Value<String?> nilai,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> kunci,
      Value<String?> nilai,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get kunci => $composableBuilder(
    column: $table.kunci,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nilai => $composableBuilder(
    column: $table.nilai,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get kunci => $composableBuilder(
    column: $table.kunci,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nilai => $composableBuilder(
    column: $table.nilai,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get kunci =>
      $composableBuilder(column: $table.kunci, builder: (column) => column);

  GeneratedColumn<String> get nilai =>
      $composableBuilder(column: $table.nilai, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> kunci = const Value.absent(),
                Value<String?> nilai = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                kunci: kunci,
                nilai: nilai,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String kunci,
                Value<String?> nilai = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                kunci: kunci,
                nilai: nilai,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db, _db.ingredients);
  $$UnitConversionsTableTableManager get unitConversions =>
      $$UnitConversionsTableTableManager(_db, _db.unitConversions);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$RecipeItemsTableTableManager get recipeItems =>
      $$RecipeItemsTableTableManager(_db, _db.recipeItems);
  $$ModifiersTableTableManager get modifiers =>
      $$ModifiersTableTableManager(_db, _db.modifiers);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$DebtPaymentsTableTableManager get debtPayments =>
      $$DebtPaymentsTableTableManager(_db, _db.debtPayments);
  $$ShoppingListItemsTableTableManager get shoppingListItems =>
      $$ShoppingListItemsTableTableManager(_db, _db.shoppingListItems);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
