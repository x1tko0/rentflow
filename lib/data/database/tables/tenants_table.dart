import 'package:drift/drift.dart';

class Tenants extends Table {
  TextColumn get id => text()();
  TextColumn get propertyId => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get phone => text()();
  TextColumn get email => text().nullable()();
  DateTimeColumn get leaseStart => dateTime()();
  DateTimeColumn get leaseEnd => dateTime().nullable()();
  RealColumn get rentAmount => real()();
  IntColumn get paymentDay => integer().withDefault(const Constant(1))();
  RealColumn get depositAmount => real().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
