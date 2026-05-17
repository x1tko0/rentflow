import 'package:intl/intl.dart';

String formatMoney(double amount, {String currency = '\$'}) {
  final f = NumberFormat('#,##0', 'ru_RU');
  return '${f.format(amount)} $currency';
}

String formatDate(DateTime date) => DateFormat('d MMM yyyy', 'ru_RU').format(date);

String formatMonth(DateTime date) => DateFormat('LLLL yyyy', 'ru_RU').format(date);

String monthLabel(int monthOffset) {
  final date = DateTime(DateTime.now().year, DateTime.now().month + monthOffset);
  return DateFormat('MMM', 'ru_RU').format(date);
}
