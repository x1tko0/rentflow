import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../features/reports/reports_providers.dart';

class PdfService {
  static Future<void> exportYearReport(YearReport report, int year) async {
    final pdf = pw.Document();
    final moneyFmt = NumberFormat('#,##0', 'ru_RU');
    final monthFmt = DateFormat('LLLL', 'ru_RU');

    String money(double v) => '${moneyFmt.format(v)} ₽';

    final nonEmpty = report.months.where((m) => m.income > 0 || m.expenses > 0).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (ctx) => [
          // Шапка
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
                    'Финансовый отчёт за $year год',
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

          // Сводка
          pw.Text('Сводка', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
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
                _summaryItem('Доход', money(report.totalIncome), PdfColor.fromHex('34C759')),
                _summaryItem('Расходы', money(report.totalExpenses), PdfColor.fromHex('FF3B30')),
                _summaryItem(
                  'Чистый доход',
                  money(report.totalNet),
                  report.totalNet >= 0 ? PdfColor.fromHex('34C759') : PdfColor.fromHex('FF3B30'),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 24),

          // Таблица по месяцам
          if (nonEmpty.isNotEmpty) ...[
            pw.Text('По месяцам', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
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
                // Заголовок
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColor.fromHex('4F6AF0')),
                  children: [
                    _tableHeader('Месяц'),
                    _tableHeader('Доход'),
                    _tableHeader('Расходы'),
                    _tableHeader('Чистый'),
                  ],
                ),
                // Строки
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
                // Итого
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColor.fromHex('F5F7FF')),
                  children: [
                    _tableCell('Итого', bold: true),
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
            'Сформировано в RentFlow • ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}',
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
