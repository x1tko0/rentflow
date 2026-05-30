# RentFlow — RevenueCat Billing ТЗ

## Статус
- [ ] В разработке (выполнять после загрузки AAB в Play Console)

## Зависимости
```yaml
# pubspec.yaml
purchases_flutter: ^8.0.0
```

---

## Конфигурация RevenueCat (после Play Store)

1. Зарегистрироваться на app.revenuecat.com
2. Создать проект → Android → пакет `io.orbitray.rentflow`
3. Подключить Google Play (service account JSON)
4. Создать Entitlement: `pro`
5. Создать продукты:
   - `rentflow_pro_monthly` — $2.99/мес
   - `rentflow_pro_yearly` — $24.99/год
6. Получить Public SDK key → вставить в `AppConstants.revenueCatApiKey`

---

## Код — что реализовать

### 1. AppConstants (`lib/core/constants/app_constants.dart`)
```dart
static const String revenueCatApiKey = 'YOUR_REVENUECAT_PUBLIC_KEY';
static const String entitlementPro = 'pro';
```

### 2. BillingService (`lib/core/services/billing_service.dart`)
```dart
static Future<void> init()           // Purchases.configure(PurchasesConfiguration(key))
static Future<bool> isPro()          // проверить entitlement 'pro'
static Future<List<Package>> getPackages()  // загрузить пакеты из RC
static Future<void> purchase(Package p)     // купить пакет
static Future<void> restorePurchases()      // восстановить покупки
```
Обработка ошибок: `PurchasesErrorCode.purchaseCancelledError` → молча выйти.

### 3. ProStatusProvider (`lib/shared/providers/pro_status_provider.dart`)
```dart
final proStatusProvider = FutureProvider<bool>((ref) => BillingService.isPro());
```
Использовать вместо `AppConstants.kDebugProUnlocked` везде в UI.

### 4. ProGateSheet (`lib/shared/widgets/pro_gate_sheet.dart`)
- CTA-кнопка → `onTap` → загрузить пакеты → показать спиннер → `purchase()`
- После успеха → `ref.invalidate(proStatusProvider)` → закрыть шторку → `onUnlocked()`
- Отмена → убрать спиннер, ничего не показывать
- Ошибка → снэкбар с текстом ошибки

### 5. RestorePurchasesTile (`lib/features/settings/settings_screen.dart`)
- Вместо `Future.delayed` → `BillingService.restorePurchases()`
- После → `ref.invalidate(proStatusProvider)`

### 6. main.dart
```dart
await BillingService.init();  // добавить после globalPrefs
```

---

## Порядок реализации

1. Добавить `purchases_flutter` в `pubspec.yaml`
2. Добавить `AppConstants.revenueCatApiKey` (пока заглушка `'PLACEHOLDER'`)
3. Реализовать `BillingService`
4. Создать `proStatusProvider`
5. Заменить все `kDebugProUnlocked` на `ref.watch(proStatusProvider)`
6. Подключить покупку в `ProGateSheet`
7. Подключить restore в `RestorePurchasesTile`
8. Вставить реальный SDK key после получения из RevenueCat

> Шаги 1–7 можно сделать до Play Store (с заглушкой ключа). Шаг 8 — после регистрации в RevenueCat.
