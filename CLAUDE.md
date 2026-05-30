# RentFlow

Менеджер аренды для частных арендодателей (1–5 квартир). Android only.

## Стек
- Flutter 3.41.6 / Dart 3.11.4 (Android only)
- Riverpod (state management)
- Drift (SQLite, локальная БД)
- GoRouter (навигация)
- flutter_local_notifications (уведомления)
- Supabase (бэкенд для Pro, пока не реализован)

## Структура
```
lib/
├── app/              # App config, router, biometric gate
├── core/
│   ├── constants/    # AppConstants, enums
│   ├── services/     # NotificationService, PdfService
│   └── utils/        # formatters (formatDate, formatMoney, formatMonth)
├── data/
│   ├── database/     # AppDatabase (Drift)
│   └── repositories/ # PaymentRepository, TenantRepository, ExpenseRepository, PropertyRepository
├── features/
│   ├── dashboard/    # Главный экран, провайдеры (StreamProvider)
│   ├── tenants/      # Список и форма арендаторов
│   ├── payments/     # Список платежей, добавление
│   ├── expenses/     # Список расходов, добавление
│   ├── reports/      # Годовой отчёт + PDF-экспорт (Pro)
│   ├── onboarding/   # Показывается при первом запуске
│   └── settings/     # Валюта, язык, тема, биометрия, Privacy Policy
├── generated/        # Автогенерированные файлы локализации (не редактировать вручную)
├── l10n/             # ARB-файлы для 12 языков (en, ru, uk, de, fr, es, it, pl, pt, tr, ja, ar)
└── shared/           # Shared widgets, providers (databaseProvider, repositoryProviders)
```

## Ключевые паттерны
- **БД**: Drift, все стримы через `.watch()` → `StreamProvider` для реактивности
- **Провайдеры отчётов**: `StreamProvider.family` + `Provider<AsyncValue<YearReport>>`
- **Запуск**: `main.dart` создаёт `AppDatabase`, вызывает `markOverduePayments()`, затем передаёт БД в `ProviderScope` через override
- **Уведомления**: ID платежа = `tenantId.hashCode.abs() % 100000`, ID аренды = то же + 200000
- **Онбординг**: флаг `onboarding_done` в `SharedPreferences` (глобальный `globalPrefs`)
- **Форматирование**: всегда передавать `locale: Localizations.localeOf(context).toString()`
- **PDF**: `PdfLabels` передаётся из `reports_screen.dart` с l10n-строками

## Монетизация
### Free
- 1 объект
- Локальное хранение
- Уведомления (за 3 дня до оплаты — фиксировано)

### Pro ($2.99/мес)
- До 10 объектов
- PDF-отчёты
- Бэкап Google Drive
- Кастомные дни уведомлений (настраивается в Settings)
- CSV/Excel экспорт
- Шаблон договора аренды PDF
- Автоматические повторяющиеся расходы
- Кастомные категории расходов

## Команды
```bash
flutter pub get          # Установка зависимостей
flutter analyze          # Проверка (использовать вместо билда!)
flutter gen-l10n         # Регенерация после изменений ARB
flutter run              # Запуск
flutter build apk        # Android билд (только по явному запросу)
```

## Release signing
- Keystore: `android/app/rentflow.jks`
- Пароли: `android/key.properties` (в .gitignore)
- Alias: `rentflow`, CN=Orbit Ray Studio, C=UA
