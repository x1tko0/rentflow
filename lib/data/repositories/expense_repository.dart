import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class ExpenseRepository {
  final AppDatabase _db;
  const ExpenseRepository(this._db);

  Stream<List<Expense>> watchByProperty(String propertyId) =>
      (_db.select(_db.expenses)..where((t) => t.propertyId.equals(propertyId))).watch();

  Future<double> sumForMonth(DateTime month) async {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    final rows = await (_db.select(_db.expenses)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .get();
    return rows.fold<double>(0.0, (sum, e) => sum + e.amount);
  }

  Stream<double> watchSumForMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return (_db.select(_db.expenses)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .watch()
        .map((rows) => rows.fold<double>(0.0, (sum, e) => sum + e.amount));
  }

  Stream<List<Expense>> watchForYear(int year) {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year + 1, 1, 1);
    return (_db.select(_db.expenses)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .watch();
  }

  Future<void> create(ExpensesCompanion data) async {
    await _db.into(_db.expenses).insert(
          data.copyWith(id: Value(const Uuid().v4())),
        );
  }

  Future<void> update(String id, ExpensesCompanion data) async {
    await (_db.update(_db.expenses)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.expenses)..where((t) => t.id.equals(id))).go();
  }
}
