import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class TenantRepository {
  final AppDatabase _db;
  const TenantRepository(this._db);

  Stream<List<Tenant>> watchByProperty(String propertyId) =>
      (_db.select(_db.tenants)..where((t) => t.propertyId.equals(propertyId))).watch();

  Stream<List<Tenant>> watchActive() =>
      (_db.select(_db.tenants)..where((t) => t.isActive.equals(true))).watch();

  Future<List<Tenant>> getAll() => _db.select(_db.tenants).get();

  Future<void> create(TenantsCompanion data) async {
    await _db.into(_db.tenants).insert(
          data.copyWith(id: Value(const Uuid().v4())),
        );
  }

  Future<void> update(String id, TenantsCompanion data) async {
    await (_db.update(_db.tenants)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.tenants)..where((t) => t.id.equals(id))).go();
  }
}
