// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'نظرة عامة';

  @override
  String get navProperties => 'العقارات';

  @override
  String get navTenants => 'المستأجرون';

  @override
  String get navPayments => 'المدفوعات';

  @override
  String get navExpenses => 'المصروفات';

  @override
  String get navReports => 'التقارير';

  @override
  String get add => 'إضافة';

  @override
  String get save => 'حفظ';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get cancel => 'إلغاء';

  @override
  String get requiredField => 'حقل مطلوب';

  @override
  String get invalidNumber => 'رقم غير صالح';

  @override
  String get select => 'تحديد';

  @override
  String get seeAll => 'الكل';

  @override
  String get tapToStart => 'اضغط على «إضافة» للبدء';

  @override
  String get income => 'الدخل';

  @override
  String get expenses => 'المصروفات';

  @override
  String get netIncome => 'الدخل الصافي';

  @override
  String get addFirstProperty => 'أضف أول عقار لك';

  @override
  String get noActiveTenants => 'لا يوجد مستأجرون نشطون';

  @override
  String overduePaymentsCount(int count) {
    return 'مدفوعات متأخرة: $count';
  }

  @override
  String get requiresAttention => 'يتطلب الانتباه';

  @override
  String get view => 'عرض';

  @override
  String get propertiesTitle => 'العقارات';

  @override
  String get noProperties => 'لا توجد عقارات';

  @override
  String get deletePropertyTitle => 'حذف العقار؟';

  @override
  String deletePropertyMessage(String name) {
    return 'سيتم حذف «$name» بشكل دائم.';
  }

  @override
  String get newProperty => 'عقار جديد';

  @override
  String get editProperty => 'تعديل العقار';

  @override
  String get addProperty => 'إضافة عقار';

  @override
  String get propertyName => 'الاسم';

  @override
  String get propertyNameHint => 'شقة في الشارع الرئيسي';

  @override
  String get propertyAddress => 'العنوان';

  @override
  String get addressHint => 'شارع رئيسي 1، شقة 25';

  @override
  String get propertyType => 'نوع العقار';

  @override
  String get propertyArea => 'المساحة، م²';

  @override
  String get purchasePrice => 'سعر الشراء';

  @override
  String get notes => 'ملاحظات';

  @override
  String get notesHint => 'معلومات إضافية...';

  @override
  String get typeApartment => 'شقة';

  @override
  String get typeHouse => 'منزل';

  @override
  String get typeRoom => 'غرفة';

  @override
  String get tenantsTitle => 'المستأجرون';

  @override
  String get noTenants => 'لا يوجد مستأجرون';

  @override
  String get deleteTenantTitle => 'حذف المستأجر؟';

  @override
  String deleteTenantMessage(String name) {
    return 'سيتم حذف $name.';
  }

  @override
  String get newTenant => 'مستأجر جديد';

  @override
  String get editTenant => 'تعديل المستأجر';

  @override
  String get addTenant => 'إضافة مستأجر';

  @override
  String get personalInfo => 'المعلومات الشخصية';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get phone => 'الهاتف';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'العقار';

  @override
  String get selectProperty => 'اختر العقار';

  @override
  String get leaseTerms => 'شروط الإيجار';

  @override
  String get rentPerMonth => 'الإيجار، /شهر';

  @override
  String get depositLabel => 'الوديعة';

  @override
  String paymentDayPickerLabel(int day) {
    return 'يوم الدفع: $day';
  }

  @override
  String paymentDayValue(int day) {
    return 'اليوم $day';
  }

  @override
  String get leaseStart => 'بداية الإيجار';

  @override
  String get leaseEnd => 'نهاية الإيجار';

  @override
  String get indefinite => 'غير محدد';

  @override
  String get rent => 'إيجار';

  @override
  String get paymentDay => 'يوم الدفع';

  @override
  String get remaining => 'المتبقي';

  @override
  String daysLeft(int n) {
    return '$n يوم';
  }

  @override
  String get expired => 'انتهت الصلاحية';

  @override
  String get paymentsTitle => 'المدفوعات';

  @override
  String get noPayments => 'لا توجد مدفوعات';

  @override
  String get addFirstPayment => 'اضغط على «إضافة» لتسجيل الدفعة الأولى';

  @override
  String get newPayment => 'دفعة جديدة';

  @override
  String get selectTenant => 'اختر المستأجر';

  @override
  String get amount => 'المبلغ';

  @override
  String get status => 'الحالة';

  @override
  String get date => 'التاريخ';

  @override
  String get addPayment => 'إضافة دفعة';

  @override
  String get markAsPaid => 'وضع علامة كمدفوع';

  @override
  String get paymentTypeRent => 'إيجار';

  @override
  String get paymentTypeDeposit => 'وديعة';

  @override
  String get paymentTypeUtility => 'خدمات';

  @override
  String get paymentTypeOther => 'أخرى';

  @override
  String get statusPending => 'معلق';

  @override
  String get statusPaid => 'مدفوع';

  @override
  String get statusOverdue => 'متأخر';

  @override
  String get expensesTitle => 'المصروفات';

  @override
  String get noExpenses => 'لا توجد مصروفات';

  @override
  String get addFirstExpense => 'اضغط على «إضافة» لتسجيل مصروف';

  @override
  String get newExpense => 'مصروف جديد';

  @override
  String get description => 'الوصف';

  @override
  String get descriptionHint => 'إصلاح السباكة';

  @override
  String get addExpense => 'إضافة مصروف';

  @override
  String get categoryRepair => 'إصلاح';

  @override
  String get categoryTax => 'ضريبة';

  @override
  String get categoryInsurance => 'تأمين';

  @override
  String get categoryUtility => 'خدمات';

  @override
  String get categoryManagement => 'إدارة';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get reportsTitle => 'التقارير';

  @override
  String get exportPdf => 'تصدير PDF';

  @override
  String get yearlyIncome => 'الدخل السنوي';

  @override
  String get yearlyExpenses => 'المصروفات السنوية';

  @override
  String get netProfit => 'صافي الربح';

  @override
  String get profit => 'ربح';

  @override
  String get loss => 'خسارة';

  @override
  String get incomeExpensesByMonth => 'الدخل والمصروفات شهرياً';

  @override
  String get noDataForYear => 'لا توجد بيانات لهذا العام';

  @override
  String get byMonth => 'حسب الشهر';

  @override
  String get month => 'الشهر';

  @override
  String get expense => 'مصروف';

  @override
  String get net => 'صافي';

  @override
  String get incomeTooltip => 'دخل';

  @override
  String get expenseTooltip => 'مصروف';

  @override
  String get chartMonthAbbr => 'ي,ف,م,أ,م,ي,ي,أ,س,أ,ن,د';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get appearance => 'المظهر';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get versionLabel => 'الإصدار';

  @override
  String get propertyLimit => 'حد العقارات';

  @override
  String propertyLimitValue(int n) {
    return '$n (مجاني)';
  }

  @override
  String get contactDeveloper => 'تواصل مع المطور';

  @override
  String get rateApp => 'تقييم التطبيق';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get notificationsSection => 'الإشعارات';

  @override
  String get enableNotifications => 'تفعيل الإشعارات';

  @override
  String get permissionRequested => 'تم طلب الإذن';

  @override
  String get dataSection => 'البيانات';

  @override
  String get proSection => 'ميزات Pro';

  @override
  String get backupToGoogleDrive => 'نسخ احتياطي على Google Drive';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get restorePurchasesSuccess => 'تمت استعادة المشتريات';

  @override
  String get restoreFromBackup => 'الاستعادة من النسخة الاحتياطية';

  @override
  String get restoreDataTitle => 'استعادة البيانات؟';

  @override
  String get restoreDataMessage =>
      'ستُستبدل البيانات الحالية ببيانات من Google Drive.';

  @override
  String get restore => 'استعادة';

  @override
  String get googleSignInFailed => 'فشل تسجيل الدخول إلى Google';

  @override
  String get backupSaved => 'تم حفظ النسخة الاحتياطية على Google Drive';

  @override
  String get backupFailed => 'فشل النسخ الاحتياطي';

  @override
  String get dataRestored => 'تمت استعادة البيانات بنجاح';

  @override
  String get backupNotFound => 'النسخة الاحتياطية غير موجودة';

  @override
  String get restartApp => 'إعادة التشغيل';

  @override
  String get theme => 'النمط';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get currency => 'العملة';

  @override
  String get proDescription => 'حتى 20 عقارات وتقارير PDF ونسخ احتياطي سحابي';

  @override
  String get proCta => 'جرب مقابل 6.99\$/شهر';

  @override
  String get perMonth => '/شهر';

  @override
  String get proCtaYearly => 'أو 59.99\$/سنة';

  @override
  String get deleteExpenseTitle => 'حذف المصروف؟';

  @override
  String deleteExpenseMessage(String name) {
    return 'سيتم حذف «$name».';
  }

  @override
  String get biometricSection => 'الأمان';

  @override
  String get enableBiometric => 'فتح بالبصمة';

  @override
  String get proFeatureMessage => 'متاح في النسخة PRO';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get onboarding1Title => 'مرحباً بك في RentFlow';

  @override
  String get onboarding1Body => 'إدارة بسيطة للإيجار للملاك الخاصين';

  @override
  String get onboarding2Title => 'العقارات والمستأجرون';

  @override
  String get onboarding2Body => 'أضف عقاراتك ومستأجريك في ثوانٍ';

  @override
  String get onboarding3Title => 'المدفوعات والتقارير';

  @override
  String get onboarding3Body =>
      'تتبع الدخل والمصروفات والمدفوعات المتأخرة في الوقت الفعلي';

  @override
  String get notificationPaymentTitle => 'تذكير بالدفع';

  @override
  String get notificationLeaseEndTitle => 'عقد الإيجار على وشك الانتهاء';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — ينتهي العقد في $date';
  }

  @override
  String get pdfReportTitlePrefix => 'التقرير المالي لعام';

  @override
  String get pdfSummary => 'ملخص';

  @override
  String get pdfByMonths => 'حسب الشهر';

  @override
  String get pdfNet => 'صافي';

  @override
  String get pdfTotal => 'الإجمالي';

  @override
  String get pdfGeneratedBy => 'تم إنشاؤه في RentFlow';

  @override
  String get paymentHistory => 'سجل المدفوعات';

  @override
  String get totalPaid => 'إجمالي المدفوع';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get allTime => 'كل الوقت';

  @override
  String get search => 'بحث';

  @override
  String get searchHint => 'البحث بالاسم أو الهاتف…';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get propertyDetails => 'تفاصيل العقار';

  @override
  String get recurringExpenses => 'المصروفات المتكررة';

  @override
  String get repeatMonthly => 'تكرار شهري';

  @override
  String get repeatDay => 'يوم من الشهر';

  @override
  String get recurringExpenseHint => 'يُنشأ تلقائيًا كل شهر في هذا اليوم';

  @override
  String get noRecurringExpenses => 'لا توجد مصروفات متكررة';

  @override
  String get addRecurringExpense => 'إضافة قالب';

  @override
  String get proFeatureRecurring => 'المصروفات المتكررة ميزة Pro';

  @override
  String get customCategories => 'فئات مخصصة';

  @override
  String get addCategory => 'إضافة فئة';

  @override
  String get categoryName => 'اسم الفئة';

  @override
  String get yourCategories => 'فئاتك';

  @override
  String get proFeatureCategories => 'الفئات المخصصة ميزة Pro';

  @override
  String get meterReadings => 'قراءات العدادات';

  @override
  String get addReading => 'إضافة قراءة';

  @override
  String get lastReading => 'آخر قراءة';

  @override
  String get consumption => 'الاستهلاك';

  @override
  String get noReadings => 'لا توجد قراءات بعد';

  @override
  String get meterWaterCold => 'ماء بارد';

  @override
  String get meterWaterHot => 'ماء ساخن';

  @override
  String get meterGas => 'الغاز';

  @override
  String get meterElectricity => 'الكهرباء';

  @override
  String get meterHeat => 'التدفئة';

  @override
  String get meterElectricityT1 => 'الكهرباء T1 (نهار)';

  @override
  String get meterElectricityT2 => 'الكهرباء T2 (ليل)';

  @override
  String get meterElectricityT3 => 'كهرباء T3 (مساء)';

  @override
  String get meterHistory => 'سجل القراءات';

  @override
  String get meterPdfTitle => 'تقرير قراءات العداد';

  @override
  String get meterPdfPrevious => 'السابق';

  @override
  String get meterPdfCurrent => 'الحالي';

  @override
  String get meterPdfElecTotal => 'الكهرباء (إجمالي)';

  @override
  String get meterPdfTotalConsumption => 'إجمالي الاستهلاك';

  @override
  String get meterPdfGeneratedBy => 'تم إنشاؤه بواسطة RentFlow';

  @override
  String get customType => 'نوع مخصص';

  @override
  String get editReading => 'تعديل';

  @override
  String get typeName => 'اسم النوع';

  @override
  String get selectPeriod => 'اختر الفترة';

  @override
  String get pdfPeriod => 'الفترة';

  @override
  String get readingValue => 'قيمة العداد';

  @override
  String get notifyDaysBefore => 'تذكير قبل (أيام)';

  @override
  String get exportCsv => 'تصدير CSV';

  @override
  String get csvCopied => 'تم نسخ CSV إلى الحافظة';

  @override
  String get faqTitle => 'المساعدة';

  @override
  String get faqHowToUseTab => 'كيفية الاستخدام';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'البداية';

  @override
  String get faqStep1Title => 'أضف عقاراً';

  @override
  String get faqStep1Body =>
      'اذهب إلى «العقارات» ← «+» وأدخل الاسم والعنوان والنوع.';

  @override
  String get faqStep2Title => 'أضف مستأجراً';

  @override
  String get faqStep2Body =>
      'في «المستأجرون» ← «+» أدخل البيانات واختر العقار وحدد الإيجار ويوم الدفع.';

  @override
  String get faqStep3Title => 'سجّل المدفوعات';

  @override
  String get faqStep3Body =>
      'في «المدفوعات» ← «+» أضف دفعة. اسحب لليمين لوضع علامة مدفوع فوراً.';

  @override
  String get faqStep4Title => 'تتبع المصروفات';

  @override
  String get faqStep4Body =>
      'في «المصروفات» ← «+» أضف تكلفة واربطها بعقار واختر الفئة.';

  @override
  String get faqStep5Title => 'اعرض التقارير';

  @override
  String get faqStep5Body =>
      '«التقارير» تعرض الدخل السنوي والمصروفات وصافي الربح بمخطط وجدول شهري.';

  @override
  String get faqTipsTitle => 'نصائح';

  @override
  String get faqTip1 => 'اسحب الدفعة يميناً لوضع علامة مدفوع دون فتح النموذج.';

  @override
  String get faqTip2 =>
      'انقر على بطاقة المستأجر أو العقار لرؤية التفاصيل والتاريخ.';

  @override
  String get faqTip3 =>
      'انتقل إلى عرض التقويم في المدفوعات لرؤية الدفعات حسب التاريخ.';

  @override
  String get faqProProperties => 'حتى 20 عقارات';

  @override
  String get faqProNotifications => 'جدول إشعارات مخصص';

  @override
  String get faqProRecurring => 'المصاريف المتكررة';

  @override
  String get splashPhrases =>
      'التحكم في الإيجار\nبين يديك|تابع إيجاراتك —\nبكل سهولة وثقة|كل دفعة\nتحت السيطرة|عقاراتك\nدائمًا في متناول يدك|أدر بذكاء أكبر —\nاكسب أكثر|إيجار بلا فوضى|مديرك الشخصي\nللعقارات|اعرف كل شيء\nعن إيجارك|الدخل يتزايد —\nالنفقات تحت السيطرة|الإيجار كعمل تجاري —\nمع RentFlow';
}
