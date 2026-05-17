import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/enums.dart';
import '../../../data/database/app_database.dart';
import '../../../generated/app_localizations.dart';
import '../../../shared/providers/repository_providers.dart';
import '../../../shared/widgets/app_text_field.dart';

class PropertyFormScreen extends ConsumerStatefulWidget {
  final Property? property;
  const PropertyFormScreen({super.key, this.property});

  @override
  ConsumerState<PropertyFormScreen> createState() => _PropertyFormScreenState();
}

class _PropertyFormScreenState extends ConsumerState<PropertyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _area;
  late final TextEditingController _price;
  late final TextEditingController _notes;
  PropertyType _type = PropertyType.apartment;
  bool _saving = false;

  bool get _isEdit => widget.property != null;

  @override
  void initState() {
    super.initState();
    final p = widget.property;
    _name = TextEditingController(text: p?.name ?? '');
    _address = TextEditingController(text: p?.address ?? '');
    _area = TextEditingController(text: p?.area?.toString() ?? '');
    _price = TextEditingController(text: p?.purchasePrice?.toString() ?? '');
    _notes = TextEditingController(text: p?.notes ?? '');
    if (p != null) _type = PropertyType.fromValue(p.type);
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _area.dispose();
    _price.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final repo = ref.read(propertyRepositoryProvider);
    final companion = PropertiesCompanion(
      name: Value(_name.text.trim()),
      address: Value(_address.text.trim()),
      type: Value(_type.value),
      area: Value(_area.text.isNotEmpty ? double.tryParse(_area.text) : null),
      purchasePrice: Value(_price.text.isNotEmpty ? double.tryParse(_price.text) : null),
      notes: Value(_notes.text.trim().isNotEmpty ? _notes.text.trim() : null),
    );

    try {
      if (_isEdit) {
        await repo.update(widget.property!.id, companion);
      } else {
        await repo.create(companion);
      }
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.editProperty : l10n.newProperty),
        actions: [
          if (_saving)
            const Padding(padding: EdgeInsets.all(16), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))
          else
            TextButton(
              onPressed: _save,
              child: Text(l10n.save, style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              label: l10n.propertyName,
              hint: l10n.propertyNameHint,
              controller: _name,
              validator: (v) => v == null || v.trim().isEmpty ? l10n.requiredField : null,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: l10n.propertyAddress,
              hint: l10n.addressHint,
              controller: _address,
              validator: (v) => v == null || v.trim().isEmpty ? l10n.requiredField : null,
            ),
            const SizedBox(height: 16),
            Text(l10n.propertyType, style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _TypeSelector(value: _type, onChanged: (t) => setState(() => _type = t)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: l10n.propertyArea,
                    hint: '45',
                    controller: _area,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    label: l10n.purchasePrice,
                    hint: '5 000 000',
                    controller: _price,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AppTextField(label: l10n.notes, hint: l10n.notesHint, controller: _notes, maxLines: 3),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(_isEdit ? l10n.saveChanges : l10n.addProperty),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeSelector extends StatelessWidget {
  final PropertyType value;
  final ValueChanged<PropertyType> onChanged;
  const _TypeSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Row(
      children: PropertyType.values.map((type) {
        final selected = type == value;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: selected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant),
                ),
                child: Center(
                  child: Text(
                    type.l10n(l10n),
                    style: theme.textTheme.labelMedium?.copyWith(
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
