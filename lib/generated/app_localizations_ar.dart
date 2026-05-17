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
  String get backupToGoogleDrive => 'نسخ احتياطي على Google Drive';

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
  String get dataRestored => 'تمت استعادة البيانات. يرجى إعادة تشغيل التطبيق.';

  @override
  String get backupNotFound => 'النسخة الاحتياطية غير موجودة';

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
  String get proDescription => 'حتى 10 عقارات وتقارير PDF ونسخ احتياطي سحابي';

  @override
  String get proCta => 'جرب مقابل 2.99\$/شهر';

  @override
  String get perMonth => '/شهر';

  @override
  String get proCtaYearly => 'أو 24.99\$/سنة';

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
  String get splashPhrases =>
      'التحكم في الإيجار\nبين يديك|تابع إيجاراتك —\nبكل سهولة وثقة|كل دفعة\nتحت السيطرة|عقاراتك\nدائمًا في متناول يدك|أدر بذكاء أكبر —\nاكسب أكثر|إيجار بلا فوضى|مديرك الشخصي\nللعقارات|اعرف كل شيء\nعن إيجارك|الدخل يتزايد —\nالنفقات تحت السيطرة|الإيجار كعمل تجاري —\nمع RentFlow';
}
