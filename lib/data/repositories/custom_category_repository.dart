import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class CustomCategoryRepository {
  final AppDatabase _db;
  const CustomCategoryRepository(this._db);

  Stream<List<CustomCategory>> watchAll() =>
      (_db.select(_db.customCategories)
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .watch();

  Future<List<CustomCategory>> getAll() =>
      _db.select(_db.customCategories).get();

  Future<String> create(String name) async {
    final id = const Uuid().v4();
    await _db.into(_db.customCategories).insert(
      CustomCategoriesCompanion(id: Value(id), name: Value(name)),
    );
    return id;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.customCategories)..where((t) => t.id.equals(id))).go();
  }
}
