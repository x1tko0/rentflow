import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/repository_providers.dart';

final monthlyIncomeProvider = StreamProvider<double>((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return repo.watchSumPaidForMonth(DateTime.now());
});

final monthlyExpensesProvider = StreamProvider<double>((ref) {
  final repo = ref.watch(expenseRepositoryProvider);
  return repo.watchSumForMonth(DateTime.now());
});

final activeTenantsProvider = StreamProvider((ref) {
  final repo = ref.watch(tenantRepositoryProvider);
  return repo.watchActive();
});

final overduePaymentsProvider = StreamProvider((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return repo.watchOverdue();
});

final propertiesProvider = StreamProvider((ref) {
  final repo = ref.watch(propertyRepositoryProvider);
  return repo.watchAll();
});
