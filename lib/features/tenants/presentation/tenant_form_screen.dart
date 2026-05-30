import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../features/dashboard/dashboard_providers.dart';
import '../../../features/settings/settings_provider.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../shared/widgets/app_text_field.dart';

class TenantFormScreen extends ConsumerStatefulWidget {
  final Tenant? tenant;
  const TenantFormScreen({super.key, this.tenant});

  @override
  ConsumerState<TenantFormScreen> createState() => _TenantFormScreenState();
}

class _TenantFormScreenState extends ConsumerState<TenantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _rent;
  late final TextEditingController _deposit;
  late final TextEditingController _notes;
  DateTime _leaseStart = DateTime.now();
  DateTime? _leaseEnd;
  int _paymentDay = 1;
  String? _propertyId;
  bool _saving = false;

  bool get _isEdit => widget.tenant != null;

  @override
  void initState() {
    super.initState();
    final t = widget.tenant;
    _firstName = TextEditingController(text: t?.firstName ?? '');
    _lastName = TextEditingController(text: t?.lastName ?? '');
    _phone = TextEditingController(text: t?.phone ?? '');
    _email = TextEditingController(text: t?.email ?? '');
    _rent = TextEditingController(text: t?.rentAmount.toStringAsFixed(0) ?? '');
    _deposit = TextEditingController(text: t?.depositAmount?.toStringAsFixed(0) ?? '');
    _notes = TextEditingController(text: t?.notes ?? '');
    if (t != null) {
      _leaseStart = t.leaseStart;
      _leaseEnd = t.leaseEnd;
      _paymentDay = t.paymentDay;
      _propertyId = t.propertyId;
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _email.dispose();
    _rent.dispose();
    _deposit.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _leaseStart : (_leaseEnd ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) { _leaseStart = picked; } else { _leaseEnd = picked; }
      });
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_propertyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.selectProperty)));
      return;
    }
    setState(() => _saving = true);

    final repo = ref.read(tenantRepositoryProvider);
    final companion = TenantsCompanion(
      propertyId: Value(_propertyId!),
      firstName: Value(_firstName.text.trim()),
      lastName: Value(_lastName.text.trim()),
      phone: Value(_phone.text.trim()),
      email: Value(_email.text.trim().isNotEmpty ? _email.text.trim() : null),
      rentAmount: Value(double.parse(_rent.text)),
      depositAmount: Value(_deposit.text.isNotEmpty ? double.tryParse(_deposit.text) : null),
      leaseStart: Value(_leaseStart),
      leaseEnd: Value(_leaseEnd),
      paymentDay: Value(_paymentDay),
      notes: Value(_notes.text.trim().isNotEmpty ? _notes.text.trim() : null),
    );

    try {
      final String tenantId;
      if (_isEdit) {
        await repo.update(widget.tenant!.id, companion);
        tenantId = widget.tenant!.id;
      } else {
        tenantId = await repo.create(companion);
      }
      if (mounted) {
        _scheduleNotification(tenantId)
            .timeout(const Duration(seconds: 5))
            .catchError((_) {});
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _scheduleNotification(String tenantId) async {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final currency = ref.read(settingsProvider).currency;
    final name = '${_firstName.text.trim()} ${_lastName.text.trim()}';
    final amount = double.tryParse(_rent.text) ?? 0;
    final notifId = tenantId.hashCode.abs() % 100000;
    await NotificationService.cancel(notifId);
    await NotificationService.schedulePaymentReminder(
      id: notifId,
      title: l10n.notificationPaymentTitle,
      body: '$name — ${formatMoney(amount, currency: currency)}',
      paymentDate: _nextPaymentDate(_paymentDay),
      daysBefore: ref.read(settingsProvider).notificationDaysBefore,
    );
    await NotificationService.cancelLeaseReminder(notifId);
    if (_leaseEnd != null) {
      await NotificationService.scheduleLeaseEndReminder(
        id: notifId,
        title: l10n.notificationLeaseEndTitle,
        body: l10n.notificationLeaseEndBody(
          name,
          formatDate(_leaseEnd!, locale: locale),
        ),
        leaseEnd: _leaseEnd!,
      );
    }
  }

  DateTime _nextPaymentDate(int day) {
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month, day);
    return thisMonth.isAfter(now) ? thisMonth : DateTime(now.year, now.month + 1, day);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final properties = ref.watch(propertiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.editTenant : l10n.newTenant),
        actions: [
          if (_saving)
            const Padding(padding: EdgeInsets.all(16), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))
          else
            TextButton(onPressed: _save, child: Text(l10n.save, style: const TextStyle(fontWeight: FontWeight.w700))),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Section(l10n.personalInfo),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: l10n.firstName,
                    controller: _firstName,
                    validator: (v) => v == null || v.trim().isEmpty ? l10n.requiredField : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    label: l10n.lastName,
                    controller: _lastName,
                    validator: (v) => v == null || v.trim().isEmpty ? l10n.requiredField : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: l10n.phone,
              hint: '+380 50 000 0000',
              controller: _phone,
              keyboardType: TextInputType.phone,
              validator: (v) => v == null || v.trim().isEmpty ? l10n.requiredField : null,
            ),
            const SizedBox(height: 12),
            AppTextField(label: 'Email', hint: l10n.emailHint, controller: _email, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            _Section(l10n.propertySection),
            properties.when(
              data: (list) => DropdownButtonFormField<String>(
                initialValue: _propertyId,
                hint: Text(l10n.selectProperty),
                decoration: const InputDecoration(filled: true),
                items: list.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                onChanged: (v) => setState(() => _propertyId = v),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text(e.toString()),
            ),
            const SizedBox(height: 20),
            _Section(l10n.leaseTerms),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: l10n.rentPerMonth,
                    hint: '30 000',
                    controller: _rent,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      if (v == null || v.isEmpty) return l10n.requiredField;
                      if (double.tryParse(v) == null) return l10n.invalidNumber;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    label: l10n.depositLabel,
                    hint: '30 000',
                    controller: _deposit,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DayPicker(value: _paymentDay, onChanged: (d) => setState(() => _paymentDay = d), l10n: l10n),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _DateTile(label: l10n.leaseStart, date: _leaseStart, onTap: () => _pickDate(isStart: true), l10n: l10n)),
                const SizedBox(width: 12),
                Expanded(child: _DateTile(label: l10n.leaseEnd, date: _leaseEnd, onTap: () => _pickDate(isStart: false), placeholder: l10n.indefinite, l10n: l10n)),
              ],
            ),
            const SizedBox(height: 20),
            AppTextField(label: l10n.notes, hint: l10n.notesHint, controller: _notes, maxLines: 3),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(_isEdit ? l10n.saveChanges : l10n.addTenant),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  const _Section(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
    );
  }
}

class _DayPicker extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final AppLocalizations l10n;
  const _DayPicker({required this.value, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: theme.inputDecorationTheme.fillColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(child: Text(l10n.paymentDayPickerLabel(value), style: theme.textTheme.bodyMedium)),
          DropdownButton<int>(
            value: value,
            underline: const SizedBox.shrink(),
            items: List.generate(28, (i) => i + 1).map((d) => DropdownMenuItem(value: d, child: Text('$d'))).toList(),
            onChanged: (d) => d != null ? onChanged(d) : null,
          ),
        ],
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final String placeholder;
  final VoidCallback onTap;
  final AppLocalizations l10n;
  const _DateTile({required this.label, required this.date, required this.onTap, required this.l10n, this.placeholder = ''});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ph = placeholder.isEmpty ? l10n.select : placeholder;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(color: theme.inputDecorationTheme.fillColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text(
              date != null ? formatDate(date!, locale: Localizations.localeOf(context).toString()) : ph,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: date != null ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
