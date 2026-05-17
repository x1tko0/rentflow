import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/enums.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../features/dashboard/dashboard_providers.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/database_provider.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../features/settings/settings_provider.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/confirm_dialog.dart';

final _expensesListProvider = StreamProvider<List<Expense>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.expenses)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final expenses = ref.watch(_expensesListProvider);
    final currency = ref.watch(settingsProvider).currency;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.expensesTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context, ref),
        icon: const Icon(Icons.add),
        label: Text(l10n.add),
      ),
      body: expenses.when(
        data: (list) => list.isEmpty
            ? _EmptyState(l10n: l10n)
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                itemCount: list.length,
                itemBuilder: (ctx, i) => _ExpenseTile(
                  expense: list[i],
                  currency: currency,
                  onDelete: () => _delete(context, ref, list[i], l10n),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AddExpenseSheet(ref: ref),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Expense expense, AppLocalizations l10n) async {
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.deleteExpenseTitle,
      message: l10n.deleteExpenseMessage(expense.description),
    );
    if (confirmed) {
      await ref.read(expenseRepositoryProvider).delete(expense.id);
    }
  }
}

class _ExpenseTile extends StatelessWidget {
  final Expense expense;
  final String currency;
  final VoidCallback onDelete;
  const _ExpenseTile({required this.expense, required this.currency, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final category = ExpenseCategory.fromValue(expense.category);
    final color = _categoryColor(category);

    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      child: Container(
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
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(_categoryIcon(category), color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expense.description, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                        child: Text(category.l10n(l10n), style: theme.textTheme.labelSmall?.copyWith(color: color)),
                      ),
                      const SizedBox(width: 8),
                      Text(formatDate(expense.date), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),
            Text(formatMoney(expense.amount, currency: currency), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xFFFF3B30))),
          ],
        ),
      ),
    );
  }

  Color _categoryColor(ExpenseCategory cat) => switch (cat) {
        ExpenseCategory.repair => const Color(0xFFFF9500),
        ExpenseCategory.tax => const Color(0xFF5856D6),
        ExpenseCategory.insurance => const Color(0xFF34C759),
        ExpenseCategory.utility => const Color(0xFF007AFF),
        ExpenseCategory.management => const Color(0xFF4F6AF0),
        ExpenseCategory.other => const Color(0xFF8E8E93),
      };

  IconData _categoryIcon(ExpenseCategory cat) => switch (cat) {
        ExpenseCategory.repair => Icons.build_outlined,
        ExpenseCategory.tax => Icons.account_balance_outlined,
        ExpenseCategory.insurance => Icons.shield_outlined,
        ExpenseCategory.utility => Icons.bolt_outlined,
        ExpenseCategory.management => Icons.manage_accounts_outlined,
        ExpenseCategory.other => Icons.receipt_long_outlined,
      };
}

class _AddExpenseSheet extends ConsumerStatefulWidget {
  final WidgetRef ref;
  const _AddExpenseSheet({required this.ref});

  @override
  ConsumerState<_AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<_AddExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _description = TextEditingController();
  ExpenseCategory _category = ExpenseCategory.repair;
  DateTime _date = DateTime.now();
  String? _propertyId;
  bool _saving = false;

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_propertyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.selectProperty)));
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(expenseRepositoryProvider).create(
            ExpensesCompanion(
              propertyId: Value(_propertyId!),
              amount: Value(double.parse(_amount.text)),
              date: Value(_date),
              category: Value(_category.value),
              description: Value(_description.text.trim()),
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
    final properties = ref.watch(propertiesProvider);

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
                  Text(l10n.newExpense, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
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
                  properties.when(
                    data: (list) => DropdownButtonFormField<String>(
                      initialValue: _propertyId,
                      decoration: InputDecoration(filled: true, labelText: l10n.propertiesTitle),
                      hint: Text(l10n.selectProperty),
                      items: list.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                      onChanged: (v) => setState(() => _propertyId = v),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text(e.toString()),
                  ),
                  const SizedBox(height: 12),
                  _CategoryGrid(value: _category, onChanged: (c) => setState(() => _category = c), l10n: l10n),
                  const SizedBox(height: 12),
                  AppTextField(
                    label: l10n.description,
                    hint: l10n.descriptionHint,
                    controller: _description,
                    validator: (v) => v == null || v.trim().isEmpty ? l10n.requiredField : null,
                  ),
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
                      Expanded(
                        child: AppTextField(
                          label: l10n.date,
                          readOnly: true,
                          controller: TextEditingController(text: formatDate(_date)),
                          suffix: const Icon(Icons.calendar_today_outlined),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) setState(() => _date = picked);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(l10n.addExpense),
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

class _CategoryGrid extends StatelessWidget {
  final ExpenseCategory value;
  final ValueChanged<ExpenseCategory> onChanged;
  final AppLocalizations l10n;
  const _CategoryGrid({required this.value, required this.onChanged, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ExpenseCategory.values.map((cat) {
        final selected = cat == value;
        return GestureDetector(
          onTap: () => onChanged(cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: selected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant),
            ),
            child: Text(
              cat.l10n(l10n),
              style: theme.textTheme.labelMedium?.copyWith(
                color: selected ? Colors.white : theme.colorScheme.onSurface,
                fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
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
          Icon(Icons.receipt_long_outlined, size: 64, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(l10n.noExpenses, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(l10n.addFirstExpense, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
