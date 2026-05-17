import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/properties_table.dart';
import 'tables/tenants_table.dart';
import 'tables/payments_table.dart';
import 'tables/expenses_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Properties, Tenants, Payments, Expenses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'rentflow_db');
  }
}
