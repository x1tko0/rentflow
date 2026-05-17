# RentFlow

Менеджер аренды для частных арендодателей (1–5 квартир).

## Стек
- Flutter 3.x (iOS, Android, Web)
- Riverpod (state management)
- Drift (SQLite)
- GoRouter (навигация)
- Supabase (бэкенд для Pro)

## Структура
```
lib/
├── app/           # App config, router
├── core/          # Theme, constants, utils
├── data/          # Database, repositories, models
├── features/      # Feature modules (properties, tenants, payments, etc.)
└── shared/        # Shared widgets, providers
```

## Команды
```bash
flutter pub get          # Установка зависимостей
flutter run              # Запуск
flutter build apk        # Android билд
flutter test             # Тесты
```

## Монетизация
- Free: 1 объект, локальное хранение
- Pro ($2.99/мес): до 10 объектов, облако, PDF-отчёты
