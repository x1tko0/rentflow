# RentFlow — Plan Store Release Plan

## Статус на 2026-05-30
- ✅ Chinese (zh) — 15 строк добавлены
- ✅ AAB 1.0.0+2 собран: `build\app\outputs\bundle\release\app-release.aab` (55.0 МБ)
- ✅ APK собран: `build\app\outputs\flutter-apk\app-release.apk` (70.3 МБ)
- ✅ Пакет: `io.orbitray.rentflow`
- ✅ Firebase проект: `rentflow-1920d`
- ✅ Google Drive бэкап: протестирован, OAuth scope `drive.appdata` добавлен
- ✅ Google Drive API включён в Google Cloud Console
- ✅ Store listing заполнен: описание, иконка, feature graphic, phone/7"/10" screenshots
- ✅ Privacy Policy URL: https://x1tko0.github.io/rentflow/privacy/
- ✅ App content заполнен, включая exact alarm declaration: календарные напоминания
- ✅ Advertising ID declaration: приложение не использует Advertising ID
- ✅ Financial features: приложение не содержит финансовых функций
- ✅ RevenueCat/Billing кодовая интеграция подготовлена, ключ пока `TODO_REVENUECAT_PUBLIC_SDK_KEY`
- ✅ Firebase Crashlytics подключён, privacy policy обновлена
- ✅ Новый билд отправлен на проверку Google Play

## Следующие шаги после проверки Google Play

1. Дождаться результата review для отправленного билда.
2. Если review вернёт замечания — исправить их до настройки монетизации.
3. После одобрения проверить раздел `Монетизация в Google Play → Продукты → Подписки`.
4. Создать подписки:
   - `rentflow_pro_monthly` — $6.99/мес
   - `rentflow_pro_yearly` — $59.99/год
5. Настроить RevenueCat:
   - Android app package: `io.orbitray.rentflow`
   - Entitlement: `pro`
   - Offering: monthly + annual packages
   - Products: `rentflow_pro_monthly`, `rentflow_pro_yearly`
6. Получить RevenueCat Public SDK key и заменить `AppConstants.revenueCatApiKey`.
7. Обновить Play Console Data Safety после Billing/RevenueCat:
   - Crashlytics diagnostics/crash data уже нужно раскрывать
   - RevenueCat/Billing purchase/subscription data нужно раскрыть после включения покупок
8. Скачать Play App Signing certificate и добавить SHA-1 в Firebase/Google Cloud для Google Drive backup:
   - Play Console → Release → Setup → App signing → `deployment_cert.der`
   - `keytool -printcert -file deployment_cert.der`
   - Firebase Console → Project Settings → Android app → Add fingerprint
   - Google Cloud Console → Android OAuth client с Play App Signing SHA-1
   - скачать новый `google-services.json` и заменить `android/app/google-services.json`
9. Пересобрать AAB с новым `versionCode` и загрузить следующий билд.
10. Перед загрузкой билда с активными покупками убедиться, что Play Console → цифровые товары = `Да`.

---

## Приоритет 1 — Загрузка в Google Play Console

### Шаг 1: Графика и описание
- [x] Иконка приложения 512×512 PNG
- [x] Feature graphic 1024×500 PNG
- [x] Скриншоты phone / 7-inch tablet / 10-inch tablet
- [x] Короткое описание (до 80 символов)
- [x] Полное описание (до 4000 символов)
- [x] Privacy Policy URL: https://x1tko0.github.io/rentflow/privacy/
- [x] Data Safety: disclose Firebase Crashlytics diagnostics/crash data after Crashlytics integration

### Шаг 2: Play Console — первая загрузка
- [x] Создать приложение → пакет `io.orbitray.rentflow`
- [x] Загрузить AAB на testing track
- [x] Заполнить Content rating анкету
- [x] Указать Privacy Policy URL
- [x] Отправить билд на проверку

### Шаг 3: SHA-1 Play App Signing — после первой загрузки AAB ⚠️
После загрузки AAB Google подписывает его своим ключом. Нужно:
1. Play Console → Release → Setup → App signing → скачать `deployment_cert.der`
2. Извлечь SHA-1: `keytool -printcert -file deployment_cert.der`
3. Добавить SHA-1 в Firebase Console → Project Settings → Android app → Add fingerprint
4. Создать новый Android OAuth client в Google Cloud Console с этим SHA-1
5. Скачать обновлённый `google-services.json` из Firebase → заменить в `android/app/`
6. Пересобрать AAB и загрузить новую версию

> Без этого SHA-1 Google Sign In (и бэкап) не работает у пользователей из Play Store.

---

## Приоритет 2 — Биллинг (RevenueCat) — после загрузки AAB в Play

Детальное ТЗ: [revenuecat_billing.md](revenuecat_billing.md)

**Порядок шагов:**
1. Создать продукты в Play Console (Monetize → Subscriptions):
   - `rentflow_pro_monthly` — $6.99/мес
   - `rentflow_pro_yearly` — $59.99/год
2. Зарегистрироваться на app.revenuecat.com
3. Создать проект → Android → пакет `io.orbitray.rentflow`
4. Подключить Google Play (service account JSON)
5. Создать Entitlement `pro` → добавить продукты
6. Получить Public SDK key
7. Вставить RevenueCat Public SDK key в `AppConstants.revenueCatApiKey`

> Кодовая интеграция уже реализована. Без продуктов в Play Console и RevenueCat SDK key покупки останутся недоступны.

---

## Приоритет 3 — In-App Review

- Добавить `in_app_review` пакет
- Показывать после 3-го успешно записанного платежа
- Реально работает только после публикации в Play Store

---

## Приоритет 4 — Технические доработки (опционально)

- [ ] ProGuard/R8 для уменьшения размера AAB
- [x] Crashlytics
- [ ] Firebase Analytics
- [ ] Шаблон договора аренды PDF
- [ ] CSV/Excel экспорт платежей
