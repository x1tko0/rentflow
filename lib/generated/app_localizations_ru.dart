// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Обзор';

  @override
  String get navProperties => 'Объекты';

  @override
  String get navTenants => 'Жильцы';

  @override
  String get navPayments => 'Платежи';

  @override
  String get navExpenses => 'Расходы';

  @override
  String get navReports => 'Отчёты';

  @override
  String get add => 'Добавить';

  @override
  String get save => 'Сохранить';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Редактировать';

  @override
  String get cancel => 'Отмена';

  @override
  String get requiredField => 'Обязательное поле';

  @override
  String get invalidNumber => 'Неверное число';

  @override
  String get select => 'Выбрать';

  @override
  String get seeAll => 'Все';

  @override
  String get tapToStart => 'Нажмите «Добавить» чтобы начать';

  @override
  String get income => 'Доход';

  @override
  String get expenses => 'Расходы';

  @override
  String get netIncome => 'Чистый доход';

  @override
  String get addFirstProperty => 'Добавьте первый объект';

  @override
  String get noActiveTenants => 'Нет активных арендаторов';

  @override
  String overduePaymentsCount(int count) {
    return 'Просроченных платежей: $count';
  }

  @override
  String get requiresAttention => 'Требует внимания';

  @override
  String get view => 'Просмотр';

  @override
  String get propertiesTitle => 'Объекты';

  @override
  String get noProperties => 'Нет объектов';

  @override
  String get deletePropertyTitle => 'Удалить объект?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» будет удалён без возможности восстановления.';
  }

  @override
  String get newProperty => 'Новый объект';

  @override
  String get editProperty => 'Редактировать объект';

  @override
  String get addProperty => 'Добавить объект';

  @override
  String get propertyName => 'Название';

  @override
  String get propertyNameHint => 'Квартира на Ленина';

  @override
  String get propertyAddress => 'Адрес';

  @override
  String get addressHint => 'ул. Ленина, 1, кв. 25';

  @override
  String get propertyType => 'Тип объекта';

  @override
  String get propertyArea => 'Площадь, м²';

  @override
  String get purchasePrice => 'Цена покупки';

  @override
  String get notes => 'Заметки';

  @override
  String get notesHint => 'Дополнительная информация...';

  @override
  String get typeApartment => 'Квартира';

  @override
  String get typeHouse => 'Дом';

  @override
  String get typeRoom => 'Комната';

  @override
  String get tenantsTitle => 'Арендаторы';

  @override
  String get noTenants => 'Нет арендаторов';

  @override
  String get deleteTenantTitle => 'Удалить арендатора?';

  @override
  String deleteTenantMessage(String name) {
    return '$name будет удалён.';
  }

  @override
  String get newTenant => 'Новый арендатор';

  @override
  String get editTenant => 'Редактировать арендатора';

  @override
  String get addTenant => 'Добавить арендатора';

  @override
  String get personalInfo => 'Личные данные';

  @override
  String get firstName => 'Имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get phone => 'Телефон';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Объект';

  @override
  String get selectProperty => 'Выберите объект';

  @override
  String get leaseTerms => 'Условия аренды';

  @override
  String get rentPerMonth => 'Аренда';

  @override
  String get depositLabel => 'Депозит';

  @override
  String paymentDayPickerLabel(int day) {
    return 'День оплаты: $day-е число';
  }

  @override
  String paymentDayValue(int day) {
    return '$day-е число';
  }

  @override
  String get leaseStart => 'Начало аренды';

  @override
  String get leaseEnd => 'Конец аренды';

  @override
  String get indefinite => 'Бессрочно';

  @override
  String get rent => 'Аренда';

  @override
  String get paymentDay => 'День оплаты';

  @override
  String get remaining => 'Осталось';

  @override
  String daysLeft(int n) {
    return '$n дн.';
  }

  @override
  String get expired => 'Истёк';

  @override
  String get paymentsTitle => 'Платежи';

  @override
  String get noPayments => 'Нет платежей';

  @override
  String get addFirstPayment => 'Нажмите «Добавить» чтобы внести первый платёж';

  @override
  String get newPayment => 'Новый платёж';

  @override
  String get selectTenant => 'Выберите арендатора';

  @override
  String get amount => 'Сумма';

  @override
  String get status => 'Статус';

  @override
  String get date => 'Дата';

  @override
  String get addPayment => 'Добавить платёж';

  @override
  String get markAsPaid => 'Отметить оплаченным';

  @override
  String get paymentTypeRent => 'Аренда';

  @override
  String get paymentTypeDeposit => 'Депозит';

  @override
  String get paymentTypeUtility => 'Коммуналка';

  @override
  String get paymentTypeOther => 'Прочее';

  @override
  String get statusPending => 'Ожидает';

  @override
  String get statusPaid => 'Оплачен';

  @override
  String get statusOverdue => 'Просрочен';

  @override
  String get expensesTitle => 'Расходы';

  @override
  String get noExpenses => 'Нет расходов';

  @override
  String get addFirstExpense => 'Нажмите «Добавить» чтобы внести расход';

  @override
  String get newExpense => 'Новый расход';

  @override
  String get description => 'Описание';

  @override
  String get descriptionHint => 'Замена сантехники';

  @override
  String get addExpense => 'Добавить расход';

  @override
  String get categoryRepair => 'Ремонт';

  @override
  String get categoryTax => 'Налог';

  @override
  String get categoryInsurance => 'Страховка';

  @override
  String get categoryUtility => 'Коммуналка';

  @override
  String get categoryManagement => 'Управление';

  @override
  String get categoryOther => 'Прочее';

  @override
  String get reportsTitle => 'Отчёты';

  @override
  String get exportPdf => 'Экспорт PDF';

  @override
  String get yearlyIncome => 'Доход за год';

  @override
  String get yearlyExpenses => 'Расходы за год';

  @override
  String get netProfit => 'Чистая прибыль';

  @override
  String get profit => 'Прибыль';

  @override
  String get loss => 'Убыток';

  @override
  String get incomeExpensesByMonth => 'Доходы и расходы по месяцам';

  @override
  String get noDataForYear => 'Нет данных за этот год';

  @override
  String get byMonth => 'По месяцам';

  @override
  String get month => 'Месяц';

  @override
  String get expense => 'Расход';

  @override
  String get net => 'Чистый';

  @override
  String get incomeTooltip => 'Доход';

  @override
  String get expenseTooltip => 'Расход';

  @override
  String get chartMonthAbbr => 'Я,Ф,М,А,М,И,И,А,С,О,Н,Д';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get versionLabel => 'Версия';

  @override
  String get propertyLimit => 'Лимит объектов';

  @override
  String propertyLimitValue(int n) {
    return '$n (Free)';
  }

  @override
  String get contactDeveloper => 'Написать разработчику';

  @override
  String get rateApp => 'Оценить приложение';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get notificationsSection => 'Уведомления';

  @override
  String get enableNotifications => 'Разрешить уведомления';

  @override
  String get permissionRequested => 'Разрешение запрошено';

  @override
  String get dataSection => 'Данные';

  @override
  String get backupToGoogleDrive => 'Бэкап в Google Drive';

  @override
  String get restoreFromBackup => 'Восстановить из бэкапа';

  @override
  String get restoreDataTitle => 'Восстановить данные?';

  @override
  String get restoreDataMessage =>
      'Текущие данные будут заменены данными из Google Drive.';

  @override
  String get restore => 'Восстановить';

  @override
  String get googleSignInFailed => 'Не удалось войти в Google';

  @override
  String get backupSaved => 'Бэкап сохранён в Google Drive';

  @override
  String get backupFailed => 'Ошибка при создании бэкапа';

  @override
  String get dataRestored => 'Данные восстановлены. Перезапустите приложение.';

  @override
  String get backupNotFound => 'Бэкап не найден';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get currency => 'Валюта';

  @override
  String get proDescription => 'До 10 объектов, PDF-отчёты и облачный бэкап';

  @override
  String get proCta => 'Попробовать за 2.99\$/мес';

  @override
  String get perMonth => '/мес';

  @override
  String get proCtaYearly => 'или \$24.99/год';

  @override
  String get deleteExpenseTitle => 'Удалить расход?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» будет удалён.';
  }

  @override
  String get biometricSection => 'Безопасность';

  @override
  String get enableBiometric => 'Разблокировка по отпечатку';

  @override
  String get proFeatureMessage => 'Доступно в PRO-версии';

  @override
  String get splashPhrases =>
      'Контроль аренды\nв ваших руках|Следите за арендой —\nпросто и уверенно|Каждый платёж\nпод контролем|Ваши объекты\nвсегда рядом|Управляйте умнее —\nзарабатывайте больше|Аренда без хаоса|Ваш личный менеджер\nнедвижимости|Знайте всё\nо своей аренде|Доходы растут —\nрасходы под контролем|Аренда как бизнес —\nс RentFlow';
}
