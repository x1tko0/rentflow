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
  String get proSection => 'Pro-функции';

  @override
  String get backupToGoogleDrive => 'Бэкап в Google Drive';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get restorePurchasesSuccess => 'Покупки восстановлены';

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
  String get dataRestored => 'Данные успешно восстановлены';

  @override
  String get backupNotFound => 'Бэкап не найден';

  @override
  String get restartApp => 'Перезапустить';

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
  String get proDescription => 'До 20 объектов, PDF-отчёты и облачный бэкап';

  @override
  String get proCta => 'Попробовать за 6.99\$/мес';

  @override
  String get perMonth => '/мес';

  @override
  String get proCtaYearly => 'или \$59.99/год';

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
  String get onboardingSkip => 'Пропустить';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get onboarding1Title => 'Добро пожаловать в RentFlow';

  @override
  String get onboarding1Body =>
      'Простое управление арендой для частных арендодателей';

  @override
  String get onboarding2Title => 'Объекты и арендаторы';

  @override
  String get onboarding2Body =>
      'Добавляйте объекты и арендаторов за считанные секунды';

  @override
  String get onboarding3Title => 'Платежи и отчёты';

  @override
  String get onboarding3Body =>
      'Отслеживайте доходы, расходы и просрочки в реальном времени';

  @override
  String get notificationPaymentTitle => 'Напоминание об оплате';

  @override
  String get notificationLeaseEndTitle => 'Аренда заканчивается';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — аренда заканчивается $date';
  }

  @override
  String get pdfReportTitlePrefix => 'Финансовый отчёт за';

  @override
  String get pdfSummary => 'Сводка';

  @override
  String get pdfByMonths => 'По месяцам';

  @override
  String get pdfNet => 'Чистый';

  @override
  String get pdfTotal => 'Итого';

  @override
  String get pdfGeneratedBy => 'Сформировано в RentFlow';

  @override
  String get paymentHistory => 'История платежей';

  @override
  String get totalPaid => 'Всего оплачено';

  @override
  String get thisMonth => 'Этот месяц';

  @override
  String get allTime => 'За всё время';

  @override
  String get search => 'Поиск';

  @override
  String get searchHint => 'Поиск по имени или телефону…';

  @override
  String get noResults => 'Ничего не найдено';

  @override
  String get propertyDetails => 'Детали объекта';

  @override
  String get recurringExpenses => 'Повторяющиеся расходы';

  @override
  String get repeatMonthly => 'Повторять ежемесячно';

  @override
  String get repeatDay => 'День месяца';

  @override
  String get recurringExpenseHint =>
      'Создаётся автоматически каждый месяц в этот день';

  @override
  String get noRecurringExpenses => 'Нет повторяющихся расходов';

  @override
  String get addRecurringExpense => 'Добавить шаблон';

  @override
  String get proFeatureRecurring => 'Повторяющиеся расходы — функция Pro';

  @override
  String get customCategories => 'Свои категории';

  @override
  String get addCategory => 'Добавить категорию';

  @override
  String get categoryName => 'Название категории';

  @override
  String get yourCategories => 'Ваши категории';

  @override
  String get proFeatureCategories => 'Свои категории — функция Pro';

  @override
  String get meterReadings => 'Показания счётчиков';

  @override
  String get addReading => 'Добавить показание';

  @override
  String get lastReading => 'Последнее показание';

  @override
  String get consumption => 'Расход';

  @override
  String get noReadings => 'Показаний пока нет';

  @override
  String get meterWaterCold => 'Холодная вода';

  @override
  String get meterWaterHot => 'Горячая вода';

  @override
  String get meterGas => 'Газ';

  @override
  String get meterElectricity => 'Электричество';

  @override
  String get meterHeat => 'Тепло';

  @override
  String get meterElectricityT1 => 'Электричество Т1 (День)';

  @override
  String get meterElectricityT2 => 'Электричество Т2 (Ночь)';

  @override
  String get meterElectricityT3 => 'Электричество Т3 (Вечер)';

  @override
  String get meterHistory => 'История показаний';

  @override
  String get meterPdfTitle => 'Отчёт показаний счётчиков';

  @override
  String get meterPdfPrevious => 'Предыдущее';

  @override
  String get meterPdfCurrent => 'Текущее';

  @override
  String get meterPdfElecTotal => 'Электричество (общее)';

  @override
  String get meterPdfTotalConsumption => 'Итого расход';

  @override
  String get meterPdfGeneratedBy => 'Сформировано RentFlow';

  @override
  String get customType => 'Свой тип';

  @override
  String get editReading => 'Редактировать';

  @override
  String get typeName => 'Название типа';

  @override
  String get selectPeriod => 'Выберите период';

  @override
  String get pdfPeriod => 'Период';

  @override
  String get readingValue => 'Показание счётчика';

  @override
  String get notifyDaysBefore => 'Напомнить за (дней)';

  @override
  String get exportCsv => 'Экспорт CSV';

  @override
  String get csvCopied => 'CSV скопирован в буфер';

  @override
  String get faqTitle => 'Помощь';

  @override
  String get faqHowToUseTab => 'Как пользоваться';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Первые шаги';

  @override
  String get faqStep1Title => 'Добавьте объект';

  @override
  String get faqStep1Body =>
      'Перейдите в «Объекты» → «+», заполните название, адрес и тип.';

  @override
  String get faqStep2Title => 'Добавьте арендатора';

  @override
  String get faqStep2Body =>
      'В «Арендаторы» → «+» введите данные, выберите объект, укажите аренду и день оплаты.';

  @override
  String get faqStep3Title => 'Фиксируйте платежи';

  @override
  String get faqStep3Body =>
      'В «Платежи» → «+» добавьте платёж. Проведите вправо по строке, чтобы отметить как оплачено.';

  @override
  String get faqStep4Title => 'Учитывайте расходы';

  @override
  String get faqStep4Body =>
      'В «Расходы» → «+» добавьте затрату, привяжите к объекту и выберите категорию.';

  @override
  String get faqStep5Title => 'Читайте отчёты';

  @override
  String get faqStep5Body =>
      '«Отчёты» показывают годовой доход, расходы и прибыль с графиком и таблицей.';

  @override
  String get faqTipsTitle => 'Советы';

  @override
  String get faqTip1 =>
      'Проведите вправо по платежу, чтобы быстро отметить его как оплачен.';

  @override
  String get faqTip2 =>
      'Нажмите на карточку арендатора или объекта, чтобы увидеть историю.';

  @override
  String get faqTip3 =>
      'Переключитесь на вид календаря в «Платежах», чтобы видеть платежи по датам.';

  @override
  String get faqProProperties => 'До 20 объектов';

  @override
  String get faqProNotifications => 'Настраиваемые уведомления';

  @override
  String get faqProRecurring => 'Регулярные расходы';

  @override
  String get splashPhrases =>
      'Контроль аренды\nв ваших руках|Следите за арендой —\nпросто и уверенно|Каждый платёж\nпод контролем|Ваши объекты\nвсегда рядом|Управляйте умнее —\nзарабатывайте больше|Аренда без хаоса|Ваш личный менеджер\nнедвижимости|Знайте всё\nо своей аренде|Доходы растут —\nрасходы под контролем|Аренда как бизнес —\nс RentFlow';
}
