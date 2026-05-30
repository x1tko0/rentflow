import 'package:drift/drift.dart';

// type: water_cold | water_hot | gas | electricity | heat
class MeterReadings extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text()();
  TextColumn get type => text()();
  RealColumn get value => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
