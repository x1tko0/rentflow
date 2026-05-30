import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';

class PaymentRepository {
  final AppDatabase _db;
  const PaymentRepository(this._db);

  Stream<List<Payment>> watchByProperty(String propertyId) =>
      (_db.select(_db.payments)..where((t) => t.propertyId.equals(propertyId))).watch();

  Stream<List<Payment>> watchByTenant(String tenantId) =>
      (_db.select(_db.payments)
            ..where((t) => t.tenantId.equals(tenantId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Stream<List<Payment>> watchOverdue() =>
      (_db.select(_db.payments)..where((t) => t.status.equals('overdue'))).watch();

  Future<double> sumPaidForMonth(DateTime month) async {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    final rows = await (_db.select(_db.payments)
          ..where((t) =>
              t.status.equals('paid') &
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .get();
    return rows.fold<double>(0.0, (sum, p) => sum + p.amount);
  }

  Stream<double> watchSumPaidForMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return (_db.select(_db.payments)
          ..where((t) =>
              t.status.equals('paid') &
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .watch()
        .map((rows) => rows.fold<double>(0.0, (sum, p) => sum + p.amount));
  }

  Stream<List<Payment>> watchPaidForYear(int year) {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year + 1, 1, 1);
    return (_db.select(_db.payments)
          ..where((t) =>
              t.status.equals('paid') &
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end)))
        .watch();
  }

  Future<void> create(PaymentsCompanion data) async {
    await _db.into(_db.payments).insert(
          data.copyWith(id: Value(const Uuid().v4())),
        );
  }

  Future<void> update(String id, PaymentsCompanion data) async {
    await (_db.update(_db.payments)..where((t) => t.id.equals(id))).write(data);
  }

  Future<void> markPaid(String id) async {
    await (_db.update(_db.payments)..where((t) => t.id.equals(id)))
        .write(PaymentsCompanion(status: const Value('paid')));
  }

  Future<void> markOverduePayments() async {
    final today = DateTime.now();
    final todayMidnight = DateTime(today.year, today.month, today.day);
    await (_db.update(_db.payments)
          ..where((p) =>
              p.status.equals('pending') &
              p.date.isSmallerThanValue(todayMidnight)))
        .write(const PaymentsCompanion(status: Value('overdue')));
  }
}
