import 'package:flutter/material.dart' show DateTimeRange;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../data/database/app_database.dart';
import '../../features/reports/reports_providers.dart';

// Noto Sans covers Cyrillic, Latin, Arabic, CJK and all other Unicode scripts
Future<pw.ThemeData> _buildTheme() async {
  final regular = await PdfGoogleFonts.notoSansRegular();
  final bold = await PdfGoogleFonts.notoSansBold();
  return pw.ThemeData.withFont(base: regular, bold: bold);
}

class MeterPdfLabels {
  final String reportTitle;
  final String previous;
  final String current;
  final String consumption;
  final String totalConsumption;
  final String elecTotal;
  final String generatedBy;
  final String noReadings;
  final String waterCold;
  final String waterHot;
  final String gas;
  final String electricity;
  final String electricityT1;
  final String electricityT2;
  final String electricityT3;
  final String heat;
  final String date;
  final String period;

  const MeterPdfLabels({
    required this.reportTitle,
    required this.previous,
    required this.current,
    required this.consumption,
    required this.totalConsumption,
    required this.elecTotal,
    required this.generatedBy,
    required this.noReadings,
    required this.waterCold,
    required this.waterHot,
    required this.gas,
    required this.electricity,
    required this.electricityT1,
    required this.electricityT2,
    required this.electricityT3,
    required this.heat,
    required this.date,
    required this.period,
  });
}

class PdfLabels {
  final String reportTitle;
  final String summary;
  final String income;
  final String expenses;
  final String netIncome;
  final String byMonths;
  final String month;
  final String net;
  final String total;
  final String generatedBy;

  const PdfLabels({
    required this.reportTitle,
    required this.summary,
    required this.income,
    required this.expenses,
    required this.netIncome,
    required this.byMonths,
    required this.month,
    required this.net,
    required this.total,
    required this.generatedBy,
  });
}

