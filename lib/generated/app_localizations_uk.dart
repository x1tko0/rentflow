// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Огляд';

  @override
  String get navProperties => 'Об\'єкти';

  @override
  String get navTenants => 'Орендарі';

  @override
  String get navPayments => 'Платежі';

  @override
  String get navExpenses => 'Витрати';

  @override
  String get navReports => 'Звіти';

  @override
  String get add => 'Додати';

  @override
  String get save => 'Зберегти';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String get delete => 'Видалити';

  @override
  String get edit => 'Редагувати';

  @override
  String get cancel => 'Скасувати';

  @override
  String get requiredField => 'Обов\'язкове поле';

  @override
  String get invalidNumber => 'Невірне число';

  @override
  String get select => 'Вибрати';

  @override
  String get seeAll => 'Всі';

  @override
  String get tapToStart => 'Натисніть «Додати», щоб почати';

  @override
  String get income => 'Дохід';

  @override
  String get expenses => 'Витрати';

  @override
  String get netIncome => 'Чистий дохід';

  @override
  String get addFirstProperty => 'Додайте перший об\'єкт';

  @override
  String get noActiveTenants => 'Немає активних орендарів';

  @override
  String overduePaymentsCount(int count) {
    return 'Прострочених платежів: $count';
  }

  @override
  String get requiresAttention => 'Потребує уваги';

  @override
  String get view => 'Перегляд';

  @override
  String get propertiesTitle => 'Об\'єкти';

  @override
  String get noProperties => 'Немає об\'єктів';

  @override
  String get deletePropertyTitle => 'Видалити об\'єкт?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» буде видалено без можливості відновлення.';
  }

  @override
  String get newProperty => 'Новий об\'єкт';

  @override
  String get editProperty => 'Редагувати об\'єкт';

  @override
  String get addProperty => 'Додати об\'єкт';

  @override
  String get propertyName => 'Назва';

  @override
  String get propertyNameHint => 'Квартира на Леніна';

  @override
  String get propertyAddress => 'Адреса';

  @override
  String get addressHint => 'вул. Леніна, 1, кв. 25';

  @override
  String get propertyType => 'Тип об\'єкту';

  @override
  String get propertyArea => 'Площа, м²';

  @override
  String get purchasePrice => 'Ціна покупки';

  @override
  String get notes => 'Нотатки';

  @override
  String get notesHint => 'Додаткова інформація...';

  @override
  String get typeApartment => 'Квартира';

  @override
  String get typeHouse => 'Будинок';

  @override
  String get typeRoom => 'Кімната';

  @override
  String get tenantsTitle => 'Орендарі';

  @override
  String get noTenants => 'Немає орендарів';

  @override
  String get deleteTenantTitle => 'Видалити орендаря?';

  @override
  String deleteTenantMessage(String name) {
    return '$name буде видалено.';
  }

  @override
  String get newTenant => 'Новий орендар';

  @override
  String get editTenant => 'Редагувати орендаря';

  @override
  String get addTenant => 'Додати орендаря';

  @override
  String get personalInfo => 'Особисті дані';

  @override
  String get firstName => 'Ім\'я';

  @override
  String get lastName => 'Прізвище';

  @override
  String get phone => 'Телефон';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Об\'єкт';

  @override
  String get selectProperty => 'Оберіть об\'єкт';

  @override
  String get leaseTerms => 'Умови оренди';

  @override
  String get rentPerMonth => 'Оренда';

  @override
  String get depositLabel => 'Депозит';

  @override
  String paymentDayPickerLabel(int day) {
    return 'День оплати: $day-е число';
  }

  @override
  String paymentDayValue(int day) {
    return '$day-е число';
  }

  @override
  String get leaseStart => 'Початок оренди';

  @override
  String get leaseEnd => 'Кінець оренди';

  @override
  String get indefinite => 'Безстроково';

  @override
  String get rent => 'Оренда';

  @override
  String get paymentDay => 'День оплати';

  @override
  String get remaining => 'Залишилось';

  @override
  String daysLeft(int n) {
    return '$n дн.';
  }

  @override
  String get expired => 'Закінчився';

  @override
  String get paymentsTitle => 'Платежі';

  @override
  String get noPayments => 'Немає платежів';

  @override
  String get addFirstPayment => 'Натисніть «Додати», щоб внести перший платіж';

  @override
  String get newPayment => 'Новий платіж';

  @override
  String get selectTenant => 'Оберіть орендаря';

  @override
  String get amount => 'Сума';

  @override
  String get status => 'Статус';

  @override
  String get date => 'Дата';

  @override
  String get addPayment => 'Додати платіж';

  @override
  String get markAsPaid => 'Відмітити як сплачений';

  @override
  String get paymentTypeRent => 'Оренда';

  @override
  String get paymentTypeDeposit => 'Депозит';

  @override
  String get paymentTypeUtility => 'Комунальні';

  @override
  String get paymentTypeOther => 'Інше';

  @override
  String get statusPending => 'Очікує';

  @override
  String get statusPaid => 'Сплачено';

  @override
  String get statusOverdue => 'Прострочено';

  @override
  String get expensesTitle => 'Витрати';

  @override
  String get noExpenses => 'Немає витрат';

  @override
  String get addFirstExpense => 'Натисніть «Додати», щоб внести витрату';

  @override
  String get newExpense => 'Нова витрата';

  @override
  String get description => 'Опис';

  @override
  String get descriptionHint => 'Заміна сантехніки';

  @override
  String get addExpense => 'Додати витрату';

  @override
  String get categoryRepair => 'Ремонт';

  @override
  String get categoryTax => 'Податок';

  @override
  String get categoryInsurance => 'Страхування';

  @override
  String get categoryUtility => 'Комунальні';

  @override
  String get categoryManagement => 'Управління';

  @override
  String get categoryOther => 'Інше';

  @override
  String get reportsTitle => 'Звіти';

  @override
  String get exportPdf => 'Експорт PDF';

  @override
  String get yearlyIncome => 'Дохід за рік';

  @override
  String get yearlyExpenses => 'Витрати за рік';

  @override
  String get netProfit => 'Чистий прибуток';

  @override
  String get profit => 'Прибуток';

  @override
  String get loss => 'Збиток';

  @override
  String get incomeExpensesByMonth => 'Доходи та витрати по місяцях';

  @override
  String get noDataForYear => 'Немає даних за цей рік';

  @override
  String get byMonth => 'По місяцях';

  @override
  String get month => 'Місяць';

  @override
  String get expense => 'Витрата';

  @override
  String get net => 'Чистий';

  @override
  String get incomeTooltip => 'Дохід';

  @override
  String get expenseTooltip => 'Витрата';

  @override
  String get chartMonthAbbr => 'С,Л,Б,К,Т,Ч,Л,С,В,Ж,Л,Г';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get appearance => 'Зовнішній вигляд';

  @override
  String get aboutApp => 'Про застосунок';

  @override
  String get versionLabel => 'Версія';

  @override
  String get propertyLimit => 'Ліміт об\'єктів';

  @override
  String propertyLimitValue(int n) {
    return '$n (Free)';
  }

  @override
  String get contactDeveloper => 'Написати розробнику';

  @override
  String get rateApp => 'Оцінити застосунок';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get notificationsSection => 'Сповіщення';

  @override
  String get enableNotifications => 'Дозволити сповіщення';

  @override
  String get permissionRequested => 'Дозвіл запитано';

  @override
  String get dataSection => 'Дані';

  @override
  String get backupToGoogleDrive => 'Резервна копія в Google Drive';

  @override
  String get restoreFromBackup => 'Відновити з резервної копії';

  @override
  String get restoreDataTitle => 'Відновити дані?';

  @override
  String get restoreDataMessage =>
      'Поточні дані будуть замінені даними з Google Drive.';

  @override
  String get restore => 'Відновити';

  @override
  String get googleSignInFailed => 'Не вдалося увійти в Google';

  @override
  String get backupSaved => 'Резервну копію збережено в Google Drive';

  @override
  String get backupFailed => 'Помилка при створенні резервної копії';

  @override
  String get dataRestored =>
      'Дані відновлено. Будь ласка, перезапустіть застосунок.';

  @override
  String get backupNotFound => 'Резервну копію не знайдено';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системна';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get currency => 'Валюта';

  @override
  String get proDescription => 'До 10 об\'єктів, PDF-звіти та хмарний бекап';

  @override
  String get proCta => 'Спробувати за 2.99\$/міс';

  @override
  String get perMonth => '/міс';

  @override
  String get proCtaYearly => 'або \$24.99/рік';

  @override
  String get deleteExpenseTitle => 'Видалити витрату?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» буде видалено.';
  }

  @override
  String get biometricSection => 'Безпека';

  @override
  String get enableBiometric => 'Розблокування за відбитком';

  @override
  String get proFeatureMessage => 'Доступно в PRO-версії';

  @override
  String get splashPhrases =>
      'Контроль оренди\nу ваших руках|Стежте за орендою —\nпросто і впевнено|Кожен платіж\nпід контролем|Ваші об\'єкти\nзавжди поруч|Керуйте розумніше —\nзаробляйте більше|Оренда без хаосу|Ваш особистий менеджер\nнерухомості|Знайте все\nпро свою оренду|Доходи зростають —\nвитрати під контролем|Оренда як бізнес —\nз RentFlow';
}
