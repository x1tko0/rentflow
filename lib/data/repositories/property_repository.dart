import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class PropertyRepository {
  final AppDatabase _db;
  const PropertyRepository(this._db);

  Stream<List<Property>> watchAll() => _db.select(_db.properties).watch();

  Future<List<Property>> getAll() => _db.select(_db.properties).get();

  Future<Property?> getById(String id) =>
      (_db.select(_db.properties)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> create(PropertiesCompanion data) async {
    await _db.into(_db.properties).insert(
          data.copyWith(id: Value(const Uuid().v4())),
        );
  }

  Future<void> update(String id, PropertiesCompanion data) async {
    await (_db.update(_db.properties)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.properties)..where((t) => t.id.equals(id))).go();
  }
}
