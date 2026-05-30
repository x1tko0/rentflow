import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../constants/app_constants.dart';

class BillingService {
  static bool _initialized = false;

  static bool get isConfigured =>
      AppConstants.revenueCatApiKey.isNotEmpty &&
      !AppConstants.revenueCatApiKey.startsWith('TODO_');

  static Future<void> init() async {
    if (_initialized || !isConfigured) return;

    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    final configuration = PurchasesConfiguration(AppConstants.revenueCatApiKey)
      ..diagnosticsEnabled = kDebugMode;
    await Purchases.configure(configuration);
    _initialized = true;
  }

  static Future<bool> isPro() async {
    if (AppConstants.kDebugProUnlocked) return true;
    if (!isConfigured) return false;
    await init();
    final info = await Purchases.getCustomerInfo();
    return _hasPro(info);
  }

  static Future<List<Package>> getPackages() async {
    if (!isConfigured) return const [];
    await init();
    final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    if (current == null) return const [];

    final packages = <Package>[
      if (current.monthly != null) current.monthly!,
      if (current.annual != null) current.annual!,
      ...current.availablePackages.where(
        (package) =>
            package.packageType != PackageType.monthly &&
            package.packageType != PackageType.annual,
      ),
    ];
    return packages;
  }

  static Future<bool> purchase(Package package) async {
    await init();
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _hasPro(result.customerInfo);
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) return false;
      rethrow;
    }
  }

  static Future<bool> restorePurchases() async {
    if (!isConfigured) return false;
    await init();
    final info = await Purchases.restorePurchases();
    return _hasPro(info);
  }

  static bool _hasPro(CustomerInfo info) =>
      info.entitlements.active.containsKey(AppConstants.entitlementPro);
}
