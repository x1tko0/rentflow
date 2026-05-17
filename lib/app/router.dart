import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/properties/presentation/properties_screen.dart';
import '../features/tenants/presentation/tenants_screen.dart';
import '../features/payments/presentation/payments_screen.dart';
import '../features/expenses/presentation/expenses_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (ctx, _) => const DashboardScreen()),
        GoRoute(path: '/properties', builder: (ctx, _) => const PropertiesScreen()),
        GoRoute(path: '/tenants', builder: (ctx, _) => const TenantsScreen()),
        GoRoute(path: '/payments', builder: (ctx, _) => const PaymentsScreen()),
        GoRoute(path: '/expenses', builder: (ctx, _) => const ExpensesScreen()),
        GoRoute(path: '/reports', builder: (ctx, _) => const ReportsScreen()),
        GoRoute(path: '/settings', builder: (ctx, _) => const SettingsScreen()),
      ],
    ),
  ],
);

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final location = GoRouterState.of(context).uri.path;
    final index = switch (location) {
      '/' => 0,
      '/properties' => 1,
      '/tenants' => 2,
      '/payments' => 3,
      '/expenses' => 4,
      '/reports' => 5,
      '/settings' => 6,
      _ => 0,
    };

    const routes = ['/', '/properties', '/tenants', '/payments', '/expenses', '/reports'];

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (details) {
          final v = details.primaryVelocity ?? 0;
          if (v < -300 && index < routes.length - 1) context.go(routes[index + 1]);
          if (v > 300 && index > 0) context.go(routes[index - 1]);
        },
        child: child,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index > 5 ? 0 : index,
        onDestinationSelected: (i) => context.go(routes[i]),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.dashboard_outlined), selectedIcon: const Icon(Icons.dashboard), label: l10n.navDashboard),
          NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: l10n.navProperties),
          NavigationDestination(icon: const Icon(Icons.people_outlined), selectedIcon: const Icon(Icons.people), label: l10n.navTenants),
          NavigationDestination(icon: const Icon(Icons.payments_outlined), selectedIcon: const Icon(Icons.payments), label: l10n.navPayments),
          NavigationDestination(icon: const Icon(Icons.receipt_long_outlined), selectedIcon: const Icon(Icons.receipt_long), label: l10n.navExpenses),
          NavigationDestination(icon: const Icon(Icons.bar_chart_outlined), selectedIcon: const Icon(Icons.bar_chart), label: l10n.navReports),
        ],
      ),
    );
  }
}
