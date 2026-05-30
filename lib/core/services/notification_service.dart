import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationBackgroundHandler(NotificationResponse response) {}

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: android),
      onDidReceiveNotificationResponse: (_) {},
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler,
    );
    _initialized = true;
  }

  static Future<void> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  static Future<bool> _canExact() async {
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    return await android?.canScheduleExactNotifications() ?? false;
  }

  static Future<void> schedulePaymentReminder({
    required int id,
    required String title,
    required String body,
    required DateTime paymentDate,
    int daysBefore = 3,
  }) async {
    final notifyDate = paymentDate.subtract(Duration(days: daysBefore));
    if (notifyDate.isBefore(DateTime.now())) return;

    final mode = await _canExact() ? AndroidScheduleMode.exactAllowWhileIdle : AndroidScheduleMode.inexact;

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notifyDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'payment_reminders',
          'Payment reminders',
          channelDescription: 'Notifications about upcoming payments',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: mode,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> showOverdueNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'overdue_payments',
          'Overdue payments',
          channelDescription: 'Notifications about overdue payments',
          importance: Importance.max,
          priority: Priority.max,
          color: Colors.red,
        ),
      ),
    );
  }

  static Future<void> scheduleLeaseEndReminder({
    required int id,
    required String title,
    required String body,
    required DateTime leaseEnd,
    int daysBefore = 30,
  }) async {
    final notifyDate = leaseEnd.subtract(Duration(days: daysBefore));
    if (notifyDate.isBefore(DateTime.now())) return;

    final mode = await _canExact() ? AndroidScheduleMode.exactAllowWhileIdle : AndroidScheduleMode.inexact;

    await _plugin.zonedSchedule(
      id + 200000,
      title,
      body,
      tz.TZDateTime.from(notifyDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'lease_reminders',
          'Lease reminders',
          channelDescription: 'Notifications about expiring leases',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: mode,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> showTestNotification({required String title, required String body}) async {
    await _plugin.show(
      99999,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'payment_reminders',
          'Payment reminders',
          channelDescription: 'Notifications about upcoming payments',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> cancelLeaseReminder(int id) => _plugin.cancel(id + 200000);

  static Future<void> cancelAll() => _plugin.cancelAll();
  static Future<void> cancel(int id) => _plugin.cancel(id);
}
