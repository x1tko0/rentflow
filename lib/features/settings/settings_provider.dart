import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String currency;
  final bool biometricEnabled;
  final int notificationDaysBefore;
  final bool notificationsEnabled;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.currency = '\$',
    this.biometricEnabled = false,
    this.notificationDaysBefore = 3,
    this.notificationsEnabled = true,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? currency,
    bool? biometricEnabled,
    int? notificationDaysBefore,
    bool? notificationsEnabled,
  }) => AppSettings(
        themeMode: themeMode ?? this.themeMode,
        currency: currency ?? this.currency,
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
        notificationDaysBefore: notificationDaysBefore ?? this.notificationDaysBefore,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      );
}

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final prefs = globalPrefs;
    final themeIndex = prefs.getInt('theme_mode') ?? ThemeMode.system.index;
    return AppSettings(
      themeMode: ThemeMode.values[themeIndex],
      currency: prefs.getString('currency') ?? '\$',
      biometricEnabled: prefs.getBool('biometric_enabled') ?? false,
      notificationDaysBefore: prefs.getInt('notify_days_before') ?? 3,
      notificationsEnabled: prefs.getBool('notifications_enabled') ?? false,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await globalPrefs.setInt('theme_mode', mode.index);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setCurrency(String currency) async {
    await globalPrefs.setString('currency', currency);
    state = state.copyWith(currency: currency);
  }

  Future<void> setBiometric(bool enabled) async {
    await globalPrefs.setBool('biometric_enabled', enabled);
    state = state.copyWith(biometricEnabled: enabled);
  }

  Future<void> setNotificationDaysBefore(int days) async {
    await globalPrefs.setInt('notify_days_before', days);
    state = state.copyWith(notificationDaysBefore: days);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await globalPrefs.setBool('notifications_enabled', enabled);
    state = state.copyWith(notificationsEnabled: enabled);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
