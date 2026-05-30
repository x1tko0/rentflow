import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/services/billing_service.dart';
import 'core/services/crash_reporting_service.dart';
import 'core/services/notification_service.dart';
import 'data/database/app_database.dart';
import 'data/repositories/payment_repository.dart';
import 'data/repositories/recurring_expense_repository.dart';
import 'shared/providers/database_provider.dart';

late final SharedPreferences globalPrefs;

final _rootKey = GlobalKey<_AppRootState>();
void restartApp() => _rootKey.currentState?._restart();

bool skipBiometricOnce = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CrashReportingService.init();
  await initializeDateFormatting();
  await NotificationService.init();
  globalPrefs = await SharedPreferences.getInstance();
  await BillingService.init();
  runApp(_AppRoot(key: _rootKey));
}

class _AppRoot extends StatefulWidget {
  const _AppRoot({super.key});

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  Key _coreKey = UniqueKey();

  void _restart() {
    if (mounted) setState(() => _coreKey = UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return _AppCore(key: _coreKey);
  }
}

class _AppCore extends StatefulWidget {
  const _AppCore({super.key});

  @override
  State<_AppCore> createState() => _AppCoreState();
}

class _AppCoreState extends State<_AppCore> {
  late Future<AppDatabase> _dbFuture;

  @override
  void initState() {
    super.initState();
    _dbFuture = _initDb();
  }

  Future<AppDatabase> _initDb() async {
    final db = AppDatabase();
    await PaymentRepository(db).markOverduePayments();
    await RecurringExpenseRepository(db).autoCreateForMonth(DateTime.now());
    return db;
  }

  @override
  void dispose() {
    _dbFuture.then((db) => db.close()).ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future: _dbFuture,
      builder: (ctx, snap) {
        if (!snap.hasData) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        return ProviderScope(
          overrides: [databaseProvider.overrideWithValue(snap.data!)],
          child: const RentFlowApp(),
        );
      },
    );
  }
}
