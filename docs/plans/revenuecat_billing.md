# RentFlow — RevenueCat Billing ТЗ

## Статус
- [ ] В разработке (выполнять после загрузки AAB в Play Console)

## Play Console
- Сейчас в анкете Play Console на вопрос "Можно ли в приложении купить цифровые товары?" выбран ответ "Нет", потому что покупка Pro ещё не реализована.
- После подключения RevenueCat / Google Play Billing обязательно поменять ответ на "Да" и указать, что цифровые товары покупаются через Google Play Billing.

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
   - `rentflow_pro_monthly` — $6.99/мес
   - `rentflow_pro_yearly` — $59.99/год
6. Получить Public SDK key → вставить в `AppConstants.revenueCatApiKey`
7. После загрузки билда с Billing SDK поменять Play Console → "Можно ли в приложении купить цифровые товары?" → "Да"

---

## Код — что реализовать

### 1. AppConstants (`lib/core/constants/app_constants.dart`)
`AppConstants` уже содержит `revenueCatApiKey`, `entitlementPro`, `proMonthlyProductId`, `proYearlyProductId`. До получения реального ключа `revenueCatApiKey` остаётся `TODO_REVENUECAT_PUBLIC_SDK_KEY`.

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

## Порядок завершения

1. Создать продукты в Play Console.
2. Создать RevenueCat offering с monthly и annual packages.
3. Вставить реальный RevenueCat Public SDK key в `AppConstants.revenueCatApiKey`.
4. Пересобрать AAB с новым `versionCode`.
5. В Play Console поменять цифровые товары на "Да" и загрузить новый билд.

Кодовая интеграция уже подготовлена: `BillingService`, `proStatusProvider`, Pro purchase sheet и restore purchases.
