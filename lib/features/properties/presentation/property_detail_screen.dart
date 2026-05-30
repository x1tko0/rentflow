import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/enums.dart';
import '../../../core/services/pdf_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../features/settings/settings_provider.dart';
import '../../meters/presentation/meters_screen.dart';
import '../../tenants/presentation/tenant_detail_screen.dart';
import 'property_form_screen.dart';

final _propertyTenantsProvider = StreamProvider.family<List<Tenant>, String>(
  (ref, propertyId) => ref.watch(tenantRepositoryProvider).watchByProperty(propertyId),
);

final _propertyPaymentsProvider = StreamProvider.family<List<Payment>, String>(
  (ref, propertyId) => ref.watch(paymentRepositoryProvider).watchByProperty(propertyId),
);

final _propertyExpensesProvider = StreamProvider.family<List<Expense>, String>(
  (ref, propertyId) => ref.watch(expenseRepositoryProvider).watchByProperty(propertyId),
);

final _propertyMeterReadingsProvider = StreamProvider.family<List<MeterReading>, String>(
  (ref, propertyId) => ref.watch(meterRepositoryProvider).watchByProperty(propertyId),
);

class PropertyDetailScreen extends ConsumerWidget {
  final Property property;
  const PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currency = ref.watch(settingsProvider).currency;
    final tenantsAsync = ref.watch(_propertyTenantsProvider(property.id));
    final paymentsAsync = ref.watch(_propertyPaymentsProvider(property.id));
    final expensesAsync = ref.watch(_propertyExpensesProvider(property.id));
    final locale = Localizations.localeOf(context).toString();
    final theme = Theme.of(context);
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 1);

    final thisMonthIncome = paymentsAsync.valueOrNull
            ?.where((p) =>
                p.status == 'paid' &&
                p.date.isAfter(monthStart.subtract(const Duration(seconds: 1))) &&
                p.date.isBefore(monthEnd))
            .fold<double>(0, (s, p) => s + p.amount) ??
        0;

    final thisMonthExpenses = expensesAsync.valueOrNull
            ?.where((e) =>
                e.date.isAfter(monthStart.subtract(const Duration(seconds: 1))) &&
                e.date.isBefore(monthEnd))
            .fold<double>(0, (s, e) => s + e.amount) ??
        0;

    final type = PropertyType.fromValue(property.type);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.propertyDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PropertyFormScreen(property: property)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          _PropertyHeader(property: property, type: type, l10n: l10n, currency: currency),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatCard(
                label: l10n.income,
                sublabel: l10n.thisMonth,
                value: formatMoney(thisMonthIncome, currency: currency),
                color: const Color(0xFF34C759),
                icon: Icons.arrow_upward_rounded,
              )),
              const SizedBox(width: 10),
              Expanded(child: _StatCard(
                label: l10n.expenses,
                sublabel: l10n.thisMonth,
                value: formatMoney(thisMonthExpenses, currency: currency),
                color: const Color(0xFFFF3B30),
                icon: Icons.arrow_downward_rounded,
              )),
            ],
          ),
          const SizedBox(height: 24),
          Text(l10n.tenantsTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          tenantsAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text(e.toString()),
            data: (tenants) => tenants.isEmpty
                ? _EmptySection(icon: Icons.people_outline, text: l10n.noActiveTenants)
                : Column(
                    children: tenants.map((t) => _TenantRow(tenant: t, currency: currency, l10n: l10n, locale: locale)).toList(),
                  ),
          ),
          const SizedBox(height: 24),
          _MetersSection(property: property, l10n: l10n, locale: locale),
          const SizedBox(height: 24),
          Text(l10n.paymentHistory, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          paymentsAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text(e.toString()),
            data: (payments) {
              final recent = payments.take(5).toList();
              return recent.isEmpty
                  ? _EmptySection(icon: Icons.payments_outlined, text: l10n.noPayments)
                  : Column(children: recent.map((p) => _PaymentRow(payment: p, currency: currency, locale: locale)).toList());
            },
          ),
        ],
      ),
    );
  }
}

