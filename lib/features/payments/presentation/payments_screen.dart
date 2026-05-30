import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/enums.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../features/dashboard/dashboard_providers.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../features/settings/settings_provider.dart';
import '../../../shared/widgets/app_text_field.dart';

final _paymentsListProvider = StreamProvider<List<Payment>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.payments)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

class PaymentsScreen extends ConsumerStatefulWidget {
  const PaymentsScreen({super.key});

  @override
  ConsumerState<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends ConsumerState<PaymentsScreen> {
  bool _calendarView = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final payments = ref.watch(_paymentsListProvider);
    final currency = ref.watch(settingsProvider).currency;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.paymentsTitle),
        actions: [
          IconButton(
            icon: Icon(_calendarView ? Icons.list_outlined : Icons.calendar_month_outlined),
            onPressed: () => setState(() => _calendarView = !_calendarView),
          ),
        ],
      ),
      floatingActionButton: _calendarView
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _showAddSheet(context),
              icon: const Icon(Icons.add),
              label: Text(l10n.add),
            ),
      body: payments.when(
        data: (list) {
          if (_calendarView) {
            return _PaymentCalendar(payments: list, currency: currency);
          }
          return list.isEmpty
              ? _EmptyState(l10n: l10n)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: list.length,
                  itemBuilder: (ctx, i) => _PaymentTile(
                    payment: list[i],
                    currency: currency,
                    onMarkPaid: list[i].status != 'paid'
                        ? () => ref.read(paymentRepositoryProvider).markPaid(list[i].id)
                        : null,
                  ),
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AddPaymentSheet(ref: ref),
    );
  }
}

// ── Calendar view ────────────────────────────────────────────────────────────

class _PaymentCalendar extends StatefulWidget {
  final List<Payment> payments;
  final String currency;
  const _PaymentCalendar({required this.payments, required this.currency});

  @override
  State<_PaymentCalendar> createState() => _PaymentCalendarState();
}

class _PaymentCalendarState extends State<_PaymentCalendar> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  Map<DateTime, List<Payment>> get _byDay {
    final result = <DateTime, List<Payment>>{};
    for (final p in widget.payments) {
      final key = DateTime(p.date.year, p.date.month, p.date.day);
      result.putIfAbsent(key, () => []).add(p);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final byDay = _byDay;

    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final firstWeekday = DateTime(_month.year, _month.month, 1).weekday; // 1=Mon
    final blanks = firstWeekday - 1;
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // Single-letter weekday names (Mon=0 in Jan 2024 grid, weekday 1)
    final dayLabels = List.generate(7, (i) =>
        DateFormat.E(locale).format(DateTime(2024, 1, 1 + i)).substring(0, 1).toUpperCase());

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
      children: [
        // Month navigator
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => setState(() => _month = DateTime(_month.year, _month.month - 1)),
            ),
            Expanded(
              child: Text(
                formatMonth(_month, locale: locale),
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => setState(() => _month = DateTime(_month.year, _month.month + 1)),
            ),
          ],
        ),
        // Weekday labels
        Row(
          children: dayLabels.map((d) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(d,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          )).toList(),
        ),
        // Day grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.9,
          ),
          itemCount: blanks + daysInMonth,
          itemBuilder: (_, i) {
            if (i < blanks) return const SizedBox.shrink();
            final day = i - blanks + 1;
            final date = DateTime(_month.year, _month.month, day);
            final dayPayments = byDay[date] ?? [];
            final isToday = date == today;

            return GestureDetector(
              onTap: dayPayments.isNotEmpty
                  ? () => _showDaySheet(context, date, dayPayments, locale)
                  : null,
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isToday ? theme.colorScheme.primaryContainer : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$day',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                        color: isToday
                            ? theme.colorScheme.onPrimaryContainer
                            : dayPayments.isNotEmpty
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (dayPayments.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: dayPayments.take(3).map((p) {
                          final color = _statusColor(PaymentStatus.fromValue(p.status));
                          return Container(
                            width: 5, height: 5,
                            margin: const EdgeInsets.only(right: 1),
                            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CalLegend(color: const Color(0xFF34C759), label: l10n.statusPaid),
            const SizedBox(width: 14),
            _CalLegend(color: const Color(0xFFFF9500), label: l10n.statusPending),
            const SizedBox(width: 14),
            _CalLegend(color: const Color(0xFFFF3B30), label: l10n.statusOverdue),
          ],
        ),
      ],
    );
  }

  void _showDaySheet(BuildContext context, DateTime date, List<Payment> payments, String locale) {
    showModalBottomSheet(
      context: context,
      builder: (_) => _DaySheet(
        date: date,
        payments: payments,
        currency: widget.currency,
        locale: locale,
      ),
    );
  }

  Color _statusColor(PaymentStatus s) => switch (s) {
    PaymentStatus.paid => const Color(0xFF34C759),
    PaymentStatus.overdue => const Color(0xFFFF3B30),
    PaymentStatus.pending => const Color(0xFFFF9500),
  };
}

