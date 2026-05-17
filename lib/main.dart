import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/services/notification_service.dart';

late final SharedPreferences globalPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await NotificationService.init();
  globalPrefs = await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: RentFlowApp()));
}
