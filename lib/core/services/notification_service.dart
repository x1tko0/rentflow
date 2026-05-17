import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: android),
    );
    _initialized = true;
  }

  static Future<void> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  static Future<void> schedulePaymentReminder({
    required int id,
    required String tenantName,
    required double amount,
    required DateTime paymentDate,
  }) async {
    final notifyDate = paymentDate.subtract(const Duration(days: 3));
    if (notifyDate.isBefore(DateTime.now())) return;

    await _plugin.zonedSchedule(
      id,
      'Платёж через 3 дня',
      '$tenantName — ${amount.toStringAsFixed(0)} ₽',
      tz.TZDateTime.from(notifyDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'payment_reminders',
          'Напоминания о платежах',
          channelDescription: 'Уведомления о предстоящих платежах',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> showOverdueNotification({
    required int id,
    required String tenantName,
    required double amount,
  }) async {
    await _plugin.show(
      id,
      'Просроченный платёж',
      '$tenantName — ${amount.toStringAsFixed(0)} ₽ не оплачен',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'overdue_payments',
          'Просроченные платежи',
          channelDescription: 'Уведомления о просроченных платежах',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/ic_launcher',
          color: Colors.red,
        ),
      ),
    );
  }

  static Future<void> cancelAll() => _plugin.cancelAll();
  static Future<void> cancel(int id) => _plugin.cancel(id);
}
