import 'package:drift/drift.dart';

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  // category: repair | tax | insurance | utility | management | other
  TextColumn get category => text().withDefault(const Constant('other'))();
  TextColumn get description => text()();
  TextColumn get receiptPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
