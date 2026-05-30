import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/app_database.dart';
import '../../../generated/app_localizations.dart';
import '../../../main.dart' show globalPrefs;
import '../../../shared/providers/repository_providers.dart';

enum _MeterType {
  electricity('electricity'),
  waterCold('water_cold'),
  gas('gas'),
  heat('heat'),
  waterHot('water_hot'),
  electricityT1('electricity_t1'),
  electricityT2('electricity_t2'),
  electricityT3('electricity_t3');

  final String value;
  const _MeterType(this.value);
}

// Regular types shown as standalone cards (not electricity sub-types)
const _regularTypes = [
  _MeterType.waterCold,
  _MeterType.gas,
  _MeterType.heat,
  _MeterType.waterHot,
];

final _meterTypeReadingsProvider =
    StreamProvider.family<List<MeterReading>, ({String propertyId, String type})>(
  (ref, args) =>
      ref.watch(meterRepositoryProvider).watchByType(args.propertyId, args.type),
);

final _customTypesProvider = StreamProvider.family<List<String>, String>(
  (ref, propertyId) =>
      ref.watch(meterRepositoryProvider).watchCustomTypes(propertyId),
);

// ─────────────────────────────────────────────────────────────
// Main screen
// ─────────────────────────────────────────────────────────────

class MetersScreen extends StatelessWidget {
  final Property property;
  const MetersScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.meterReadings)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context, propertyId: property.id),
        icon: const Icon(Icons.add),
        label: Text(l10n.addReading),
      ),
      body: _MetersBody(property: property, locale: locale),
    );
  }

  static void _showAddSheet(BuildContext context,
      {required String propertyId,
      _MeterType? preselected,
      String? preselectedCustom}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AddReadingSheet(
        propertyId: propertyId,
        preselectedType: preselected,
        preselectedCustomType: preselectedCustom,
      ),
    );
  }
}

