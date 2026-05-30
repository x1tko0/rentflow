// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Genel Bakış';

  @override
  String get navProperties => 'Mülkler';

  @override
  String get navTenants => 'Kiracılar';

  @override
  String get navPayments => 'Ödemeler';

  @override
  String get navExpenses => 'Giderler';

  @override
  String get navReports => 'Raporlar';

  @override
  String get add => 'Ekle';

  @override
  String get save => 'Kaydet';

  @override
  String get saveChanges => 'Değişiklikleri kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get cancel => 'İptal';

  @override
  String get requiredField => 'Zorunlu alan';

  @override
  String get invalidNumber => 'Geçersiz sayı';

  @override
  String get select => 'Seç';

  @override
  String get seeAll => 'Tümü';

  @override
  String get tapToStart => 'Başlamak için «Ekle»ye dokunun';

  @override
  String get income => 'Gelir';

  @override
  String get expenses => 'Giderler';

  @override
  String get netIncome => 'Net gelir';

  @override
  String get addFirstProperty => 'İlk mülkünüzü ekleyin';

  @override
  String get noActiveTenants => 'Aktif kiracı yok';

  @override
  String overduePaymentsCount(int count) {
    return 'Gecikmiş ödemeler: $count';
  }

  @override
  String get requiresAttention => 'Dikkat gerektirir';

  @override
  String get view => 'Görüntüle';

  @override
  String get propertiesTitle => 'Mülkler';

  @override
  String get noProperties => 'Mülk yok';

  @override
  String get deletePropertyTitle => 'Mülk silinsin mi?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» kalıcı olarak silinecek.';
  }

  @override
  String get newProperty => 'Yeni mülk';

  @override
  String get editProperty => 'Mülkü düzenle';

  @override
  String get addProperty => 'Mülk ekle';

  @override
  String get propertyName => 'Ad';

  @override
  String get propertyNameHint => 'Ana Sokak\'taki Daire';

  @override
  String get propertyAddress => 'Adres';

  @override
  String get addressHint => 'Ana Sokak 1, daire 25';

  @override
  String get propertyType => 'Mülk türü';

  @override
  String get propertyArea => 'Alan, m²';

  @override
  String get purchasePrice => 'Satın alma fiyatı';

  @override
  String get notes => 'Notlar';

  @override
  String get notesHint => 'Ek bilgi...';

  @override
  String get typeApartment => 'Daire';

  @override
  String get typeHouse => 'Ev';

  @override
  String get typeRoom => 'Oda';

  @override
  String get tenantsTitle => 'Kiracılar';

  @override
  String get noTenants => 'Kiracı yok';

  @override
  String get deleteTenantTitle => 'Kiracı silinsin mi?';

  @override
  String deleteTenantMessage(String name) {
    return '$name silinecek.';
  }

  @override
  String get newTenant => 'Yeni kiracı';

  @override
  String get editTenant => 'Kiracıyı düzenle';

  @override
  String get addTenant => 'Kiracı ekle';

  @override
  String get personalInfo => 'Kişisel bilgiler';

  @override
  String get firstName => 'Ad';

  @override
  String get lastName => 'Soyad';

  @override
  String get phone => 'Telefon';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Mülk';

  @override
  String get selectProperty => 'Mülk seç';

  @override
  String get leaseTerms => 'Kira koşulları';

  @override
  String get rentPerMonth => 'Kira, /ay';

  @override
  String get depositLabel => 'Depozit';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Ödeme günü: $day';
  }

  @override
  String paymentDayValue(int day) {
    return '$day. gün';
  }

  @override
  String get leaseStart => 'Kira başlangıcı';

  @override
  String get leaseEnd => 'Kira bitişi';

  @override
  String get indefinite => 'Süresiz';

  @override
  String get rent => 'Kira';

  @override
  String get paymentDay => 'Ödeme günü';

  @override
  String get remaining => 'Kalan';

  @override
  String daysLeft(int n) {
    return '$n g.';
  }

  @override
  String get expired => 'Süresi doldu';

  @override
  String get paymentsTitle => 'Ödemeler';

  @override
  String get noPayments => 'Ödeme yok';

  @override
  String get addFirstPayment => 'İlk ödemeyi kaydetmek için «Ekle»ye dokunun';

  @override
  String get newPayment => 'Yeni ödeme';

  @override
  String get selectTenant => 'Kiracı seç';

  @override
  String get amount => 'Tutar';

  @override
  String get status => 'Durum';

  @override
  String get date => 'Tarih';

  @override
  String get addPayment => 'Ödeme ekle';

  @override
  String get markAsPaid => 'Ödendi olarak işaretle';

  @override
  String get paymentTypeRent => 'Kira';

  @override
  String get paymentTypeDeposit => 'Depozit';

  @override
  String get paymentTypeUtility => 'Faturalar';

  @override
  String get paymentTypeOther => 'Diğer';

  @override
  String get statusPending => 'Beklemede';

  @override
  String get statusPaid => 'Ödendi';

  @override
  String get statusOverdue => 'Gecikmiş';

  @override
  String get expensesTitle => 'Giderler';

  @override
  String get noExpenses => 'Gider yok';

  @override
  String get addFirstExpense => 'Bir gider kaydetmek için «Ekle»ye dokunun';

  @override
  String get newExpense => 'Yeni gider';

  @override
  String get description => 'Açıklama';

  @override
  String get descriptionHint => 'Tesisat tamiri';

  @override
  String get addExpense => 'Gider ekle';

  @override
  String get categoryRepair => 'Tamir';

  @override
  String get categoryTax => 'Vergi';

  @override
  String get categoryInsurance => 'Sigorta';

  @override
  String get categoryUtility => 'Faturalar';

  @override
  String get categoryManagement => 'Yönetim';

  @override
  String get categoryOther => 'Diğer';

  @override
  String get reportsTitle => 'Raporlar';

  @override
  String get exportPdf => 'PDF dışa aktar';

  @override
  String get yearlyIncome => 'Yıllık gelir';

  @override
  String get yearlyExpenses => 'Yıllık giderler';

  @override
  String get netProfit => 'Net kâr';

  @override
  String get profit => 'Kâr';

  @override
  String get loss => 'Zarar';

  @override
  String get incomeExpensesByMonth => 'Aylık gelir ve giderler';

  @override
  String get noDataForYear => 'Bu yıl için veri yok';

  @override
  String get byMonth => 'Aya göre';

  @override
  String get month => 'Ay';

  @override
  String get expense => 'Gider';

  @override
  String get net => 'Net';

  @override
  String get incomeTooltip => 'Gelir';

  @override
  String get expenseTooltip => 'Gider';

  @override
  String get chartMonthAbbr => 'O,Ş,M,N,M,H,T,A,E,E,K,A';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get appearance => 'Görünüm';

  @override
  String get aboutApp => 'Hakkında';

  @override
  String get versionLabel => 'Sürüm';

  @override
  String get propertyLimit => 'Mülk limiti';

  @override
  String propertyLimitValue(int n) {
    return '$n (Ücretsiz)';
  }

  @override
  String get contactDeveloper => 'Geliştiriciye yaz';

  @override
  String get rateApp => 'Uygulamayı oyla';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get notificationsSection => 'Bildirimler';

  @override
  String get enableNotifications => 'Bildirimleri etkinleştir';

  @override
  String get permissionRequested => 'İzin istendi';

  @override
  String get dataSection => 'Veriler';

  @override
  String get proSection => 'Pro Özellikleri';

  @override
  String get backupToGoogleDrive => 'Google Drive\'a yedekle';

  @override
  String get restorePurchases => 'Satın alımları geri yükle';

  @override
  String get restorePurchasesSuccess => 'Satın alımlar geri yüklendi';

  @override
  String get restoreFromBackup => 'Yedekten geri yükle';

  @override
  String get restoreDataTitle => 'Verileri geri yükle?';

  @override
  String get restoreDataMessage =>
      'Mevcut veriler Google Drive\'daki verilerle değiştirilecek.';

  @override
  String get restore => 'Geri yükle';

  @override
  String get googleSignInFailed => 'Google\'a giriş başarısız';

  @override
  String get backupSaved => 'Yedek Google Drive\'a kaydedildi';

  @override
  String get backupFailed => 'Yedekleme başarısız';

  @override
  String get dataRestored => 'Veriler başarıyla geri yüklendi';

  @override
  String get backupNotFound => 'Yedek bulunamadı';

  @override
  String get restartApp => 'Yeniden başlat';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get currency => 'Para birimi';

  @override
  String get proDescription =>
      '20\'ye kadar mülk, PDF raporlar ve bulut yedekleme';

  @override
  String get proCta => '6,99 \$/ay deneyebilirsin';

  @override
  String get perMonth => '/ay';

  @override
  String get proCtaYearly => 'veya 59,99 \$/yıl';

  @override
  String get deleteExpenseTitle => 'Gideri sil?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» silinecek.';
  }

  @override
  String get biometricSection => 'Güvenlik';

  @override
  String get enableBiometric => 'Parmak izi ile aç';

  @override
  String get proFeatureMessage => 'PRO sürümde mevcut';

  @override
  String get onboardingSkip => 'Geç';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingStart => 'Başla';

  @override
  String get onboarding1Title => 'RentFlow\'a Hoş Geldiniz';

  @override
  String get onboarding1Body =>
      'Özel ev sahipleri için basit kiralama yönetimi';

  @override
  String get onboarding2Title => 'Mülkler & Kiracılar';

  @override
  String get onboarding2Body =>
      'Mülklerinizi ve kiracılarınızı saniyeler içinde ekleyin';

  @override
  String get onboarding3Title => 'Ödemeler & Raporlar';

  @override
  String get onboarding3Body =>
      'Gelir, gider ve gecikmiş ödemeleri gerçek zamanlı takip edin';

  @override
  String get notificationPaymentTitle => 'Ödeme hatırlatması';

  @override
  String get notificationLeaseEndTitle => 'Kira sözleşmesi bitiyor';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — kira $date tarihinde bitiyor';
  }

  @override
  String get pdfReportTitlePrefix => 'Finansal Rapor';

  @override
  String get pdfSummary => 'Özet';

  @override
  String get pdfByMonths => 'Aylara göre';

  @override
  String get pdfNet => 'Net';

  @override
  String get pdfTotal => 'Toplam';

  @override
  String get pdfGeneratedBy => 'RentFlow ile oluşturuldu';

  @override
  String get paymentHistory => 'Ödeme geçmişi';

  @override
  String get totalPaid => 'Toplam ödenen';

  @override
  String get thisMonth => 'Bu ay';

  @override
  String get allTime => 'Tüm zamanlar';

  @override
  String get search => 'Ara';

  @override
  String get searchHint => 'İsim veya telefona göre ara…';

  @override
  String get noResults => 'Sonuç bulunamadı';

  @override
  String get propertyDetails => 'Mülk detayları';

  @override
  String get recurringExpenses => 'Tekrarlayan giderler';

  @override
  String get repeatMonthly => 'Aylık tekrarla';

  @override
  String get repeatDay => 'Ayın günü';

  @override
  String get recurringExpenseHint => 'Her ay bu günde otomatik oluşturulur';

  @override
  String get noRecurringExpenses => 'Tekrarlayan gider yok';

  @override
  String get addRecurringExpense => 'Şablon ekle';

  @override
  String get proFeatureRecurring => 'Tekrarlayan giderler Pro özelliğidir';

  @override
  String get customCategories => 'Özel kategoriler';

  @override
  String get addCategory => 'Kategori ekle';

  @override
  String get categoryName => 'Kategori adı';

  @override
  String get yourCategories => 'Kategorileriniz';

  @override
  String get proFeatureCategories => 'Özel kategoriler Pro özelliğidir';

  @override
  String get meterReadings => 'Sayaç okumaları';

  @override
  String get addReading => 'Okuma ekle';

  @override
  String get lastReading => 'Son okuma';

  @override
  String get consumption => 'Tüketim';

  @override
  String get noReadings => 'Henüz okuma yok';

  @override
  String get meterWaterCold => 'Soğuk su';

  @override
  String get meterWaterHot => 'Sıcak su';

  @override
  String get meterGas => 'Gaz';

  @override
  String get meterElectricity => 'Elektrik';

  @override
  String get meterHeat => 'Isıtma';

  @override
  String get meterElectricityT1 => 'Elektrik T1 (Gündüz)';

  @override
  String get meterElectricityT2 => 'Elektrik T2 (Gece)';

  @override
  String get meterElectricityT3 => 'Elektrik T3 (Akşam)';

  @override
  String get meterHistory => 'Okuma geçmişi';

  @override
  String get meterPdfTitle => 'Sayaç Okuma Raporu';

  @override
  String get meterPdfPrevious => 'Önceki';

  @override
  String get meterPdfCurrent => 'Mevcut';

  @override
  String get meterPdfElecTotal => 'Elektrik (toplam)';

  @override
  String get meterPdfTotalConsumption => 'Toplam tüketim';

  @override
  String get meterPdfGeneratedBy => 'RentFlow tarafından oluşturuldu';

  @override
  String get customType => 'Özel tür';

  @override
  String get editReading => 'Düzenle';

  @override
  String get typeName => 'Tür adı';

  @override
  String get selectPeriod => 'Dönem seç';

  @override
  String get pdfPeriod => 'Dönem';

  @override
  String get readingValue => 'Sayaç değeri';

  @override
  String get notifyDaysBefore => 'Hatırlatma önce (gün)';

  @override
  String get exportCsv => 'CSV dışa aktar';

  @override
  String get csvCopied => 'CSV panoya kopyalandı';

  @override
  String get faqTitle => 'SSS & Yardım';

  @override
  String get faqHowToUseTab => 'Nasıl kullanılır';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Başlarken';

  @override
  String get faqStep1Title => 'Mülk ekle';

  @override
  String get faqStep1Body =>
      '«Mülkler» → «+» gidin ve ad, adres ve türü girin.';

  @override
  String get faqStep2Title => 'Kiracı ekle';

  @override
  String get faqStep2Body =>
      '«Kiracılar» → «+» bölümünde bilgileri girin, mülkü seçin, kira ve ödeme gününü ayarlayın.';

  @override
  String get faqStep3Title => 'Ödemeleri kaydet';

  @override
  String get faqStep3Body =>
      '«Ödemeler» → «+» ile ödeme ekleyin. Ödendi olarak işaretlemek için sağa kaydırın.';

  @override
  String get faqStep4Title => 'Giderleri takip et';

  @override
  String get faqStep4Body =>
      '«Giderler» → «+» ile maliyet ekleyin, mülke bağlayın ve kategori seçin.';

  @override
  String get faqStep5Title => 'Raporları görüntüle';

  @override
  String get faqStep5Body =>
      '«Raporlar» yıllık gelir, giderler ve net kârı grafik ve aylık tablo ile gösterir.';

  @override
  String get faqTipsTitle => 'İpuçları';

  @override
  String get faqTip1 =>
      'Ödemeyi formu açmadan ödenmiş olarak işaretlemek için sağa kaydırın.';

  @override
  String get faqTip2 =>
      'Detayları ve geçmişi görmek için kiracı veya mülk kartına dokunun.';

  @override
  String get faqTip3 =>
      'Ödemeleri tarihe göre görmek için Ödemeler\'de takvim görünümüne geçin.';

  @override
  String get faqProProperties => '20 adede kadar mülk';

  @override
  String get faqProNotifications => 'Özel bildirim takvimi';

  @override
  String get faqProRecurring => 'Tekrarlayan giderler';

  @override
  String get splashPhrases =>
      'Kira yönetimi\nellerinizde|Kira takibinizi yapın —\nkolay ve güvenle|Her ödeme\nkontrol altında|Mülkleriniz\nher zaman yanınızda|Daha akıllı yönetin —\ndaha fazla kazanın|Kiralama kargaşasız|Kişisel\ngayrimenkul yöneticiniz|Kiralama hakkında\nher şeyi bilin|Gelirler artıyor —\ngiderler kontrol altında|Kiralama bir iş gibi —\nRentFlow ile';
}
