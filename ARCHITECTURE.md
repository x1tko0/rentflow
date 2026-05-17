# RentFlow — Архитектура

## Обзор
Кроссплатформенное Flutter-приложение для мелких арендодателей (1–5 квартир).

## Технологический стек

### Frontend
- **Flutter 3.x** — iOS, Android, Web
- **Riverpod** — state management
- **GoRouter** — навигация
- **Drift** — локальная SQLite БД
- **FL Chart** — графики доходов/расходов

### Backend (опционально, для синхронизации)
- **Supabase** — auth, PostgreSQL, realtime sync
- Либо **Firebase** как альтернатива

### Локальное хранение (offline-first)
- SQLite через Drift
- Синхронизация при наличии сети

## Структура проект

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── extensions/
├── data/
│   ├── database/
│   │   ├── app_database.dart
│   │   └── tables/
│   ├── repositories/
│   └── models/
├── features/
│   ├── auth/
│   ├── properties/        # Объекты недвижимости
│   ├── tenants/           # Арендаторы
│   ├── payments/          # Платежи
│   ├── expenses/          # Расходы/ремонт
│   ├── reports/           # Налоговые отчёты
│   ├── dashboard/         # Главный экран
│   └── settings/
└── shared/
    ├── widgets/
    └── providers/
```

## Модель данных

### Property (Объект)
```dart
- id: UUID
- name: String
- address: String
- type: enum (apartment, house, room)
- area: double (м²)
- purchasePrice: double?
- purchaseDate: DateTime?
- notes: String?
- createdAt: DateTime
```

### Tenant (Арендатор)
```dart
- id: UUID
- propertyId: UUID (FK)
- firstName: String
- lastName: String
- phone: String
- email: String?
- leaseStart: DateTime
- leaseEnd: DateTime?
- rentAmount: double
- paymentDay: int (1-31)
- depositAmount: double?
- isActive: bool
- notes: String?
```

### Payment (Платёж)
```dart
- id: UUID
- tenantId: UUID (FK)
- propertyId: UUID (FK)
- amount: double
- date: DateTime
- type: enum (rent, deposit, utility, other)
- status: enum (pending, paid, overdue)
- notes: String?
```

### Expense (Расход)
```dart
- id: UUID
- propertyId: UUID (FK)
- amount: double
- date: DateTime
- category: enum (repair, tax, insurance, utility, management, other)
- description: String
- receiptPath: String? (фото чека)
```

## Экраны приложения

1. **Dashboard** — сводка: доход за месяц, просроченные платежи, ближайшие события
2. **Properties** — список объектов + CRUD
3. **Property Detail** — инфо об объекте, текущий арендатор, история
4. **Tenants** — все арендаторы
5. **Payments** — календарь/список платежей
6. **Expenses** — расходы по категориям
7. **Reports** — годовой отчёт для налоговой (PDF export)
8. **Settings** — профиль, валюта, бэкап, Pro-подписка

## Монетизация

### Free
- 1 объект
- Все базовые функции
- Локальное хранение

### Pro ($2.99/мес или $24.99/год)
- До 10 объектов
- Облачная синхронизация
- Экспорт PDF-отчётов
- Напоминания push

## Безопасность
- Данные шифруются локально (flutter_secure_storage)
- Biometric auth опционально
- Бэкап в iCloud/Google Drive (зашифрованный)
