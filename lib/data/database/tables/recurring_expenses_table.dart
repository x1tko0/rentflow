import 'package:drift/drift.dart';

class RecurringExpenses extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text()();
  RealColumn get amount => real()();
  TextColumn get category => text().withDefault(const Constant('other'))();
  TextColumn get description => text()();
  IntColumn get dayOfMonth => integer().withDefault(const Constant(1))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