class _CalLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _CalLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
    ]);
  }
}

class _DaySheet extends StatelessWidget {
  final DateTime date;
  final List<Payment> payments;
  final String currency;
  final String locale;
  const _DaySheet({required this.date, required this.payments, required this.currency, required this.locale});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 8, 12),
          child: Row(
            children: [
              Text(formatDate(date, locale: locale),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
        ),
        ...payments.map((p) => _DayPaymentRow(payment: p, currency: currency, locale: locale, l10n: l10n)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _DayPaymentRow extends StatelessWidget {
  final Payment payment;
  final String currency;
  final String locale;
  final AppLocalizations l10n;
  const _DayPaymentRow({required this.payment, required this.currency, required this.locale, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = PaymentStatus.fromValue(payment.status);
    final type = PaymentType.values.firstWhere((t) => t.value == payment.type, orElse: () => PaymentType.other);
    final statusColor = switch (status) {
      PaymentStatus.paid => const Color(0xFF34C759),
      PaymentStatus.overdue => const Color(0xFFFF3B30),
      PaymentStatus.pending => const Color(0xFFFF9500),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
            child: Icon(_typeIcon(type), color: statusColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(type.l10n(l10n), style: theme.textTheme.bodyMedium)),
          Text(formatMoney(payment.amount, currency: currency),
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
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

  IconData _typeIcon(PaymentType type) => switch (type) {
    PaymentType.rent => Icons.home_outlined,
    PaymentType.deposit => Icons.shield_outlined,
    PaymentType.utility => Icons.bolt_outlined,
    PaymentType.other => Icons.receipt_outlined,
  };
}

class _PaymentTile extends StatelessWidget {
  final Payment payment;
  final String currency;
  final VoidCallback? onMarkPaid;
  const _PaymentTile({required this.payment, required this.currency, this.onMarkPaid});

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

    final tile = Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(_typeIcon(type), color: statusColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type.l10n(l10n), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(formatDate(payment.date, locale: Localizations.localeOf(context).toString()), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(formatMoney(payment.amount, currency: currency), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              if (onMarkPaid != null)
                GestureDetector(
                  onTap: onMarkPaid,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFF34C759).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                    child: Text(l10n.markAsPaid, style: theme.textTheme.labelSmall?.copyWith(color: const Color(0xFF34C759))),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                  child: Text(status.l10n(l10n), style: theme.textTheme.labelSmall?.copyWith(color: statusColor)),
                ),
            ],
          ),
        ],
      ),
    );

    if (onMarkPaid == null) return tile;

    return Dismissible(
      key: ValueKey('swipe_${payment.id}'),
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF34C759),
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(l10n.markAsPaid, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      confirmDismiss: (_) async {
        onMarkPaid!();
        return false;
      },
      child: tile,
    );
  }

  IconData _typeIcon(PaymentType type) => switch (type) {
        PaymentType.rent => Icons.home_outlined,
        PaymentType.deposit => Icons.shield_outlined,
        PaymentType.utility => Icons.bolt_outlined,
        PaymentType.other => Icons.receipt_outlined,
      };
}

class _AddPaymentSheet extends ConsumerStatefulWidget {
  final WidgetRef ref;
  const _AddPaymentSheet({required this.ref});

  @override
  ConsumerState<_AddPaymentSheet> createState() => _AddPaymentSheetState();
}

class _AddPaymentSheetState extends ConsumerState<_AddPaymentSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _notes = TextEditingController();
  PaymentType _type = PaymentType.rent;
  PaymentStatus _status = PaymentStatus.paid;
  DateTime _date = DateTime.now();
  String? _tenantId;
  String? _propertyId;
  bool _saving = false;

  @override
  void dispose() {
    _amount.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_tenantId == null || _propertyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.selectTenant)));
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(paymentRepositoryProvider).create(
            PaymentsCompanion(
              tenantId: Value(_tenantId!),
              propertyId: Value(_propertyId!),
              amount: Value(double.parse(_amount.text)),
              date: Value(_date),
              type: Value(_type.value),
              status: Value(_status.value),
              notes: Value(_notes.text.trim().isNotEmpty ? _notes.text.trim() : null),
            ),
          );
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final tenants = ref.watch(activeTenantsProvider);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Text(l10n.newPayment, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  tenants.when(
                    data: (list) => DropdownButtonFormField<String>(
                      initialValue: _tenantId,
                      hint: Text(l10n.selectTenant),
                      decoration: InputDecoration(filled: true, labelText: l10n.tenantsTitle),
                      menuMaxHeight: 220,
                      items: list.map((t) => DropdownMenuItem(value: t.id, child: Text('${t.firstName} ${t.lastName}'))).toList(),
                      onChanged: (v) {
                        final tenant = list.firstWhere((t) => t.id == v);
                        setState(() {
                          _tenantId = v;
                          _propertyId = tenant.propertyId;
                          if (_amount.text.isEmpty) _amount.text = tenant.rentAmount.toStringAsFixed(0);
                        });
                      },
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text(e.toString()),
                  ),
                  const SizedBox(height: 12),
                  _TypeRow(value: _type, onChanged: (t) => setState(() => _type = t)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: l10n.amount,
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (v) => v == null || v.isEmpty ? l10n.requiredField : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: _StatusSelector(value: _status, onChanged: (s) => setState(() => _status = s), l10n: l10n)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: l10n.date,
                    readOnly: true,
                    controller: TextEditingController(text: formatDate(_date, locale: Localizations.localeOf(context).toString())),
                    suffix: const Icon(Icons.calendar_today_outlined),
                    onTap: () async {
                      final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2100));
                      if (picked != null) setState(() => _date = picked);
                    },
                  ),
                  const SizedBox(height: 12),
                  AppTextField(label: l10n.notes, controller: _notes, maxLines: 2),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(l10n.addPayment),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeRow extends StatelessWidget {
  final PaymentType value;
  final ValueChanged<PaymentType> onChanged;
  const _TypeRow({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Row(
      children: PaymentType.values.map((type) {
        final selected = type == value;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: selected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant),
                ),
                child: Center(
                  child: Text(
                    type.l10n(l10n),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: selected ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StatusSelector extends StatelessWidget {
  final PaymentStatus value;
  final ValueChanged<PaymentStatus> onChanged;
  final AppLocalizations l10n;
  const _StatusSelector({required this.value, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PaymentStatus>(
      initialValue: value,
      decoration: InputDecoration(filled: true, labelText: l10n.status),
      items: PaymentStatus.values.map((s) => DropdownMenuItem(value: s, child: Text(s.l10n(l10n)))).toList(),
      onChanged: (s) => s != null ? onChanged(s) : null,
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
          Icon(Icons.payments_outlined, size: 64, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(l10n.noPayments, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.addFirstPayment, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
