import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashReportingService {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        unawaited(FirebaseCrashlytics.instance.recordFlutterFatalError(details));
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        unawaited(FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
        return true;
      };
    } catch (e, stack) {
      debugPrint('Crash reporting disabled: $e');
      debugPrintStack(stackTrace: stack);
    }
  }
}
