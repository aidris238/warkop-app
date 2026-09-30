import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database.dart';
import 'data/repository.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final repoProvider =
    Provider<WarkopRepository>((ref) => WarkopRepository(ref.watch(dbProvider)));
