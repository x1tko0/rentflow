import 'package:intl/intl.dart';

String formatMoney(double amount, {String currency = '\$'}) {
  final f = NumberFormat('#,##0', 'ru_RU');
  return '${f.format(amount)} $currency';
}

String formatDate(DateTime date, {String locale = 'ru_RU'}) =>
    DateFormat('d MMM yyyy', locale).format(date);

String formatMonth(DateTime date, {String locale = 'ru_RU'}) =>
    DateFormat('LLLL yyyy', locale).format(date);

String monthLabel(int monthOffset, {String locale = 'ru_RU'}) {
  final date = DateTime(DateTime.now().year, DateTime.now().month + monthOffset);
  return DateFormat('MMM', locale).format(date);
}
