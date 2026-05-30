import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/properties_table.dart';
import 'tables/tenants_table.dart';
import 'tables/payments_table.dart';
import 'tables/expenses_table.dart';
import 'tables/recurring_expenses_table.dart';
import 'tables/custom_categories_table.dart';
import 'tables/meter_readings_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Properties, Tenants, Payments, Expenses, RecurringExpenses, CustomCategories, MeterReadings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(recurringExpenses);
        await m.createTable(customCategories);
        await m.createTable(meterReadings);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'rentflow_db');
  }
}
