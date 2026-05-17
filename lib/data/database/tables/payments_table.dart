import 'package:drift/drift.dart';

class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get propertyId => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  // type: rent | deposit | utility | other
  TextColumn get type => text().withDefault(const Constant('rent'))();
  // status: pending | paid | overdue
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
