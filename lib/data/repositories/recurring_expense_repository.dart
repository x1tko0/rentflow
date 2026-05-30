import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class RecurringExpenseRepository {
  final AppDatabase _db;
  const RecurringExpenseRepository(this._db);

  Stream<List<RecurringExpense>> watchActive() =>
      (_db.select(_db.recurringExpenses)
            ..where((t) => t.isActive.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .watch();

  Future<List<RecurringExpense>> getActive() =>
      (_db.select(_db.recurringExpenses)..where((t) => t.isActive.equals(true))).get();

  Future<String> create(RecurringExpensesCompanion data) async {
    final id = const Uuid().v4();
    await _db.into(_db.recurringExpenses).insert(data.copyWith(id: Value(id)));
    return id;
  }

  Future<void> deactivate(String id) async {
    await (_db.update(_db.recurringExpenses)..where((t) => t.id.equals(id)))
        .write(const RecurringExpensesCompanion(isActive: Value(false)));
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.recurringExpenses)..where((t) => t.id.equals(id))).go();
  }

  Future<void> autoCreateForMonth(DateTime month) async {
    final templates = await getActive();
    if (templates.isEmpty) return;

    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 1);

    for (final t in templates) {
      final existing = await (_db.select(_db.expenses)
            ..where((e) =>
                e.description.equals(t.description) &
                e.propertyId.equals(t.propertyId) &
                e.date.isBiggerOrEqualValue(monthStart) &
                e.date.isSmallerThanValue(monthEnd)))
          .get();
      if (existing.isNotEmpty) continue;

      final day = t.dayOfMonth.clamp(1, _daysInMonth(month.year, month.month));
      await _db.into(_db.expenses).insert(ExpensesCompanion(
        id: Value(const Uuid().v4()),
        propertyId: Value(t.propertyId),
        amount: Value(t.amount),
        date: Value(DateTime(month.year, month.month, day)),
        category: Value(t.category),
        description: Value(t.description),
      ));
    }
  }

  int _daysInMonth(int year, int month) =>
      DateTime(year, month + 1, 0).day;
}