class PdfService {
  static Future<void> exportYearReport(
    YearReport report,
    int year, {
    required PdfLabels labels,
    required String currency,
    required String locale,
  }) async {
    final pdf = pw.Document(theme: await _buildTheme());
    final moneyFmt = NumberFormat('#,##0', locale);
    final monthFmt = DateFormat('LLLL', locale);

    String money(double v) => '${moneyFmt.format(v)} $currency';

    final nonEmpty = report.months.where((m) => m.income > 0 || m.expenses > 0).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (ctx) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'RentFlow',
                    style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('4F6AF0')),
                  ),
                  pw.Text(
                    labels.reportTitle,
                    style: const pw.TextStyle(fontSize: 13, color: PdfColors.grey700),
                  ),
                ],
              ),
              pw.Text(
                DateFormat('dd.MM.yyyy').format(DateTime.now()),
                style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
              ),
            ],
          ),

          pw.SizedBox(height: 24),
          pw.Divider(color: PdfColors.grey300),
          pw.SizedBox(height: 16),

          pw.Text(labels.summary, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('F5F7FF'),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _summaryItem(labels.income, money(report.totalIncome), PdfColor.fromHex('34C759')),
                _summaryItem(labels.expenses, money(report.totalExpenses), PdfColor.fromHex('FF3B30')),
                _summaryItem(
                  labels.netIncome,
                  money(report.totalNet),
                  report.totalNet >= 0 ? PdfColor.fromHex('34C759') : PdfColor.fromHex('FF3B30'),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 24),

          if (nonEmpty.isNotEmpty) ...[
            pw.Text(labels.byMonths, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
                3: const pw.FlexColumnWidth(2),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColor.fromHex('4F6AF0')),
                  children: [
                    _tableHeader(labels.month),
                    _tableHeader(labels.income),
                    _tableHeader(labels.expenses),
                    _tableHeader(labels.net),
                  ],
                ),
                ...nonEmpty.map((m) => pw.TableRow(
                      children: [
                        _tableCell(monthFmt.format(m.month).capitalize()),
                        _tableCell(money(m.income), color: PdfColor.fromHex('34C759')),
                        _tableCell(money(m.expenses), color: PdfColor.fromHex('FF3B30')),
                        _tableCell(
                          money(m.net),
                          color: m.net >= 0 ? PdfColor.fromHex('34C759') : PdfColor.fromHex('FF3B30'),
                          bold: true,
                        ),
                      ],
                    )),
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColor.fromHex('F5F7FF')),
                  children: [
                    _tableCell(labels.total, bold: true),
                    _tableCell(money(report.totalIncome), color: PdfColor.fromHex('34C759'), bold: true),
                    _tableCell(money(report.totalExpenses), color: PdfColor.fromHex('FF3B30'), bold: true),
                    _tableCell(
                      money(report.totalNet),
                      color: report.totalNet >= 0 ? PdfColor.fromHex('34C759') : PdfColor.fromHex('FF3B30'),
                      bold: true,
                    ),
                  ],
                ),
              ],
            ),
          ],

          pw.SizedBox(height: 32),
          pw.Divider(color: PdfColors.grey300),
          pw.SizedBox(height: 8),
          pw.Text(
            '${labels.generatedBy} • ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey500),
          ),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'rentflow_$year.pdf',
    );
  }

  static Future<void> exportMeterReport(
    Property property,
    List<MeterReading> readings, {
    required MeterPdfLabels labels,
    required String locale,
    DateTimeRange? dateRange,
  }) async {
    final pdf = pw.Document(theme: await _buildTheme());
    final dateFmt = DateFormat('dd.MM.yyyy', locale);
    final timeFmt = DateFormat('HH:mm', locale);
    final numFmt = NumberFormat('#,##0.000', locale);

    const predefinedOrder = [
      'electricity', 'electricity_t1', 'electricity_t2', 'electricity_t3',
      'water_cold', 'gas', 'heat', 'water_hot',
    ];

    final filtered = dateRange == null
        ? readings
        : readings.where((r) {
            final d = r.date;
            return !d.isBefore(dateRange.start) &&
                !d.isAfter(DateTime(dateRange.end.year, dateRange.end.month, dateRange.end.day, 23, 59, 59));
          }).toList();

    final Map<String, List<MeterReading>> byType = {};
    for (final r in filtered) {
      byType.putIfAbsent(r.type, () => []).add(r);
    }
    for (final list in byType.values) {
      list.sort((a, b) => b.date.compareTo(a.date));
    }

    String typeName(String type) => switch (type) {
          'water_cold' => labels.waterCold,
          'water_hot' => labels.waterHot,
          'gas' => labels.gas,
          'electricity' => labels.electricity,
          'electricity_t1' => labels.electricityT1,
          'electricity_t2' => labels.electricityT2,
          'electricity_t3' => labels.electricityT3,
          'heat' => labels.heat,
          _ => type,
        };

    double calcTotal(List<MeterReading> list) {
      double total = 0;
      for (int i = 0; i < list.length - 1; i++) {
        final diff = list[i].value - list[i + 1].value;
        if (diff > 0) total += diff;
      }
      return total;
    }

    pw.Widget buildSection(String type, List<MeterReading> list) {
      final isElecSub = type == 'electricity_t1' || type == 'electricity_t2' || type == 'electricity_t3';
      final sectionColor = switch (type) {
        'water_cold' => PdfColor.fromHex('007AFF'),
        'water_hot' => PdfColor.fromHex('D46B00'),
        'gas' => PdfColor.fromHex('C44B1A'),
        'electricity' || 'electricity_t1' || 'electricity_t2' || 'electricity_t3' => PdfColor.fromHex('5856D6'),
        'heat' => PdfColor.fromHex('CC2222'),
        _ => PdfColors.grey700,
      };

      final rows = <pw.TableRow>[];
      rows.add(pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColor.fromHex('4F6AF0')),
        children: [
          _tableHeader(labels.date),
          _tableHeader(labels.previous),
          _tableHeader(labels.current),
          _tableHeader(labels.consumption),
        ],
      ));

      double totalConsumption = 0;
      for (int i = 0; i < list.length; i++) {
        final curr = list[i];
        final prev = i + 1 < list.length ? list[i + 1] : null;
        final diff = prev != null ? curr.value - prev.value : null;
        if (diff != null && diff > 0) totalConsumption += diff;

        final isEven = i % 2 == 0;
        rows.add(pw.TableRow(
          decoration: isEven ? null : pw.BoxDecoration(color: PdfColor.fromHex('F8F9FF')),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(dateFmt.format(curr.date),
                      style: const pw.TextStyle(fontSize: 9)),
                  pw.Text(timeFmt.format(curr.createdAt),
                      style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
                ],
              ),
            ),
            _tableCell(prev != null ? numFmt.format(prev.value) : '—'),
            _tableCell(numFmt.format(curr.value), bold: true),
            _tableCell(
              diff != null && diff >= 0
                  ? '+${numFmt.format(diff)}'
                  : diff != null ? numFmt.format(diff) : '—',
              color: diff != null && diff > 0 ? PdfColor.fromHex('1A7A3A') : PdfColors.grey600,
            ),
          ],
        ));

        if (curr.notes != null && curr.notes!.isNotEmpty) {
          rows.add(pw.TableRow(
            decoration: pw.BoxDecoration(color: PdfColor.fromHex('FFFBE6')),
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(8, 2, 8, 4),
                child: pw.Text('📝 ${curr.notes!}',
                    style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
              ),
              pw.SizedBox(), pw.SizedBox(), pw.SizedBox(),
            ],
          ));
        }
      }

      rows.add(pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColor.fromHex('F0F3FF')),
        children: [
          _tableCell(labels.totalConsumption, bold: true),
          pw.SizedBox(),
          pw.SizedBox(),
          _tableCell('+${numFmt.format(totalConsumption)}',
              color: PdfColor.fromHex('1A7A3A'), bold: true),
        ],
      ));

      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            padding: pw.EdgeInsets.symmetric(
                horizontal: 12, vertical: isElecSub ? 6 : 8),
            decoration: pw.BoxDecoration(
              color: isElecSub
                  ? PdfColor.fromHex('7875E0')
                  : sectionColor,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            ),
            child: pw.Text(
              typeName(type),
              style: pw.TextStyle(
                fontSize: isElecSub ? 11 : 13,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey200, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(2.2),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(1.8),
            },
            children: rows,
          ),
          pw.SizedBox(height: 16),
        ],
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (ctx) {
          final sections = <pw.Widget>[];

          sections.add(
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('RentFlow',
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('4F6AF0'))),
                    pw.Text(labels.reportTitle,
                        style: const pw.TextStyle(
                            fontSize: 12, color: PdfColors.grey700)),
                  ],
                ),
                pw.Text(
                  DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now()),
                  style: const pw.TextStyle(
                      fontSize: 10, color: PdfColors.grey600),
                ),
              ],
            ),
          );

          sections.add(pw.SizedBox(height: 6));
          sections.add(pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('F5F7FF'),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            ),
            child: pw.Row(children: [
              pw.Text('${property.name}  •  ',
                  style: pw.TextStyle(
                      fontSize: 11, fontWeight: pw.FontWeight.bold)),
              pw.Expanded(
                child: pw.Text(property.address,
                    style: const pw.TextStyle(
                        fontSize: 11, color: PdfColors.grey700)),
              ),
            ]),
          ));

          if (dateRange != null) {
            sections.add(pw.SizedBox(height: 8));
            sections.add(pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('EEF0FF'),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              child: pw.Row(
                children: [
                  pw.Text('${labels.period}: ',
                      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('4F6AF0'))),
                  pw.Text(
                    '${dateFmt.format(dateRange.start)} – ${dateFmt.format(dateRange.end)}',
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey800),
                  ),
                ],
              ),
            ));
          }
          sections.add(pw.SizedBox(height: 14));
          sections.add(pw.Divider(color: PdfColors.grey300));
          sections.add(pw.SizedBox(height: 14));

          // Electricity: combined total header when T1/T2/T3 used
          final t1List = byType['electricity_t1'] ?? [];
          final t2List = byType['electricity_t2'] ?? [];
          final t3List = byType['electricity_t3'] ?? [];
          final hasMultiTariff = t1List.isNotEmpty || t2List.isNotEmpty || t3List.isNotEmpty;

          if (hasMultiTariff) {
            final t1Total = calcTotal(t1List);
            final t2Total = calcTotal(t2List);
            final t3Total = calcTotal(t3List);
            final grandTotal = t1Total + t2Total + t3Total;

            sections.add(pw.Container(
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('5856D6'),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(labels.elecTotal,
                      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    if (t1List.isNotEmpty) ...[
                      pw.Text('T1: +${numFmt.format(t1Total)}',
                          style: pw.TextStyle(fontSize: 11, color: PdfColors.white, fontWeight: pw.FontWeight.bold)),
                    ],
                    if (t1List.isNotEmpty && t2List.isNotEmpty)
                      pw.Text('  +  ', style: const pw.TextStyle(fontSize: 11, color: PdfColors.white)),
                    if (t2List.isNotEmpty) ...[
                      pw.Text('T2: +${numFmt.format(t2Total)}',
                          style: pw.TextStyle(fontSize: 11, color: PdfColors.white, fontWeight: pw.FontWeight.bold)),
                    ],
                    if (t3List.isNotEmpty) ...[
                      pw.Text('  +  ', style: const pw.TextStyle(fontSize: 11, color: PdfColors.white)),
                      pw.Text('T3: +${numFmt.format(t3Total)}',
                          style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('A0E8A0'), fontWeight: pw.FontWeight.bold)),
                    ],
                    pw.Text('  =  ', style: const pw.TextStyle(fontSize: 11, color: PdfColors.white)),
                    pw.Text('+${numFmt.format(grandTotal)}',
                        style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
                  ]),
                ],
              ),
            ));
            sections.add(pw.SizedBox(height: 10));

            if (t1List.isNotEmpty) sections.add(buildSection('electricity_t1', t1List));
            if (t2List.isNotEmpty) sections.add(buildSection('electricity_t2', t2List));
            if (t3List.isNotEmpty) sections.add(buildSection('electricity_t3', t3List));
          } else if (byType['electricity']?.isNotEmpty ?? false) {
            sections.add(buildSection('electricity', byType['electricity']!));
          }

          // Remaining non-electricity types
          for (final type in ['water_cold', 'gas', 'heat', 'water_hot']) {
            final list = byType[type];
            if (list == null || list.isEmpty) continue;
            sections.add(buildSection(type, list));
          }

          // Custom types not in predefined list
          for (final type in byType.keys) {
            if (predefinedOrder.contains(type)) continue;
            sections.add(buildSection(type, byType[type]!));
          }

          sections.add(pw.Divider(color: PdfColors.grey300));
          sections.add(pw.SizedBox(height: 6));
          sections.add(pw.Text(
            '${labels.generatedBy}  •  ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ));

          return sections;
        },
      ),
    );

    final propertySlug = property.name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: dateRange != null
          ? 'meters_${propertySlug}_${DateFormat('yyyy_MM_dd').format(dateRange.start)}_${DateFormat('yyyy_MM_dd').format(dateRange.end)}.pdf'
          : 'meters_${propertySlug}_${DateFormat('yyyy_MM').format(DateTime.now())}.pdf',
    );
  }

  static pw.Widget _summaryItem(String label, String value, PdfColor color) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.SizedBox(height: 4),
        pw.Text(value, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: color)),
      ],
    );
  }

  static pw.Widget _tableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.white),
      ),
    );
  }

  static pw.Widget _tableCell(String text, {PdfColor? color, bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          color: color ?? PdfColors.black,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}

extension _StringExt on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
