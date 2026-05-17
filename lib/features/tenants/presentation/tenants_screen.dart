import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../features/dashboard/dashboard_providers.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../features/settings/settings_provider.dart';
import '../../../shared/widgets/confirm_dialog.dart';
import 'tenant_form_screen.dart';

class TenantsScreen extends ConsumerWidget {
  const TenantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tenants = ref.watch(activeTenantsProvider);
    final currency = ref.watch(settingsProvider).currency;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tenantsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context, ref, null),
        icon: const Icon(Icons.person_add_outlined),
        label: Text(l10n.add),
      ),
      body: tenants.when(
        data: (list) => list.isEmpty
            ? _EmptyState(l10n: l10n)
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                itemCount: list.length,
                itemBuilder: (ctx, i) => _TenantCard(
                  tenant: list[i],
                  currency: currency,
                  onEdit: () => _openForm(context, ref, list[i]),
                  onDelete: () => _delete(context, ref, list[i], l10n),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Future<void> _openForm(BuildContext context, WidgetRef ref, Tenant? tenant) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TenantFormScreen(tenant: tenant)),
    );
    if (result == true) ref.invalidate(activeTenantsProvider);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Tenant tenant, AppLocalizations l10n) async {
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.deleteTenantTitle,
      message: l10n.deleteTenantMessage('${tenant.firstName} ${tenant.lastName}'),
    );
    if (confirmed) {
      await ref.read(tenantRepositoryProvider).delete(tenant.id);
    }
  }
}

class _TenantCard extends StatelessWidget {
  final Tenant tenant;
  final String currency;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _TenantCard({required this.tenant, required this.currency, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final initials = '${tenant.firstName[0]}${tenant.lastName[0]}'.toUpperCase();
    final daysLeft = tenant.leaseEnd?.difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(initials, style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${tenant.firstName} ${tenant.lastName}', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(tenant.phone, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
                  onSelected: (v) {
                    if (v == 'edit') onEdit();
                    if (v == 'delete') onDelete();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                    PopupMenuItem(value: 'delete', child: Text(l10n.delete, style: const TextStyle(color: Color(0xFFFF3B30)))),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _InfoItem(icon: Icons.payments_outlined, label: l10n.rent, value: '${formatMoney(tenant.rentAmount, currency: currency)}${l10n.perMonth}'),
                const SizedBox(width: 16),
                _InfoItem(icon: Icons.calendar_today_outlined, label: l10n.paymentDay, value: l10n.paymentDayValue(tenant.paymentDay)),
                if (daysLeft != null) ...[
                  const SizedBox(width: 16),
                  _InfoItem(
                    icon: Icons.timer_outlined,
                    label: l10n.remaining,
                    value: daysLeft > 0 ? l10n.daysLeft(daysLeft) : l10n.expired,
                    valueColor: daysLeft <= 30 ? const Color(0xFFFF9500) : null,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  const _InfoItem({required this.icon, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 2),
          Text(value, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: valueColor ?? theme.colorScheme.onSurface)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final AppLocalizations l10n;
  const _EmptyState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(l10n.noTenants, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.tapToStart, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
