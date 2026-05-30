import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class MeterRepository {
  final AppDatabase _db;
  const MeterRepository(this._db);

  Stream<List<MeterReading>> watchByProperty(String propertyId) =>
      (_db.select(_db.meterReadings)
            ..where((t) => t.propertyId.equals(propertyId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Stream<List<MeterReading>> watchByType(String propertyId, String type) =>
      (_db.select(_db.meterReadings)
            ..where((t) => t.propertyId.equals(propertyId) & t.type.equals(type))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<List<MeterReading>> getByProperty(String propertyId) =>
      (_db.select(_db.meterReadings)
            ..where((t) => t.propertyId.equals(propertyId))
            ..orderBy([(t) => OrderingTerm.asc(t.type), (t) => OrderingTerm.desc(t.date)]))
          .get();

  Future<void> create(MeterReadingsCompanion data) async {
    await _db.into(_db.meterReadings).insert(
      data.copyWith(id: Value(const Uuid().v4())),
    );
  }

  Future<void> update(MeterReadingsCompanion data) async {
    await (_db.update(_db.meterReadings)..where((t) => t.id.equals(data.id.value)))
        .write(data);
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.meterReadings)..where((t) => t.id.equals(id))).go();
  }

  Stream<List<String>> watchCustomTypes(String propertyId) {
    const predefined = {
      'water_cold', 'water_hot', 'gas', 'electricity',
      'electricity_t1', 'electricity_t2', 'heat'
    };
    return (_db.select(_db.meterReadings)
          ..where((t) => t.propertyId.equals(propertyId))
          ..orderBy([(t) => OrderingTerm.asc(t.type)]))
        .watch()
        .map((rows) => rows
            .map((r) => r.type)
            .where((type) => !predefined.contains(type))
            .toSet()
            .toList()
          ..sort());
  }
}
