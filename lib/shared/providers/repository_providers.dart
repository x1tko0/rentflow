import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/property_repository.dart';
import '../../data/repositories/tenant_repository.dart';
import '../../data/repositories/payment_repository.dart';
import '../../data/repositories/expense_repository.dart';
import '../../data/repositories/recurring_expense_repository.dart';
import '../../data/repositories/custom_category_repository.dart';
import '../../data/repositories/meter_repository.dart';
import 'database_provider.dart';

final propertyRepositoryProvider = Provider((ref) =>
    PropertyRepository(ref.watch(databaseProvider)));

final tenantRepositoryProvider = Provider((ref) =>
    TenantRepository(ref.watch(databaseProvider)));

final paymentRepositoryProvider = Provider((ref) =>
    PaymentRepository(ref.watch(databaseProvider)));

final expenseRepositoryProvider = Provider((ref) =>
    ExpenseRepository(ref.watch(databaseProvider)));

final recurringExpenseRepositoryProvider = Provider((ref) =>
    RecurringExpenseRepository(ref.watch(databaseProvider)));

final customCategoryRepositoryProvider = Provider((ref) =>
    CustomCategoryRepository(ref.watch(databaseProvider)));

final meterRepositoryProvider = Provider((ref) =>
    MeterRepository(ref.watch(databaseProvider)));
