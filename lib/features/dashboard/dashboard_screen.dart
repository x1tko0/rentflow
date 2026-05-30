import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/formatters.dart';
import '../../generated/app_localizations.dart';
import '../settings/settings_provider.dart';
import 'dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final income = ref.watch(monthlyIncomeProvider);
    final expenses = ref.watch(monthlyExpensesProvider);
    final tenants = ref.watch(activeTenantsProvider);
    final overdue = ref.watch(overduePaymentsProvider);
    final properties = ref.watch(propertiesProvider);
    final currency = ref.watch(settingsProvider).currency;
    final theme = Theme.of(context);
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            snap: true,
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('icons/1024.png', width: 32, height: 32),
                ),
                const SizedBox(width: 10),
                const Text('RentFlow', style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.go('/settings'),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _MonthHeader(date: now),
                const SizedBox(height: 16),
                _IncomeExpenseRow(income: income, expenses: expenses, l10n: l10n, currency: currency),
                const SizedBox(height: 16),
                _NetCard(income: income, expenses: expenses, l10n: l10n, currency: currency),
                const SizedBox(height: 24),
                _SectionTitle(l10n.propertiesTitle, onTap: () => context.go('/properties'), seeAll: l10n.seeAll),
                const SizedBox(height: 10),
                properties.when(
                  data: (list) => list.isEmpty
                      ? _EmptyCard(
                          icon: Icons.home_outlined,
                          text: l10n.addFirstProperty,
                          action: l10n.add,
                          onTap: () => context.go('/properties'),
                        )
                      : _PropertyList(properties: list),
                  loading: () => const _LoadingCard(),
                  error: (e, _) => _ErrorCard(message: e.toString()),
                ),
                const SizedBox(height: 24),
                _SectionTitle(l10n.tenantsTitle, onTap: () => context.go('/tenants'), seeAll: l10n.seeAll),
                const SizedBox(height: 10),
                tenants.when(
                  data: (list) => list.isEmpty
                      ? _EmptyCard(
                          icon: Icons.people_outline,
                          text: l10n.noActiveTenants,
                          action: l10n.add,
                          onTap: () => context.go('/tenants'),
                        )
                      : _TenantList(tenants: list, currency: currency),
                  loading: () => const _LoadingCard(),
                  error: (e, _) => _ErrorCard(message: e.toString()),
                ),
                const SizedBox(height: 24),
                overdue.when(
                  data: (list) => list.isEmpty
                      ? const SizedBox.shrink()
                      : _OverdueSection(count: list.length, l10n: l10n, onView: () => context.go('/payments')),
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => const SizedBox.shrink(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final DateTime date;
  const _MonthHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      formatMonth(date, locale: Localizations.localeOf(context).toString()),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}

class _IncomeExpenseRow extends StatelessWidget {
  final AsyncValue<double> income;
  final AsyncValue<double> expenses;
  final AppLocalizations l10n;
  final String currency;
  const _IncomeExpenseRow({required this.income, required this.expenses, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(
          label: l10n.income,
          value: income,
          color: const Color(0xFF34C759),
          icon: Icons.arrow_upward_rounded,
          currency: currency,
        )),
        const SizedBox(width: 12),
        Expanded(child: _StatCard(
          label: l10n.expenses,
          value: expenses,
          color: const Color(0xFFFF3B30),
          icon: Icons.arrow_downward_rounded,
          currency: currency,
        )),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final AsyncValue<double> value;
  final Color color;
  final IconData icon;
  final String currency;
  const _StatCard({required this.label, required this.value, required this.color, required this.icon, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(label, style: theme.textTheme.labelMedium?.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 8),
          value.when(
            data: (v) => Text(
              formatMoney(v, currency: currency),
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface),
            ),
            loading: () => const _Skeleton(width: 80, height: 24),
            error: (e, _) => const Text('—'),
          ),
        ],
      ),
    );
  }
}

class _NetCard extends StatelessWidget {
  final AsyncValue<double> income;
  final AsyncValue<double> expenses;
  final AppLocalizations l10n;
  final String currency;
  const _NetCard({required this.income, required this.expenses, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final incomeVal = income.valueOrNull ?? 0;
    final expVal = expenses.valueOrNull ?? 0;
    final net = incomeVal - expVal;
    final isPositive = net >= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.netIncome, style: theme.textTheme.labelLarge?.copyWith(color: Colors.white70)),
              const SizedBox(height: 4),
              Text(
                formatMoney(net, currency: currency),
                style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String seeAll;
  final VoidCallback onTap;
  const _SectionTitle(this.title, {required this.onTap, required this.seeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        GestureDetector(
          onTap: onTap,
          child: Text(seeAll, style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
        ),
      ],
    );
  }
}

class _PropertyList extends StatelessWidget {
  final List<dynamic> properties;
  const _PropertyList({required this.properties});

  @override
  Widget build(BuildContext context) {
    return Column(children: properties.take(3).map((p) => _PropertyTile(property: p)).toList());
  }
}

class _PropertyTile extends StatelessWidget {
  final dynamic property;
  const _PropertyTile({required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.go('/properties'),
        child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.home_outlined, color: theme.colorScheme.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property.name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(property.address, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
        ],
      ),
        ),
      ),
    );
  }
}

class _TenantList extends StatelessWidget {
  final List<dynamic> tenants;
  final String currency;
  const _TenantList({required this.tenants, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Column(children: tenants.take(3).map((t) => _TenantTile(tenant: t, currency: currency)).toList());
  }
}

class _TenantTile extends StatelessWidget {
  final dynamic tenant;
  final String currency;
  const _TenantTile({required this.tenant, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final initials = '${tenant.firstName.isNotEmpty ? tenant.firstName[0] : '?'}${tenant.lastName.isNotEmpty ? tenant.lastName[0] : ''}'.toUpperCase();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.go('/tenants'),
        child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: theme.colorScheme.secondaryContainer,
            child: Text(initials, style: TextStyle(color: theme.colorScheme.onSecondaryContainer, fontWeight: FontWeight.w700, fontSize: 14)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${tenant.firstName} ${tenant.lastName}', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('${formatMoney(tenant.rentAmount, currency: currency)} ${l10n.perMonth}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
        ],
      ),
        ),
      ),
    );
  }
}

class _OverdueSection extends StatelessWidget {
  final int count;
  final AppLocalizations l10n;
  final VoidCallback onView;
  const _OverdueSection({required this.count, required this.l10n, required this.onView});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF3B30).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Color(0xFFFF3B30), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.overduePaymentsCount(count),
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xFFFF3B30)),
                ),
                Text(l10n.requiresAttention, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          TextButton(onPressed: onView, child: Text(l10n.view)),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String action;
  final VoidCallback onTap;
  const _EmptyCard({required this.icon, required this.text, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(text, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            Text('+ $action', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) => const _Skeleton(width: double.infinity, height: 80);
}

class _ErrorCard extends StatelessWidget {
  final String message;
  const _ErrorCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: BorderRadius.circular(14)),
      child: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer)),
    );
  }
}

class _Skeleton extends StatelessWidget {
  final double width;
  final double height;
  const _Skeleton({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
    );
  }
}