class _PropertyHeader extends StatelessWidget {
  final Property property;
  final PropertyType type;
  final AppLocalizations l10n;
  final String currency;
  const _PropertyHeader({required this.property, required this.type, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(14)),
            child: Icon(_typeIcon(type), color: theme.colorScheme.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property.name, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(property.address, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 6),
                Row(children: [
                  _Chip(label: type.l10n(l10n)),
                  if (property.area != null) ...[
                    const SizedBox(width: 6),
                    _Chip(label: '${property.area!.toStringAsFixed(0)} м²'),
                  ],
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _typeIcon(PropertyType type) => switch (type) {
        PropertyType.apartment => Icons.apartment,
        PropertyType.house => Icons.house_outlined,
        PropertyType.room => Icons.meeting_room_outlined,
      };
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String sublabel;
  final String value;
  final Color color;
  final IconData icon;
  const _StatCard({required this.label, required this.sublabel, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Text(label, style: theme.textTheme.labelSmall?.copyWith(color: color)),
          ]),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
          Text(sublabel, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _TenantRow extends StatelessWidget {
  final Tenant tenant;
  final String currency;
  final AppLocalizations l10n;
  final String locale;
  const _TenantRow({required this.tenant, required this.currency, required this.l10n, required this.locale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = '${tenant.firstName.isNotEmpty ? tenant.firstName[0] : '?'}${tenant.lastName.isNotEmpty ? tenant.lastName[0] : ''}'.toUpperCase();
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TenantDetailScreen(tenant: tenant))),
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
              radius: 20,
              backgroundColor: theme.colorScheme.secondaryContainer,
              child: Text(initials, style: TextStyle(color: theme.colorScheme.onSecondaryContainer, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${tenant.firstName} ${tenant.lastName}', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  Text('${formatMoney(tenant.rentAmount, currency: currency)}${l10n.perMonth}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 18),
          ],
        ),
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
    final statusColor = switch (status) {
      PaymentStatus.paid => const Color(0xFF34C759),
      PaymentStatus.overdue => const Color(0xFFFF3B30),
      PaymentStatus.pending => const Color(0xFFFF9500),
    };
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(child: Text(formatDate(payment.date, locale: locale), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant))),
          Text(formatMoney(payment.amount, currency: currency), style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
            child: Text(status.l10n(l10n), style: theme.textTheme.labelSmall?.copyWith(color: statusColor)),
          ),
        ],
      ),
    );
  }
}

class _MetersSection extends ConsumerStatefulWidget {
  final Property property;
  final AppLocalizations l10n;
  final String locale;
  const _MetersSection({required this.property, required this.l10n, required this.locale});

  @override
  ConsumerState<_MetersSection> createState() => _MetersSectionState();
}

class _MetersSectionState extends ConsumerState<_MetersSection> {
  bool _exporting = false;

