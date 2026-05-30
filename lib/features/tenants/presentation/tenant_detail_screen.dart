import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/enums.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../features/settings/settings_provider.dart';
import 'tenant_form_screen.dart';

final _tenantPaymentsProvider = StreamProvider.family<List<Payment>, String>(
  (ref, tenantId) => ref.watch(paymentRepositoryProvider).watchByTenant(tenantId),
);

final _tenantByIdProvider = StreamProvider.family<Tenant?, String>(
  (ref, id) => ref.watch(tenantRepositoryProvider).watchById(id),
);

class TenantDetailScreen extends ConsumerWidget {
  final Tenant tenant;
  const TenantDetailScreen({super.key, required this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currency = ref.watch(settingsProvider).currency;
    final paymentsAsync = ref.watch(_tenantPaymentsProvider(tenant.id));
    final currentTenant = ref.watch(_tenantByIdProvider(tenant.id)).valueOrNull ?? tenant;
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final initials = '${currentTenant.firstName.isNotEmpty ? currentTenant.firstName[0] : '?'}${currentTenant.lastName.isNotEmpty ? currentTenant.lastName[0] : ''}'.toUpperCase();
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentTenant.firstName} ${currentTenant.lastName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TenantFormScreen(tenant: currentTenant)),
            ),
          ),
        ],
      ),
      body: paymentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (payments) {
          final monthStart = DateTime(now.year, now.month, 1);
          final monthEnd = DateTime(now.year, now.month + 1, 1);
          final thisMonthTotal = payments
              .where((p) =>
                  p.status == 'paid' &&
                  p.date.isAfter(monthStart.subtract(const Duration(seconds: 1))) &&
                  p.date.isBefore(monthEnd))
              .fold<double>(0, (s, p) => s + p.amount);
          final allTimeTotal = payments
              .where((p) => p.status == 'paid')
              .fold<double>(0, (s, p) => s + p.amount);
          final overdueCount = payments.where((p) => p.status == 'overdue').length;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            children: [
              _TenantHeader(tenant: currentTenant, initials: initials, currency: currency, l10n: l10n, locale: locale),
              const SizedBox(height: 16),
              _StatsRow(
                thisMonth: thisMonthTotal,
                allTime: allTimeTotal,
                overdueCount: overdueCount,
                currency: currency,
                l10n: l10n,
              ),
              const SizedBox(height: 24),
              Text(l10n.paymentHistory, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              if (payments.isEmpty)
                _EmptyPayments(l10n: l10n)
              else
                ...payments.map((p) => _PaymentRow(payment: p, currency: currency, locale: locale)),
            ],
          );
        },
      ),
    );
  }
}

class _TenantHeader extends StatelessWidget {
  final Tenant tenant;
  final String initials;
  final String currency;
  final AppLocalizations l10n;
  final String locale;
  const _TenantHeader({required this.tenant, required this.initials, required this.currency, required this.l10n, required this.locale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysLeft = tenant.leaseEnd?.difference(DateTime.now()).inDays;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(initials, style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 20)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${tenant.firstName} ${tenant.lastName}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(tenant.phone, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    if (tenant.email != null)
                      Text(tenant.email!, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Row(
            children: [
              _HeaderInfo(
                icon: Icons.payments_outlined,
                label: l10n.rentPerMonth,
                value: formatMoney(tenant.rentAmount, currency: currency),
              ),
              _HeaderInfo(
                icon: Icons.calendar_today_outlined,
                label: l10n.leaseStart,
                value: formatDate(tenant.leaseStart, locale: locale),
              ),
              if (daysLeft != null)
                _HeaderInfo(
                  icon: Icons.timer_outlined,
                  label: l10n.remaining,
                  value: daysLeft > 0 ? l10n.daysLeft(daysLeft) : l10n.expired,
                  valueColor: daysLeft <= 30 ? const Color(0xFFFF9500) : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  const _HeaderInfo({required this.icon, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, size: 12, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ]),
          const SizedBox(height: 2),
          Text(value, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: valueColor ?? theme.colorScheme.onSurface)),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final double thisMonth;
  final double allTime;
  final int overdueCount;
  final String currency;
  final AppLocalizations l10n;
  const _StatsRow({required this.thisMonth, required this.allTime, required this.overdueCount, required this.currency, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(label: l10n.thisMonth, value: formatMoney(thisMonth, currency: currency), color: const Color(0xFF34C759))),
        const SizedBox(width: 10),
        Expanded(child: _StatCard(label: l10n.totalPaid, value: formatMoney(allTime, currency: currency), color: const Color(0xFF4F6AF0))),
        const SizedBox(width: 10),
        Expanded(child: _StatCard(label: l10n.overduePaymentsCount(overdueCount), value: '$overdueCount', color: overdueCount > 0 ? const Color(0xFFFF3B30) : const Color(0xFF8E8E93))),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 2),
          Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final Payment payment;
  final String currency;
  final String locale;
  const _PaymentRow({required this.payment, required this.currency, required this.locale});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final status = PaymentStatus.fromValue(payment.status);
    final type = PaymentType.values.firstWhere((t) => t.value == payment.type, orElse: () => PaymentType.other);
    final statusColor = switch (status) {
      PaymentStatus.paid => const Color(0xFF34C759),
      PaymentStatus.overdue => const Color(0xFFFF3B30),
      PaymentStatus.pending => const Color(0xFFFF9500),
    };

    return Container(
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(_typeIcon(type), color: statusColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type.l10n(l10n), style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                Text(formatDate(payment.date, locale: locale), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(formatMoney(payment.amount, currency: currency), style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                child: Text(status.l10n(l10n), style: theme.textTheme.labelSmall?.copyWith(color: statusColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _typeIcon(PaymentType type) => switch (type) {
        PaymentType.rent => Icons.home_outlined,
        PaymentType.deposit => Icons.shield_outlined,
        PaymentType.utility => Icons.bolt_outlined,
        PaymentType.other => Icons.receipt_outlined,
      };
}

class _EmptyPayments extends StatelessWidget {
  final AppLocalizations l10n;
  const _EmptyPayments({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(Icons.payments_outlined, size: 48, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 12),
          Text(l10n.noPayments, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
