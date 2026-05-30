// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Übersicht';

  @override
  String get navProperties => 'Objekte';

  @override
  String get navTenants => 'Mieter';

  @override
  String get navPayments => 'Zahlungen';

  @override
  String get navExpenses => 'Ausgaben';

  @override
  String get navReports => 'Berichte';

  @override
  String get add => 'Hinzufügen';

  @override
  String get save => 'Speichern';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get requiredField => 'Pflichtfeld';

  @override
  String get invalidNumber => 'Ungültige Zahl';

  @override
  String get select => 'Auswählen';

  @override
  String get seeAll => 'Alle';

  @override
  String get tapToStart => 'Tippen Sie auf «Hinzufügen», um zu beginnen';

  @override
  String get income => 'Einnahmen';

  @override
  String get expenses => 'Ausgaben';

  @override
  String get netIncome => 'Nettoeinkommen';

  @override
  String get addFirstProperty => 'Fügen Sie Ihr erstes Objekt hinzu';

  @override
  String get noActiveTenants => 'Keine aktiven Mieter';

  @override
  String overduePaymentsCount(int count) {
    return 'Überfällige Zahlungen: $count';
  }

  @override
  String get requiresAttention => 'Erfordert Aufmerksamkeit';

  @override
  String get view => 'Anzeigen';

  @override
  String get propertiesTitle => 'Objekte';

  @override
  String get noProperties => 'Keine Objekte';

  @override
  String get deletePropertyTitle => 'Objekt löschen?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» wird endgültig gelöscht.';
  }

  @override
  String get newProperty => 'Neues Objekt';

  @override
  String get editProperty => 'Objekt bearbeiten';

  @override
  String get addProperty => 'Objekt hinzufügen';

  @override
  String get propertyName => 'Name';

  @override
  String get propertyNameHint => 'Wohnung in der Hauptstraße';

  @override
  String get propertyAddress => 'Adresse';

  @override
  String get addressHint => 'Hauptstr. 1, Whg. 25';

  @override
  String get propertyType => 'Objekttyp';

  @override
  String get propertyArea => 'Fläche, m²';

  @override
  String get purchasePrice => 'Kaufpreis';

  @override
  String get notes => 'Notizen';

  @override
  String get notesHint => 'Zusätzliche Informationen...';

  @override
  String get typeApartment => 'Wohnung';

  @override
  String get typeHouse => 'Haus';

  @override
  String get typeRoom => 'Zimmer';

  @override
  String get tenantsTitle => 'Mieter';

  @override
  String get noTenants => 'Keine Mieter';

  @override
  String get deleteTenantTitle => 'Mieter löschen?';

  @override
  String deleteTenantMessage(String name) {
    return '$name wird gelöscht.';
  }

  @override
  String get newTenant => 'Neuer Mieter';

  @override
  String get editTenant => 'Mieter bearbeiten';

  @override
  String get addTenant => 'Mieter hinzufügen';

  @override
  String get personalInfo => 'Persönliche Daten';

  @override
  String get firstName => 'Vorname';

  @override
  String get lastName => 'Nachname';

  @override
  String get phone => 'Telefon';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Objekt';

  @override
  String get selectProperty => 'Objekt auswählen';

  @override
  String get leaseTerms => 'Mietbedingungen';

  @override
  String get rentPerMonth => 'Miete';

  @override
  String get depositLabel => 'Kaution';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Zahltag: $day.';
  }

  @override
  String paymentDayValue(int day) {
    return '$day.';
  }

  @override
  String get leaseStart => 'Mietbeginn';

  @override
  String get leaseEnd => 'Mietende';

  @override
  String get indefinite => 'Unbefristet';

  @override
  String get rent => 'Miete';

  @override
  String get paymentDay => 'Zahltag';

  @override
  String get remaining => 'Verbleibend';

  @override
  String daysLeft(int n) {
    return '$n T.';
  }

  @override
  String get expired => 'Abgelaufen';

  @override
  String get paymentsTitle => 'Zahlungen';

  @override
  String get noPayments => 'Keine Zahlungen';

  @override
  String get addFirstPayment =>
      'Tippen Sie auf «Hinzufügen», um die erste Zahlung zu erfassen';

  @override
  String get newPayment => 'Neue Zahlung';

  @override
  String get selectTenant => 'Mieter auswählen';

  @override
  String get amount => 'Betrag';

  @override
  String get status => 'Status';

  @override
  String get date => 'Datum';

  @override
  String get addPayment => 'Zahlung hinzufügen';

  @override
  String get markAsPaid => 'Als bezahlt markieren';

  @override
  String get paymentTypeRent => 'Miete';

  @override
  String get paymentTypeDeposit => 'Kaution';

  @override
  String get paymentTypeUtility => 'Nebenkosten';

  @override
  String get paymentTypeOther => 'Sonstiges';

  @override
  String get statusPending => 'Ausstehend';

  @override
  String get statusPaid => 'Bezahlt';

  @override
  String get statusOverdue => 'Überfällig';

  @override
  String get expensesTitle => 'Ausgaben';

  @override
  String get noExpenses => 'Keine Ausgaben';

  @override
  String get addFirstExpense =>
      'Tippen Sie auf «Hinzufügen», um eine Ausgabe zu erfassen';

  @override
  String get newExpense => 'Neue Ausgabe';

  @override
  String get description => 'Beschreibung';

  @override
  String get descriptionHint => 'Klempnerarbeiten';

  @override
  String get addExpense => 'Ausgabe hinzufügen';

  @override
  String get categoryRepair => 'Reparatur';

  @override
  String get categoryTax => 'Steuer';

  @override
  String get categoryInsurance => 'Versicherung';

  @override
  String get categoryUtility => 'Nebenkosten';

  @override
  String get categoryManagement => 'Verwaltung';

  @override
  String get categoryOther => 'Sonstiges';

  @override
  String get reportsTitle => 'Berichte';

  @override
  String get exportPdf => 'PDF exportieren';

  @override
  String get yearlyIncome => 'Jahreseinnahmen';

  @override
  String get yearlyExpenses => 'Jahresausgaben';

  @override
  String get netProfit => 'Nettogewinn';

  @override
  String get profit => 'Gewinn';

  @override
  String get loss => 'Verlust';

  @override
  String get incomeExpensesByMonth => 'Einnahmen und Ausgaben pro Monat';

  @override
  String get noDataForYear => 'Keine Daten für dieses Jahr';

  @override
  String get byMonth => 'Nach Monat';

  @override
  String get month => 'Monat';

  @override
  String get expense => 'Ausgabe';

  @override
  String get net => 'Netto';

  @override
  String get incomeTooltip => 'Einnahmen';

  @override
  String get expenseTooltip => 'Ausgabe';

  @override
  String get chartMonthAbbr => 'J,F,M,A,M,J,J,A,S,O,N,D';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get versionLabel => 'Version';

  @override
  String get propertyLimit => 'Objektlimit';

  @override
  String propertyLimitValue(int n) {
    return '$n (Kostenlos)';
  }

  @override
  String get contactDeveloper => 'Entwickler kontaktieren';

  @override
  String get rateApp => 'App bewerten';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get notificationsSection => 'Benachrichtigungen';

  @override
  String get enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get permissionRequested => 'Berechtigung angefordert';

  @override
  String get dataSection => 'Daten';

  @override
  String get proSection => 'Pro-Funktionen';

  @override
  String get backupToGoogleDrive => 'Google Drive-Backup';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get restorePurchasesSuccess => 'Käufe wiederhergestellt';

  @override
  String get restoreFromBackup => 'Aus Backup wiederherstellen';

  @override
  String get restoreDataTitle => 'Daten wiederherstellen?';

  @override
  String get restoreDataMessage =>
      'Aktuelle Daten werden durch Daten aus Google Drive ersetzt.';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get googleSignInFailed => 'Anmeldung bei Google fehlgeschlagen';

  @override
  String get backupSaved => 'Backup in Google Drive gespeichert';

  @override
  String get backupFailed => 'Backup fehlgeschlagen';

  @override
  String get dataRestored => 'Daten erfolgreich wiederhergestellt';

  @override
  String get backupNotFound => 'Backup nicht gefunden';

  @override
  String get restartApp => 'Neu starten';

  @override
  String get theme => 'Thema';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get currency => 'Währung';

  @override
  String get proDescription =>
      'Bis zu 20 Objekte, PDF-Berichte und Cloud-Backup';

  @override
  String get proCta => 'Für 6,99 €/Monat testen';

  @override
  String get perMonth => '/Mo.';

  @override
  String get proCtaYearly => 'oder 59,99 €/Jahr';

  @override
  String get deleteExpenseTitle => 'Ausgabe löschen?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» wird gelöscht.';
  }

  @override
  String get biometricSection => 'Sicherheit';

  @override
  String get enableBiometric => 'Mit Fingerabdruck entsperren';

  @override
  String get proFeatureMessage => 'In PRO-Version verfügbar';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingStart => 'Loslegen';

  @override
  String get onboarding1Title => 'Willkommen bei RentFlow';

  @override
  String get onboarding1Body => 'Einfache Mietverwaltung für private Vermieter';

  @override
  String get onboarding2Title => 'Objekte & Mieter';

  @override
  String get onboarding2Body =>
      'Fügen Sie Objekte und Mieter in Sekunden hinzu';

  @override
  String get onboarding3Title => 'Zahlungen & Berichte';

  @override
  String get onboarding3Body =>
      'Verfolgen Sie Einnahmen, Ausgaben und Rückstände in Echtzeit';

  @override
  String get notificationPaymentTitle => 'Zahlungserinnerung';

  @override
  String get notificationLeaseEndTitle => 'Mietvertrag läuft bald ab';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — Mietvertrag endet am $date';
  }

  @override
  String get pdfReportTitlePrefix => 'Finanzbericht für';

  @override
  String get pdfSummary => 'Zusammenfassung';

  @override
  String get pdfByMonths => 'Nach Monaten';

  @override
  String get pdfNet => 'Netto';

  @override
  String get pdfTotal => 'Gesamt';

  @override
  String get pdfGeneratedBy => 'Erstellt in RentFlow';

  @override
  String get paymentHistory => 'Zahlungshistorie';

  @override
  String get totalPaid => 'Insgesamt bezahlt';

  @override
  String get thisMonth => 'Diesen Monat';

  @override
  String get allTime => 'Gesamt';

  @override
  String get search => 'Suche';

  @override
  String get searchHint => 'Nach Name oder Telefon suchen…';

  @override
  String get noResults => 'Keine Ergebnisse';

  @override
  String get propertyDetails => 'Objekt-Details';

  @override
  String get recurringExpenses => 'Wiederkehrende Ausgaben';

  @override
  String get repeatMonthly => 'Monatlich wiederholen';

  @override
  String get repeatDay => 'Tag des Monats';

  @override
  String get recurringExpenseHint =>
      'Wird jeden Monat an diesem Tag automatisch erstellt';

  @override
  String get noRecurringExpenses => 'Keine wiederkehrenden Ausgaben';

  @override
  String get addRecurringExpense => 'Vorlage hinzufügen';

  @override
  String get proFeatureRecurring =>
      'Wiederkehrende Ausgaben sind eine Pro-Funktion';

  @override
  String get customCategories => 'Eigene Kategorien';

  @override
  String get addCategory => 'Kategorie hinzufügen';

  @override
  String get categoryName => 'Kategoriename';

  @override
  String get yourCategories => 'Ihre Kategorien';

  @override
  String get proFeatureCategories => 'Eigene Kategorien sind eine Pro-Funktion';

  @override
  String get meterReadings => 'Zählerstandserfassung';

  @override
  String get addReading => 'Ablesung hinzufügen';

  @override
  String get lastReading => 'Letzte Ablesung';

  @override
  String get consumption => 'Verbrauch';

  @override
  String get noReadings => 'Noch keine Ablesungen';

  @override
  String get meterWaterCold => 'Kaltwasser';

  @override
  String get meterWaterHot => 'Warmwasser';

  @override
  String get meterGas => 'Gas';

  @override
  String get meterElectricity => 'Strom';

  @override
  String get meterHeat => 'Wärme';

  @override
  String get meterElectricityT1 => 'Strom T1 (Tag)';

  @override
  String get meterElectricityT2 => 'Strom T2 (Nacht)';

  @override
  String get meterElectricityT3 => 'Strom T3 (Abend)';

  @override
  String get meterHistory => 'Ableseverlauf';

  @override
  String get meterPdfTitle => 'Zählerstandsbericht';

  @override
  String get meterPdfPrevious => 'Vorheriger';

  @override
  String get meterPdfCurrent => 'Aktuell';

  @override
  String get meterPdfElecTotal => 'Strom (gesamt)';

  @override
  String get meterPdfTotalConsumption => 'Gesamtverbrauch';

  @override
  String get meterPdfGeneratedBy => 'Erstellt von RentFlow';

  @override
  String get customType => 'Benutzerdefiniert';

  @override
  String get editReading => 'Bearbeiten';

  @override
  String get typeName => 'Typname';

  @override
  String get selectPeriod => 'Zeitraum wählen';

  @override
  String get pdfPeriod => 'Zeitraum';

  @override
  String get readingValue => 'Zählerstand';

  @override
  String get notifyDaysBefore => 'Erinnerung vorher (Tage)';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get csvCopied => 'CSV in Zwischenablage kopiert';

  @override
  String get faqTitle => 'FAQ & Hilfe';

  @override
  String get faqHowToUseTab => 'Anleitung';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Erste Schritte';

  @override
  String get faqStep1Title => 'Objekt hinzufügen';

  @override
  String get faqStep1Body =>
      'Gehen Sie zu «Objekte» → «+» und geben Sie Name, Adresse und Typ ein.';

  @override
  String get faqStep2Title => 'Mieter hinzufügen';

  @override
  String get faqStep2Body =>
      'In «Mieter» → «+» Daten eingeben, Objekt auswählen, Miete und Zahlungstag festlegen.';

  @override
  String get faqStep3Title => 'Zahlungen erfassen';

  @override
  String get faqStep3Body =>
      'In «Zahlungen» → «+» Zahlung hinzufügen. Nach rechts wischen, um als bezahlt zu markieren.';

  @override
  String get faqStep4Title => 'Ausgaben verfolgen';

  @override
  String get faqStep4Body =>
      'In «Ausgaben» → «+» Kosten hinzufügen, Objekt zuordnen und Kategorie wählen.';

  @override
  String get faqStep5Title => 'Berichte anzeigen';

  @override
  String get faqStep5Body =>
      '«Berichte» zeigt Jahreseinkommen, Ausgaben und Nettogewinn mit Diagramm und Monatstabelle.';

  @override
  String get faqTipsTitle => 'Tipps & Shortcuts';

  @override
  String get faqTip1 =>
      'Nach rechts wischen, um eine Zahlung sofort als bezahlt zu markieren.';

  @override
  String get faqTip2 =>
      'Auf eine Mieter- oder Objektkarte tippen, um Details und Verlauf anzuzeigen.';

  @override
  String get faqTip3 =>
      'In «Zahlungen» zur Kalenderansicht wechseln, um Zahlungen nach Datum zu sehen.';

  @override
  String get faqProProperties => 'Bis zu 20 Objekte';

  @override
  String get faqProNotifications => 'Individuelle Benachrichtigungen';

  @override
  String get faqProRecurring => 'Wiederkehrende Ausgaben';

  @override
  String get splashPhrases =>
      'Mietverwaltung\nin Ihren Händen|Behalten Sie Ihre Mieten\nim Blick|Jede Zahlung\nunter Kontrolle|Ihre Objekte\nimmer dabei|Smarter verwalten —\nmehr verdienen|Vermietung ohne Chaos|Ihr persönlicher\nImmobilienmanager|Alles über Ihre Vermietung\nim Überblick|Einnahmen wachsen —\nAusgaben im Griff|Vermietung als Business —\nmit RentFlow';
}
