import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/pdf_service.dart';
import '../../core/utils/formatters.dart';
import '../../generated/app_localizations.dart';
import '../settings/settings_provider.dart';
import 'reports_providers.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final year = ref.watch(selectedYearProvider);
    final report = ref.watch(yearReportProvider);
    final currency = ref.watch(settingsProvider).currency;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reportsTitle),
        actions: [
          report.whenOrNull(
            data: (r) => _ProLockedIconButton(
              icon: Icons.picture_as_pdf_outlined,
              tooltip: l10n.exportPdf,
              onProUnlocked: () => PdfService.exportYearReport(r, year),
              l10n: l10n,
            ),
          ) ?? const SizedBox.shrink(),
          _YearSwitcher(year: year, ref: ref),
        ],
      ),
      body: report.when(
        data: (r) => _ReportBody(report: r, year: year, l10n: l10n, currency: currency),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class _ProLockedIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onProUnlocked;
  final AppLocalizations l10n;
  const _ProLockedIconButton({required this.icon, required this.tooltip, required this.onProUnlocked, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          tooltip: tooltip,
          onPressed: () => _showProDialog(context),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF4F6AF0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('PRO', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }

  void _showProDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.proFeatureMessage)),
    );
  }
}

class _YearSwitcher extends StatelessWidget {
  final int year;
  final WidgetRef ref;
  const _YearSwitcher({required this.year, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => ref.read(selectedYearProvider.notifier).state = year - 1,
        ),
        Text('$year', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: year < DateTime.now().year
              ? () => ref.read(selectedYearProvider.notifier).state = year + 1
              : null,
        ),
      ],
    );
  }
}

class _ReportBody extends StatelessWidget {
  final YearReport report;
  final int year;
  final AppLocalizations l10n;
  final String currency;
  const _ReportBody({required this.report, required this.year, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      children: [
        _SummaryPanel(report: report, l10n: l10n, currency: currency),
        const SizedBox(height: 24),
        _ChartCard(report: report, l10n: l10n, currency: currency),
        const SizedBox(height: 24),
        _MonthlyTable(report: report, l10n: l10n, currency: currency),
      ],
    );
  }
}

class _SummaryPanel extends StatelessWidget {
  final YearReport report;
  final AppLocalizations l10n;
  final String currency;
  const _SummaryPanel({required this.report, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = report.totalNet >= 0;
    final netColor = isPositive ? const Color(0xFF34C759) : const Color(0xFFFF3B30);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _MetricRow(
            icon: Icons.arrow_upward_rounded,
            iconColor: const Color(0xFF34C759),
            label: l10n.yearlyIncome,
            value: formatMoney(report.totalIncome, currency: currency),
            valueColor: const Color(0xFF34C759),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          _MetricRow(
            icon: Icons.arrow_downward_rounded,
            iconColor: const Color(0xFFFF3B30),
            label: l10n.yearlyExpenses,
            value: formatMoney(report.totalExpenses, currency: currency),
            valueColor: const Color(0xFFFF3B30),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: netColor.withValues(alpha: 0.07),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: netColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    color: netColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.netProfit,
                          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 2),
                      Text(
                        formatMoney(report.totalNet, currency: currency),
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: netColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: netColor, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    isPositive ? l10n.profit : l10n.loss,
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color valueColor;
  const _MetricRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const Spacer(),
          Text(value,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: valueColor)),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final YearReport report;
  final AppLocalizations l10n;
  final String currency;
  const _ChartCard({required this.report, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final months = l10n.chartMonthAbbr.split(',');
    final maxY = report.months.fold<double>(0, (m, s) => [m, s.income, s.expenses].reduce((a, b) => a > b ? a : b));
    final chartMax = maxY == 0 ? 10000.0 : maxY * 1.2;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.incomeExpensesByMonth, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(children: [
            _Legend(color: const Color(0xFF34C759), label: l10n.incomeTooltip),
            const SizedBox(width: 16),
            _Legend(color: const Color(0xFFFF3B30), label: l10n.expenseTooltip),
          ]),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                maxY: chartMax,
                minY: 0,
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: chartMax / 4,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: theme.colorScheme.outlineVariant,
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, meta) {
                        final i = v.toInt();
                        if (i < 0 || i >= months.length) return const SizedBox.shrink();
                        return Text(months[i], style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant));
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(12, (i) {
                  final m = report.months[i];
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(toY: m.income, color: const Color(0xFF34C759), width: 8, borderRadius: BorderRadius.circular(4)),
                      BarChartRodData(toY: m.expenses, color: const Color(0xFFFF3B30), width: 8, borderRadius: BorderRadius.circular(4)),
                    ],
                    barsSpace: 3,
                  );
                }),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => theme.colorScheme.surface,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final label = rodIndex == 0 ? l10n.incomeTooltip : l10n.expenseTooltip;
                      return BarTooltipItem(
                        '$label\n${formatMoney(rod.toY, currency: currency)}',
                        theme.textTheme.labelSmall!.copyWith(color: theme.colorScheme.onSurface),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

class _MonthlyTable extends StatelessWidget {
  final YearReport report;
  final AppLocalizations l10n;
  final String currency;
  const _MonthlyTable({required this.report, required this.l10n, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nonEmpty = report.months.where((m) => m.income > 0 || m.expenses > 0).toList().reversed.toList();

    if (nonEmpty.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(l10n.noDataForYear, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(l10n.byMonth, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text(l10n.month, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant))),
                Expanded(child: Text(l10n.income, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.right)),
                Expanded(child: Text(l10n.expense, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.right)),
                Expanded(child: Text(l10n.net, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant), textAlign: TextAlign.right)),
              ],
            ),
          ),
          const Divider(height: 1),
          ...nonEmpty.map((m) => _MonthRow(stat: m, currency: currency)),
        ],
      ),
    );
  }
}

class _MonthRow extends StatelessWidget {
  final MonthStat stat;
  final String currency;
  const _MonthRow({required this.stat, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final netColor = stat.net >= 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(formatMonth(stat.month), style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500))),
              Expanded(child: Text(formatMoney(stat.income, currency: currency), textAlign: TextAlign.right, style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFF34C759), fontWeight: FontWeight.w600))),
              Expanded(child: Text(formatMoney(stat.expenses, currency: currency), textAlign: TextAlign.right, style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFFFF3B30), fontWeight: FontWeight.w600))),
              Expanded(child: Text(formatMoney(stat.net, currency: currency), textAlign: TextAlign.right, style: theme.textTheme.bodySmall?.copyWith(color: netColor, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        Divider(height: 1, color: theme.colorScheme.outlineVariant),
      ],
    );
  }
}
