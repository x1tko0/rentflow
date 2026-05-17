import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';

class AppSettings {
  final ThemeMode themeMode;
  final String currency;
  final bool biometricEnabled;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.currency = '\$',
    this.biometricEnabled = false,
  });

  AppSettings copyWith({ThemeMode? themeMode, String? currency, bool? biometricEnabled}) => AppSettings(
        themeMode: themeMode ?? this.themeMode,
        currency: currency ?? this.currency,
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
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
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
