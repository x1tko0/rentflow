// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Przegląd';

  @override
  String get navProperties => 'Nieruchomości';

  @override
  String get navTenants => 'Najemcy';

  @override
  String get navPayments => 'Płatności';

  @override
  String get navExpenses => 'Wydatki';

  @override
  String get navReports => 'Raporty';

  @override
  String get add => 'Dodaj';

  @override
  String get save => 'Zapisz';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get delete => 'Usuń';

  @override
  String get edit => 'Edytuj';

  @override
  String get cancel => 'Anuluj';

  @override
  String get requiredField => 'Pole wymagane';

  @override
  String get invalidNumber => 'Nieprawidłowa liczba';

  @override
  String get select => 'Wybierz';

  @override
  String get seeAll => 'Wszystko';

  @override
  String get tapToStart => 'Dotknij «Dodaj», aby zacząć';

  @override
  String get income => 'Przychody';

  @override
  String get expenses => 'Wydatki';

  @override
  String get netIncome => 'Dochód netto';

  @override
  String get addFirstProperty => 'Dodaj swoją pierwszą nieruchomość';

  @override
  String get noActiveTenants => 'Brak aktywnych najemców';

  @override
  String overduePaymentsCount(int count) {
    return 'Zaległe płatności: $count';
  }

  @override
  String get requiresAttention => 'Wymaga uwagi';

  @override
  String get view => 'Wyświetl';

  @override
  String get propertiesTitle => 'Nieruchomości';

  @override
  String get noProperties => 'Brak nieruchomości';

  @override
  String get deletePropertyTitle => 'Usunąć nieruchomość?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» zostanie trwale usunięty.';
  }

  @override
  String get newProperty => 'Nowa nieruchomość';

  @override
  String get editProperty => 'Edytuj nieruchomość';

  @override
  String get addProperty => 'Dodaj nieruchomość';

  @override
  String get propertyName => 'Nazwa';

  @override
  String get propertyNameHint => 'Mieszkanie przy ul. Głównej';

  @override
  String get propertyAddress => 'Adres';

  @override
  String get addressHint => 'ul. Główna 1, m. 25';

  @override
  String get propertyType => 'Typ nieruchomości';

  @override
  String get propertyArea => 'Powierzchnia, m²';

  @override
  String get purchasePrice => 'Cena zakupu';

  @override
  String get notes => 'Notatki';

  @override
  String get notesHint => 'Dodatkowe informacje...';

  @override
  String get typeApartment => 'Mieszkanie';

  @override
  String get typeHouse => 'Dom';

  @override
  String get typeRoom => 'Pokój';

  @override
  String get tenantsTitle => 'Najemcy';

  @override
  String get noTenants => 'Brak najemców';

  @override
  String get deleteTenantTitle => 'Usunąć najemcę?';

  @override
  String deleteTenantMessage(String name) {
    return '$name zostanie usunięty.';
  }

  @override
  String get newTenant => 'Nowy najemca';

  @override
  String get editTenant => 'Edytuj najemcę';

  @override
  String get addTenant => 'Dodaj najemcę';

  @override
  String get personalInfo => 'Dane osobowe';

  @override
  String get firstName => 'Imię';

  @override
  String get lastName => 'Nazwisko';

  @override
  String get phone => 'Telefon';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Nieruchomość';

  @override
  String get selectProperty => 'Wybierz nieruchomość';

  @override
  String get leaseTerms => 'Warunki najmu';

  @override
  String get rentPerMonth => 'Czynsz, zł/mies.';

  @override
  String get depositLabel => 'Kaucja';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Dzień płatności: $day';
  }

  @override
  String paymentDayValue(int day) {
    return '$day. dnia';
  }

  @override
  String get leaseStart => 'Początek najmu';

  @override
  String get leaseEnd => 'Koniec najmu';

  @override
  String get indefinite => 'Bezterminowo';

  @override
  String get rent => 'Czynsz';

  @override
  String get paymentDay => 'Dzień płatności';

  @override
  String get remaining => 'Pozostało';

  @override
  String daysLeft(int n) {
    return '$n d.';
  }

  @override
  String get expired => 'Wygasł';

  @override
  String get paymentsTitle => 'Płatności';

  @override
  String get noPayments => 'Brak płatności';

  @override
  String get addFirstPayment => 'Dotknij «Dodaj», aby dodać pierwszą płatność';

  @override
  String get newPayment => 'Nowa płatność';

  @override
  String get selectTenant => 'Wybierz najemcę';

  @override
  String get amount => 'Kwota';

  @override
  String get status => 'Status';

  @override
  String get date => 'Data';

  @override
  String get addPayment => 'Dodaj płatność';

  @override
  String get markAsPaid => 'Oznacz jako zapłacone';

  @override
  String get paymentTypeRent => 'Czynsz';

  @override
  String get paymentTypeDeposit => 'Kaucja';

  @override
  String get paymentTypeUtility => 'Rachunki';

  @override
  String get paymentTypeOther => 'Inne';

  @override
  String get statusPending => 'Oczekujące';

  @override
  String get statusPaid => 'Zapłacone';

  @override
  String get statusOverdue => 'Zaległe';

  @override
  String get expensesTitle => 'Wydatki';

  @override
  String get noExpenses => 'Brak wydatków';

  @override
  String get addFirstExpense => 'Dotknij «Dodaj», aby dodać wydatek';

  @override
  String get newExpense => 'Nowy wydatek';

  @override
  String get description => 'Opis';

  @override
  String get descriptionHint => 'Naprawa instalacji wodnej';

  @override
  String get addExpense => 'Dodaj wydatek';

  @override
  String get categoryRepair => 'Naprawa';

  @override
  String get categoryTax => 'Podatek';

  @override
  String get categoryInsurance => 'Ubezpieczenie';

  @override
  String get categoryUtility => 'Rachunki';

  @override
  String get categoryManagement => 'Zarządzanie';

  @override
  String get categoryOther => 'Inne';

  @override
  String get reportsTitle => 'Raporty';

  @override
  String get exportPdf => 'Eksportuj PDF';

  @override
  String get yearlyIncome => 'Roczne przychody';

  @override
  String get yearlyExpenses => 'Roczne wydatki';

  @override
  String get netProfit => 'Zysk netto';

  @override
  String get profit => 'Zysk';

  @override
  String get loss => 'Strata';

  @override
  String get incomeExpensesByMonth => 'Przychody i wydatki wg miesiąca';

  @override
  String get noDataForYear => 'Brak danych za ten rok';

  @override
  String get byMonth => 'Wg miesiąca';

  @override
  String get month => 'Miesiąc';

  @override
  String get expense => 'Wydatek';

  @override
  String get net => 'Netto';

  @override
  String get incomeTooltip => 'Przychód';

  @override
  String get expenseTooltip => 'Wydatek';

  @override
  String get chartMonthAbbr => 'S,L,M,K,M,C,L,S,W,P,L,G';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get appearance => 'Wygląd';

  @override
  String get aboutApp => 'O aplikacji';

  @override
  String get versionLabel => 'Wersja';

  @override
  String get propertyLimit => 'Limit nieruchomości';

  @override
  String propertyLimitValue(int n) {
    return '$n (Darmowy)';
  }

  @override
  String get contactDeveloper => 'Skontaktuj się z deweloperem';

  @override
  String get rateApp => 'Oceń aplikację';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get notificationsSection => 'Powiadomienia';

  @override
  String get enableNotifications => 'Włącz powiadomienia';

  @override
  String get permissionRequested => 'Uprawnienie zażądane';

  @override
  String get dataSection => 'Dane';

  @override
  String get backupToGoogleDrive => 'Kopia zapasowa na Dysk Google';

  @override
  String get restoreFromBackup => 'Przywróć z kopii zapasowej';

  @override
  String get restoreDataTitle => 'Przywrócić dane?';

  @override
  String get restoreDataMessage =>
      'Bieżące dane zostaną zastąpione danymi z Dysku Google.';

  @override
  String get restore => 'Przywróć';

  @override
  String get googleSignInFailed => 'Nie udało się zalogować do Google';

  @override
  String get backupSaved => 'Kopia zapasowa zapisana na Dysku Google';

  @override
  String get backupFailed => 'Tworzenie kopii zapasowej nie powiodło się';

  @override
  String get dataRestored => 'Dane przywrócone. Uruchom ponownie aplikację.';

  @override
  String get backupNotFound => 'Kopia zapasowa nie znaleziona';

  @override
  String get theme => 'Motyw';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get currency => 'Waluta';

  @override
  String get proDescription =>
      'Do 10 nieruchomości, raporty PDF i kopia w chmurze';

  @override
  String get proCta => 'Wypróbuj za 2,99 \$/mies.';

  @override
  String get perMonth => '/mies.';

  @override
  String get proCtaYearly => 'lub 24,99 \$/rok';

  @override
  String get deleteExpenseTitle => 'Usuń wydatek?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» zostanie usunięty.';
  }

  @override
  String get biometricSection => 'Bezpieczeństwo';

  @override
  String get enableBiometric => 'Odblokuj odciskiem palca';

  @override
  String get proFeatureMessage => 'Dostępne w wersji PRO';

  @override
  String get splashPhrases =>
      'Kontrola wynajmu\nw Twoich rękach|Śledź swój wynajem —\nprosto i pewnie|Każda płatność\npod kontrolą|Twoje nieruchomości\nzawsze pod ręką|Zarządzaj mądrzej —\nzarabiaj więcej|Wynajem bez chaosu|Twój osobisty menedżer\nnieruchomości|Wiedz wszystko\no swoim wynajmie|Dochody rosną —\nwydatki pod kontrolą|Wynajem jak biznes —\nz RentFlow';
}