class _MetersBody extends ConsumerWidget {
  final Property property;
  final String locale;
  const _MetersBody({required this.property, required this.locale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customAsync = ref.watch(_customTypesProvider(property.id));
    final customTypes = customAsync.valueOrNull ?? [];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _ElectricitySection(propertyId: property.id, locale: locale),
        ..._regularTypes.map(
          (t) => _MeterCard(propertyId: property.id, type: t, locale: locale),
        ),
        ...customTypes.map(
          (type) => _CustomMeterCard(
            propertyId: property.id,
            type: type,
            locale: locale,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Electricity expandable section
// ─────────────────────────────────────────────────────────────

class _ElectricitySection extends ConsumerStatefulWidget {
  final String propertyId;
  final String locale;
  const _ElectricitySection({required this.propertyId, required this.locale});

  @override
  ConsumerState<_ElectricitySection> createState() => _ElectricitySectionState();
}

class _ElectricitySectionState extends ConsumerState<_ElectricitySection> {
  int _tariffCount = 1;

  @override
  void initState() {
    super.initState();
    _tariffCount = globalPrefs.getInt('elec_tariff_${widget.propertyId}') ?? 1;
  }

  void _setTariffCount(int count) {
    setState(() => _tariffCount = count);
    globalPrefs.setInt('elec_tariff_${widget.propertyId}', count);
  }

  void _showAdd(BuildContext context, _MeterType type) =>
      MetersScreen._showAddSheet(context,
          propertyId: widget.propertyId, preselected: type);

  void _openReadings(BuildContext context, String typeValue, String name,
      Color color, IconData icon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ReadingsListSheet(
        propertyId: widget.propertyId,
        typeValue: typeValue,
        typeName: name,
        color: color,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    const elecColor = Color(0xFFFFCC00);

    final elecReadings = ref
        .watch(_meterTypeReadingsProvider((propertyId: widget.propertyId, type: 'electricity')))
        .valueOrNull ?? [];
    final t1Readings = ref
        .watch(_meterTypeReadingsProvider((propertyId: widget.propertyId, type: 'electricity_t1')))
        .valueOrNull ?? [];
    final t2Readings = ref
        .watch(_meterTypeReadingsProvider((propertyId: widget.propertyId, type: 'electricity_t2')))
        .valueOrNull ?? [];
    final t3Readings = ref
        .watch(_meterTypeReadingsProvider((propertyId: widget.propertyId, type: 'electricity_t3')))
        .valueOrNull ?? [];

    // Compute total, delta & display date
    double? totalValue;
    double? totalDelta;
    DateTime? displayDate;
    if (_tariffCount > 1) {
      final t1Last = t1Readings.isNotEmpty ? t1Readings.first.value : null;
      final t2Last = t2Readings.isNotEmpty ? t2Readings.first.value : null;
      final t3Last = _tariffCount == 3 && t3Readings.isNotEmpty ? t3Readings.first.value : null;
      if (t1Last != null || t2Last != null || t3Last != null) {
        totalValue = (t1Last ?? 0) + (t2Last ?? 0) + (t3Last ?? 0);
        // Previous total = second reading of each tariff summed
        final t1Prev = t1Readings.length > 1 ? t1Readings[1].value : null;
        final t2Prev = t2Readings.length > 1 ? t2Readings[1].value : null;
        final t3Prev = _tariffCount == 3 && t3Readings.length > 1 ? t3Readings[1].value : null;
        if (t1Prev != null || t2Prev != null || t3Prev != null) {
          final prevTotal = (t1Prev ?? t1Last ?? 0) + (t2Prev ?? t2Last ?? 0) + (t3Prev ?? t3Last ?? 0);
          totalDelta = totalValue - prevTotal;
        }
        final dates = <DateTime>[
          if (t1Readings.isNotEmpty) t1Readings.first.date,
          if (t2Readings.isNotEmpty) t2Readings.first.date,
          if (_tariffCount == 3 && t3Readings.isNotEmpty) t3Readings.first.date,
        ];
        displayDate = dates.isNotEmpty ? dates.reduce((a, b) => a.isAfter(b) ? a : b) : null;
      }
    } else {
      final last = elecReadings.isNotEmpty ? elecReadings.first : null;
      final prev = elecReadings.length > 1 ? elecReadings[1] : null;
      totalValue = last?.value;
      totalDelta = (last != null && prev != null) ? last.value - prev.value : null;
      displayDate = last?.date;
    }

    final card = Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          // Header row
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _MeterIcon(icon: Icons.bolt_outlined, color: elecColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  l10n.meterElectricity,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 8),
                                _TariffToggle(
                                  current: _tariffCount,
                                  onChanged: _setTariffCount,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            if (totalValue != null) ...[
                              Text(
                                '${l10n.lastReading}: ${totalValue.toStringAsFixed(2)}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant),
                              ),
                              if (totalDelta != null && totalDelta != 0)
                                Text(
                                  totalDelta > 0
                                      ? '+${totalDelta.toStringAsFixed(2)}'
                                      : totalDelta.toStringAsFixed(2),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: totalDelta > 0 ? elecColor : theme.colorScheme.error),
                                ),
                            ] else
                              Text(l10n.noReadings,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.outlineVariant)),
                          ],
                        ),
                      ),
                      if (_tariffCount == 1) ...[
                        if (displayDate != null) ...[
                          Text(
                            formatDate(displayDate, locale: widget.locale),
                            style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(width: 4),
                        ],
                        // Single tariff: chevron opens readings list
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _openReadings(
                            context,
                            'electricity',
                            l10n.meterElectricity,
                            elecColor,
                            Icons.bolt_outlined,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 16, 16, 16),
                            child: Icon(Icons.chevron_right,
                                size: 18, color: theme.colorScheme.outlineVariant),
                          ),
                        ),
                      ] else if (displayDate != null) ...[
                        Text(
                          formatDate(displayDate, locale: widget.locale),
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          // T1/T2/T3 sub-rows
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _tariffCount > 1
                ? Column(children: [
                    Divider(height: 1, indent: 16, color: theme.colorScheme.outlineVariant),
                    _buildSubRow(context, l10n, theme,
                        type: _MeterType.electricityT1,
                        name: l10n.meterElectricityT1,
                        color: const Color(0xFFFFD60A),
                        icon: Icons.wb_sunny_outlined,
                        readings: t1Readings),
                    Divider(height: 1, indent: 16, color: theme.colorScheme.outlineVariant),
                    _buildSubRow(context, l10n, theme,
                        type: _MeterType.electricityT2,
                        name: l10n.meterElectricityT2,
                        color: const Color(0xFF5856D6),
                        icon: Icons.nights_stay_outlined,
                        readings: t2Readings),
                    if (_tariffCount == 3) ...[
                      Divider(height: 1, indent: 16, color: theme.colorScheme.outlineVariant),
                      _buildSubRow(context, l10n, theme,
                          type: _MeterType.electricityT3,
                          name: l10n.meterElectricityT3,
                          color: const Color(0xFF34C759),
                          icon: Icons.nights_stay_outlined,
                          readings: t3Readings),
                    ],
                  ])
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _tariffCount == 1
          ? Dismissible(
              key: ValueKey('elec_main_${widget.propertyId}'),
              direction: DismissDirection.startToEnd,
              background: const _SwipeBackground(),
              confirmDismiss: (_) async {
                _showAdd(context, _MeterType.electricity);
                return false;
              },
              child: card,
            )
          : card,
    );
  }

  Widget _buildSubRow(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme, {
    required _MeterType type,
    required String name,
    required Color color,
    required IconData icon,
    required List<MeterReading> readings,
  }) {
    final last = readings.isNotEmpty ? readings.first : null;
    final prev = readings.length > 1 ? readings[1] : null;
    final consumption =
        (last != null && prev != null) ? (last.value - prev.value) : null;

    return Dismissible(
      key: ValueKey('${type.value}_sub_${widget.propertyId}'),
      direction: DismissDirection.startToEnd,
      background: const _SwipeBackground(),
      confirmDismiss: (_) async {
        _showAdd(context, type);
        return false;
      },
      child: InkWell(
        onTap: () => _openReadings(context, type.value, name, color, icon),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Row(
            children: [
              _MeterIcon(icon: icon, color: color, size: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    if (last != null) ...[
                      Text(
                        last.value.toStringAsFixed(2),
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      if (consumption != null && consumption > 0)
                        Text(
                          '+${consumption.toStringAsFixed(2)}',
                          style:
                              theme.textTheme.bodySmall?.copyWith(color: color),
                        ),
                    ] else
                      Text(l10n.noReadings,
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outlineVariant,
                              fontSize: 11)),
                  ],
                ),
              ),
              if (last != null) ...[
                Text(
                  formatDate(last.date, locale: widget.locale),
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 4),
              ],
              Icon(Icons.chevron_right,
                  size: 16, color: theme.colorScheme.outlineVariant),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tariff mode toggle: 1Т / 2Т / 3Т
// ─────────────────────────────────────────────────────────────

class _TariffToggle extends StatelessWidget {
  final int current;
  final ValueChanged<int> onChanged;
  const _TariffToggle({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const elecColor = Color(0xFFFFCC00);
    const options = [1, 2, 3];
    const labels = ['1T', '2T', '3T'];

    return GestureDetector(
      onTap: () {}, // absorb tap so parent Dismissible isn't triggered
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < options.length; i++) ...[
              if (i > 0)
                Container(width: 1, height: 20, color: theme.colorScheme.outlineVariant),
              GestureDetector(
                onTap: () => onChanged(options[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: current == options[i]
                        ? elecColor.withValues(alpha: 0.18)
                        : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      left: i == 0 ? const Radius.circular(7) : Radius.zero,
                      right: i == 2 ? const Radius.circular(7) : Radius.zero,
                    ),
                  ),
                  child: Text(
                    labels[i],
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: current == options[i]
                          ? elecColor
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: current == options[i]
                          ? FontWeight.w700
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Regular meter card (swipe right = add, tap = readings list)
// ─────────────────────────────────────────────────────────────

class _MeterCard extends ConsumerWidget {
  final String propertyId;
  final _MeterType type;
  final String locale;
  const _MeterCard(
      {required this.propertyId, required this.type, required this.locale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final readingsAsync = ref.watch(
        _meterTypeReadingsProvider((propertyId: propertyId, type: type.value)));
    final color = _color(type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey('${type.value}_card_$propertyId'),
        direction: DismissDirection.startToEnd,
        background: const _SwipeBackground(),
        confirmDismiss: (_) async {
          MetersScreen._showAddSheet(context,
              propertyId: propertyId, preselected: type);
          return false;
        },
        child: GestureDetector(
          onTap: () => _openReadings(context, l10n, color),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: readingsAsync.when(
              loading: () => Row(children: [
                _MeterIcon(icon: _icon(type), color: color),
                const SizedBox(width: 12),
                Text(_name(type, l10n),
                    style: theme.textTheme.bodyMedium),
                const Spacer(),
                const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
              ]),
              error: (e, _) => Text(e.toString()),
              data: (readings) {
                final last = readings.isNotEmpty ? readings.first : null;
                final prev = readings.length > 1 ? readings[1] : null;
                final consumption = (last != null && prev != null)
                    ? (last.value - prev.value)
                    : null;
                return Row(
                  children: [
                    _MeterIcon(icon: _icon(type), color: color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_name(type, l10n),
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          if (last != null) ...[
                            Text(
                              '${l10n.lastReading}: ${last.value.toStringAsFixed(2)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant),
                            ),
                            if (consumption != null && consumption > 0)
                              Text(
                                '${l10n.consumption}: +${consumption.toStringAsFixed(2)}',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: color),
                              ),
                          ] else
                            Text(l10n.noReadings,
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.outlineVariant)),
                        ],
                      ),
                    ),
                    if (last != null) ...[
                      Text(
                        formatDate(last.date, locale: locale),
                        style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Icon(Icons.chevron_right,
                        size: 18,
                        color: theme.colorScheme.outlineVariant),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _openReadings(
      BuildContext context, AppLocalizations l10n, Color color) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ReadingsListSheet(
        propertyId: propertyId,
        typeValue: type.value,
        typeName: _name(type, l10n),
        color: color,
        icon: _icon(type),
      ),
    );
  }

  Color _color(_MeterType t) => switch (t) {
        _MeterType.waterCold => const Color(0xFF007AFF),
        _MeterType.waterHot => const Color(0xFFFF9500),
        _MeterType.gas => const Color(0xFFFF6B35),
        _MeterType.electricity => const Color(0xFFFFCC00),
        _MeterType.electricityT1 => const Color(0xFFFFD60A),
        _MeterType.electricityT2 => const Color(0xFF5856D6),
        _MeterType.electricityT3 => const Color(0xFF34C759),
        _MeterType.heat => const Color(0xFFFF3B30),
      };

  IconData _icon(_MeterType t) => switch (t) {
        _MeterType.waterCold => Icons.water_drop_outlined,
        _MeterType.waterHot => Icons.water_drop,
        _MeterType.gas => Icons.local_fire_department_outlined,
        _MeterType.electricity => Icons.bolt_outlined,
        _MeterType.electricityT1 => Icons.wb_sunny_outlined,
        _MeterType.electricityT2 => Icons.nights_stay_outlined,
        _MeterType.electricityT3 => Icons.light_mode_outlined,
        _MeterType.heat => Icons.thermostat_outlined,
      };

  String _name(_MeterType t, AppLocalizations l10n) => switch (t) {
        _MeterType.waterCold => l10n.meterWaterCold,
        _MeterType.waterHot => l10n.meterWaterHot,
        _MeterType.gas => l10n.meterGas,
        _MeterType.electricity => l10n.meterElectricity,
        _MeterType.electricityT1 => l10n.meterElectricityT1,
        _MeterType.electricityT2 => l10n.meterElectricityT2,
        _MeterType.electricityT3 => l10n.meterElectricityT3,
        _MeterType.heat => l10n.meterHeat,
      };
}

// ─────────────────────────────────────────────────────────────
// Custom meter card
// ─────────────────────────────────────────────────────────────

class _CustomMeterCard extends ConsumerWidget {
  final String propertyId;
  final String type;
  final String locale;
  const _CustomMeterCard(
      {required this.propertyId, required this.type, required this.locale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final readingsAsync = ref.watch(
        _meterTypeReadingsProvider((propertyId: propertyId, type: type)));
    const color = Color(0xFF34C759);
    const icon = Icons.tune_outlined;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey('custom_${type}_$propertyId'),
        direction: DismissDirection.startToEnd,
        background: const _SwipeBackground(),
        confirmDismiss: (_) async {
          MetersScreen._showAddSheet(context,
              propertyId: propertyId, preselectedCustom: type);
          return false;
        },
        child: GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => _ReadingsListSheet(
              propertyId: propertyId,
              typeValue: type,
              typeName: type,
              color: color,
              icon: icon,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: readingsAsync.when(
              loading: () => Row(children: [
                const _MeterIcon(icon: icon, color: color),
                const SizedBox(width: 12),
                Text(type, style: theme.textTheme.bodyMedium),
                const Spacer(),
                const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2)),
              ]),
              error: (e, _) => Text(e.toString()),
              data: (readings) {
                final last = readings.isNotEmpty ? readings.first : null;
                final prev = readings.length > 1 ? readings[1] : null;
                final consumption = (last != null && prev != null)
                    ? (last.value - prev.value)
                    : null;
                return Row(
                  children: [
                    const _MeterIcon(icon: icon, color: color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(type,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          if (last != null) ...[
                            Text(
                              '${l10n.lastReading}: ${last.value.toStringAsFixed(2)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant),
                            ),
                            if (consumption != null && consumption > 0)
                              Text(
                                '${l10n.consumption}: +${consumption.toStringAsFixed(2)}',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: color),
                              ),
                          ] else
                            Text(l10n.noReadings,
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.outlineVariant)),
                        ],
                      ),
                    ),
                    if (last != null) ...[
                      Text(
                        formatDate(last.date, locale: locale),
                        style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Icon(Icons.chevron_right,
                        size: 18, color: theme.colorScheme.outlineVariant),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Swipe background
// ─────────────────────────────────────────────────────────────

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF34C759).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.add_circle_outline,
          color: Color(0xFF34C759), size: 26),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Readings list sheet
// ─────────────────────────────────────────────────────────────

class _ReadingsListSheet extends ConsumerWidget {
  final String propertyId;
  final String typeValue;
  final String typeName;
  final Color color;
  final IconData icon;
  const _ReadingsListSheet({
    required this.propertyId,
    required this.typeValue,
    required this.typeName,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final readingsAsync = ref.watch(
        _meterTypeReadingsProvider((propertyId: propertyId, type: typeValue)));

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (ctx, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
            child: Row(
              children: [
                _MeterIcon(icon: icon, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(typeName,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 16),
          Expanded(
            child: readingsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
              data: (readings) {
                if (readings.isEmpty) {
                  return Center(
                    child: Text(l10n.noReadings,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.outlineVariant)),
                  );
                }
                return ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: readings.length,
                  separatorBuilder: (_, i) => const Divider(height: 1),
                  itemBuilder: (ctx, i) => _ReadingRow(
                    reading: readings[i],
                    locale: locale,
                    onEdit: () => _openEdit(context, readings[i]),
                    onDelete: () =>
                        _delete(context, ref, readings[i], l10n),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openEdit(BuildContext context, MeterReading reading) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) =>
          _EditReadingSheet(reading: reading, typeName: typeName),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref,
      MeterReading reading, AppLocalizations l10n) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(reading.value.toStringAsFixed(2)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.cancel)),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.delete,
                  style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(meterRepositoryProvider).delete(reading.id);
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class _ReadingRow extends StatelessWidget {
  final MeterReading reading;
  final String locale;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _ReadingRow({
    required this.reading,
    required this.locale,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      title: Text(
        reading.value.toStringAsFixed(2),
        style:
            theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formatDate(reading.date, locale: locale),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          if (reading.notes != null && reading.notes!.isNotEmpty)
            Text(reading.notes!,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 20),
            tooltip: l10n.editReading,
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
            tooltip: l10n.delete,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Edit reading sheet
// ─────────────────────────────────────────────────────────────

class _EditReadingSheet extends ConsumerStatefulWidget {
  final MeterReading reading;
  final String typeName;
  const _EditReadingSheet({required this.reading, required this.typeName});

  @override
  ConsumerState<_EditReadingSheet> createState() => _EditReadingSheetState();
}

class _EditReadingSheetState extends ConsumerState<_EditReadingSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _valueCtrl;
  late final TextEditingController _notesCtrl;
  late DateTime _date;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _valueCtrl =
        TextEditingController(text: widget.reading.value.toStringAsFixed(2));
    _notesCtrl = TextEditingController(text: widget.reading.notes ?? '');
    _date = widget.reading.date;
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(meterRepositoryProvider).update(
            MeterReadingsCompanion(
              id: Value(widget.reading.id),
              value: Value(
                  double.parse(_valueCtrl.text.replaceAll(',', '.'))),
              date: Value(_date),
              notes: _notesCtrl.text.trim().isEmpty
                  ? const Value(null)
                  : Value(_notesCtrl.text.trim()),
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
    final locale = Localizations.localeOf(context).toString();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Text(l10n.editReading,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _valueCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
                    ],
                    decoration: InputDecoration(
                        filled: true, labelText: l10n.readingValue),
                    validator: (v) =>
                        v == null || v.isEmpty ? l10n.requiredField : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: formatDate(_date, locale: locale)),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: l10n.date,
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
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
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notesCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: l10n.notes,
                      hintText: l10n.notesHint,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : Text(l10n.save),
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

// ─────────────────────────────────────────────────────────────
// Add reading sheet
// ─────────────────────────────────────────────────────────────

class _AddReadingSheet extends ConsumerStatefulWidget {
  final String propertyId;
  final _MeterType? preselectedType;
  final String? preselectedCustomType;
  const _AddReadingSheet({
    required this.propertyId,
    this.preselectedType,
    this.preselectedCustomType,
  });

  @override
  ConsumerState<_AddReadingSheet> createState() => _AddReadingSheetState();
}

class _AddReadingSheetState extends ConsumerState<_AddReadingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _valueCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _customTypeCtrl = TextEditingController();
  late _MeterType? _type;
  DateTime _date = DateTime.now();
  bool _saving = false;

  bool get _isCustom => _type == null;

  @override
  void initState() {
    super.initState();
    _type = widget.preselectedType ??
        (widget.preselectedCustomType != null ? null : _MeterType.electricity);
    if (widget.preselectedCustomType != null) {
      _customTypeCtrl.text = widget.preselectedCustomType!;
    }
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _notesCtrl.dispose();
    _customTypeCtrl.dispose();
    super.dispose();
  }

  String _typeName(_MeterType? t, AppLocalizations l10n) {
    if (t == null) return l10n.customType;
    return switch (t) {
      _MeterType.electricity => l10n.meterElectricity,
      _MeterType.waterCold => l10n.meterWaterCold,
      _MeterType.waterHot => l10n.meterWaterHot,
      _MeterType.gas => l10n.meterGas,
      _MeterType.electricityT1 => l10n.meterElectricityT1,
      _MeterType.electricityT2 => l10n.meterElectricityT2,
      _MeterType.electricityT3 => l10n.meterElectricityT3,
      _MeterType.heat => l10n.meterHeat,
    };
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final typeValue =
        _isCustom ? _customTypeCtrl.text.trim() : _type!.value;
    if (typeValue.isEmpty) return;
    setState(() => _saving = true);
    try {
      await ref.read(meterRepositoryProvider).create(
            MeterReadingsCompanion(
              propertyId: Value(widget.propertyId),
              type: Value(typeValue),
              value: Value(
                  double.parse(_valueCtrl.text.replaceAll(',', '.'))),
              date: Value(_date),
              notes: _notesCtrl.text.trim().isEmpty
                  ? const Value.absent()
                  : Value(_notesCtrl.text.trim()),
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
    final locale = Localizations.localeOf(context).toString();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Text(l10n.addReading,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  DropdownButtonFormField<_MeterType?>(
                    initialValue: _type,
                    decoration: InputDecoration(
                        filled: true, labelText: l10n.select),
                    menuMaxHeight: 280,
                    items: [
                      ...[
                        _MeterType.electricity,
                        _MeterType.electricityT1,
                        _MeterType.electricityT2,
                        _MeterType.electricityT3,
                        _MeterType.waterCold,
                        _MeterType.gas,
                        _MeterType.heat,
                        _MeterType.waterHot,
                      ].map((t) => DropdownMenuItem(
                          value: t, child: Text(_typeName(t, l10n)))),
                      DropdownMenuItem(
                        value: null,
                        child: Text(l10n.customType,
                            style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontStyle: FontStyle.italic)),
                      ),
                    ],
                    onChanged: (v) => setState(() => _type = v),
                  ),
                  if (_isCustom) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _customTypeCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          filled: true, labelText: l10n.typeName),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _valueCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
                    ],
                    decoration: InputDecoration(
                        filled: true, labelText: l10n.readingValue),
                    validator: (v) =>
                        v == null || v.isEmpty ? l10n.requiredField : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: formatDate(_date, locale: locale)),
                    decoration: InputDecoration(
                      filled: true,
                      labelText: l10n.date,
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                    ),
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
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notesCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: l10n.notes,
                      hintText: l10n.notesHint,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : Text(l10n.addReading),
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

// ─────────────────────────────────────────────────────────────
// Shared icon widget
// ─────────────────────────────────────────────────────────────

class _MeterIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const _MeterIcon({required this.icon, required this.color, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(size * 0.23),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