  Future<void> _exportPdf() async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime(now.year, now.month, 1),
        end: DateTime(now.year, now.month + 1, 0),
      ),
    );
    if (!mounted || range == null) return;
    setState(() => _exporting = true);
    try {
      final readings = await ref.read(meterRepositoryProvider).getByProperty(widget.property.id);
      if (!mounted) return;
      final l10n = widget.l10n;
      final dateFmt = DateFormat('dd.MM.yyyy', widget.locale);
      await PdfService.exportMeterReport(
        widget.property,
        readings,
        locale: widget.locale,
        dateRange: range,
        labels: MeterPdfLabels(
          reportTitle: l10n.meterPdfTitle,
          previous: l10n.meterPdfPrevious,
          current: l10n.meterPdfCurrent,
          consumption: l10n.consumption,
          totalConsumption: l10n.meterPdfTotalConsumption,
          elecTotal: l10n.meterPdfElecTotal,
          generatedBy: l10n.meterPdfGeneratedBy,
          noReadings: l10n.noReadings,
          waterCold: l10n.meterWaterCold,
          waterHot: l10n.meterWaterHot,
          gas: l10n.meterGas,
          electricity: l10n.meterElectricity,
          electricityT1: l10n.meterElectricityT1,
          electricityT2: l10n.meterElectricityT2,
          electricityT3: l10n.meterElectricityT3,
          heat: l10n.meterHeat,
          date: l10n.date,
          period: l10n.pdfPeriod,
        ),
      );
      if (mounted) {
        final periodStr = '${dateFmt.format(range.start)} – ${dateFmt.format(range.end)}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF: $periodStr')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  void _openMeters(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MetersScreen(property: widget.property)),
      );

  void _openHistory(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MeterHistoryScreen(property: widget.property),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  decoration: BoxDecoration(
                    color: const Color(0xFF007AFF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.speed_outlined, color: Color(0xFF007AFF), size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(widget.l10n.meterReadings,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant, size: 20),
                  onSelected: (v) {
                    if (v == 'meters') _openMeters(context);
                    if (v == 'history') _openHistory(context);
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'meters',
                      child: Row(children: [
                        const Icon(Icons.speed_outlined, size: 18),
                        const SizedBox(width: 10),
                        Text(widget.l10n.meterReadings),
                      ]),
                    ),
                    PopupMenuItem(
                      value: 'history',
                      child: Row(children: [
                        const Icon(Icons.history, size: 18),
                        const SizedBox(width: 10),
                        Text(widget.l10n.meterHistory),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: _exporting ? null : _exportPdf,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 52,
            height: 68,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: _exporting
                ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.picture_as_pdf_outlined,
                          color: const Color(0xFFFF3B30), size: 22),
                      const SizedBox(height: 2),
                      Text('PDF',
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: const Color(0xFFFF3B30),
                              fontWeight: FontWeight.w700,
                              fontSize: 9)),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class MeterHistoryScreen extends ConsumerWidget {
  final Property property;
  const MeterHistoryScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final readingsAsync = ref.watch(_propertyMeterReadingsProvider(property.id));
    final theme = Theme.of(context);
    final now = DateTime.now();
    final currentMonthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final monthFmt = DateFormat('MMMM yyyy', locale);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.meterHistory)),
      body: readingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (readings) {
          if (readings.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.speed_outlined, size: 48,
                      color: theme.colorScheme.outlineVariant),
                  const SizedBox(height: 12),
                  Text(l10n.noReadings,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            );
          }

          // Group by month key "yyyy-MM", sorted descending
          final Map<String, List<MeterReading>> grouped = {};
          for (final r in readings) {
            final key = '${r.date.year}-${r.date.month.toString().padLeft(2, '0')}';
            grouped.putIfAbsent(key, () => []).add(r);
          }
          final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            itemCount: sortedKeys.length,
            itemBuilder: (_, i) {
              final key = sortedKeys[i];
              final monthReadings = grouped[key]!;
              final date = DateTime(int.parse(key.split('-')[0]), int.parse(key.split('-')[1]));
              final isCurrentMonth = key == currentMonthKey;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: ExpansionTile(
                    initiallyExpanded: isCurrentMonth,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    title: Row(
                      children: [
                        Text(
                          monthFmt.format(date).toUpperCase()[0] +
                              monthFmt.format(date).substring(1),
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('${monthReadings.length}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant)),
                        ),
                      ],
                    ),
                    children: monthReadings
                        .map((r) => _ReadingHistoryRow(reading: r, locale: locale))
                        .toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ReadingHistoryRow extends StatelessWidget {
  final MeterReading reading;
  final String locale;
  const _ReadingHistoryRow({required this.reading, required this.locale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final color = _typeColor(reading.type);
    final icon = _typeIcon(reading.type);
    final name = _typeName(reading.type, l10n);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                Text(reading.value.toStringAsFixed(2),
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Text(formatDate(reading.date, locale: locale),
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Color _typeColor(String type) => switch (type) {
        'water_cold' => const Color(0xFF007AFF),
        'water_hot' => const Color(0xFFFF9500),
        'gas' => const Color(0xFFFF6B35),
        'electricity' => const Color(0xFFFFCC00),
        'electricity_t1' => const Color(0xFFFFD60A),
        'electricity_t2' => const Color(0xFF5856D6),
        'electricity_t3' => const Color(0xFF34C759),
        'heat' => const Color(0xFFFF3B30),
        _ => const Color(0xFF8E8E93),
      };

  IconData _typeIcon(String type) => switch (type) {
        'water_cold' => Icons.water_drop_outlined,
        'water_hot' => Icons.water_drop,
        'gas' => Icons.local_fire_department_outlined,
        'electricity' || 'electricity_t1' => Icons.bolt_outlined,
        'electricity_t2' => Icons.nights_stay_outlined,
        'electricity_t3' => Icons.light_mode_outlined,
        'heat' => Icons.thermostat_outlined,
        _ => Icons.tune_outlined,
      };

  String _typeName(String type, AppLocalizations l10n) => switch (type) {
        'water_cold' => l10n.meterWaterCold,
        'water_hot' => l10n.meterWaterHot,
        'gas' => l10n.meterGas,
        'electricity' => l10n.meterElectricity,
        'electricity_t1' => l10n.meterElectricityT1,
        'electricity_t2' => l10n.meterElectricityT2,
        'electricity_t3' => l10n.meterElectricityT3,
        'heat' => l10n.meterHeat,
        _ => type,
      };
}

class _EmptySection extends StatelessWidget {
  final IconData icon;
  final String text;
  const _EmptySection({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.outlineVariant),
          const SizedBox(width: 8),
          Text(text, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
