# RentFlow — Plan Store Release Plan

## Статус на 2026-05-20
- ✅ Chinese (zh) — 15 строк добавлены
- ✅ AAB собран: `build\app\outputs\bundle\release\app-release.aab` (51.9 МБ)
- ✅ APK собран: `build\app\outputs\flutter-apk\app-release.apk` (70.3 МБ)
- ✅ Пакет: `io.orbitray.rentflow`
- ✅ Firebase проект: `rentflow-1920d`
- ✅ Google Drive бэкап: протестирован, OAuth scope `drive.appdata` добавлен
- ✅ Google Drive API включён в Google Cloud Console

---

## Приоритет 1 — Загрузка в Google Play Console

### Шаг 1: Графика и описание
- [ ] Иконка приложения 512×512 PNG
- [ ] Feature graphic 1024×500 PNG
- [ ] Скриншоты (минимум 2, лучше 4–8)
- [ ] Короткое описание (до 80 символов)
- [ ] Полное описание (до 4000 символов)
- [ ] Privacy Policy URL: https://x1tko0.github.io/rentflow/privacy/
- [ ] Data Safety: disclose Firebase Crashlytics diagnostics/crash data after Crashlytics integration

### Шаг 2: Play Console — первая загрузка
- [ ] Создать приложение → пакет `io.orbitray.rentflow`
- [ ] Загрузить AAB на Internal testing track
- [ ] Заполнить Content rating анкету
- [ ] Указать Privacy Policy URL

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
7. Реализовать в коде (см. revenuecat_billing.md)

> Без продуктов в Play Console RevenueCat нельзя настроить. Сначала — листинг.

---

## Приоритет 3 — In-App Review

- Добавить `in_app_review` пакет
- Показывать после 3-го успешно записанного платежа
- Реально работает только после публикации в Play Store

---

## Приоритет 4 — Технические доработки (опционально)

- [ ] ProGuard/R8 для уменьшения размера AAB
- [ ] Crashlytics / Firebase Analytics
- [ ] Шаблон договора аренды PDF
- [ ] CSV/Excel экспорт платежей
