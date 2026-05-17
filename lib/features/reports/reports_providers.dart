import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../shared/providers/repository_providers.dart';

class MonthStat {
  final DateTime month;
  final double income;
  final double expenses;
  double get net => income - expenses;
  const MonthStat({required this.month, required this.income, required this.expenses});
}

class YearReport {
  final List<MonthStat> months;
  double get totalIncome => months.fold(0, (s, m) => s + m.income);
  double get totalExpenses => months.fold(0, (s, m) => s + m.expenses);
  double get totalNet => totalIncome - totalExpenses;
  double get maxValue => months.fold(0, (s, m) => s + m.income > s + m.expenses ? s + m.income : s + m.expenses);
  const YearReport(this.months);
}

final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);

final _yearPaymentsProvider = StreamProvider.family<List<Payment>, int>((ref, year) {
  final repo = ref.watch(paymentRepositoryProvider);
  return repo.watchPaidForYear(year);
});

final _yearExpensesProvider = StreamProvider.family<List<Expense>, int>((ref, year) {
  final repo = ref.watch(expenseRepositoryProvider);
  return repo.watchForYear(year);
});

final yearReportProvider = Provider<AsyncValue<YearReport>>((ref) {
  final year = ref.watch(selectedYearProvider);
  final paymentsAsync = ref.watch(_yearPaymentsProvider(year));
  final expensesAsync = ref.watch(_yearExpensesProvider(year));

  return paymentsAsync.when(
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
    data: (payments) => expensesAsync.when(
      loading: () => const AsyncValue.loading(),
      error: AsyncValue.error,
      data: (expenses) {
        final months = List.generate(12, (i) {
          final start = DateTime(year, i + 1, 1);
          final end = DateTime(year, i + 2, 1);
          final income = payments
              .where((p) => !p.date.isBefore(start) && p.date.isBefore(end))
              .fold<double>(0.0, (sum, p) => sum + p.amount);
          final expense = expenses
              .where((e) => !e.date.isBefore(start) && e.date.isBefore(end))
              .fold<double>(0.0, (sum, e) => sum + e.amount);
          return MonthStat(month: start, income: income, expenses: expense);
        });
        return AsyncValue.data(YearReport(months));
      },
    ),
  );
});
