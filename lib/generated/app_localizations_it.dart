// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Panoramica';

  @override
  String get navProperties => 'Immobili';

  @override
  String get navTenants => 'Inquilini';

  @override
  String get navPayments => 'Pagamenti';

  @override
  String get navExpenses => 'Spese';

  @override
  String get navReports => 'Rapporti';

  @override
  String get add => 'Aggiungi';

  @override
  String get save => 'Salva';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get delete => 'Elimina';

  @override
  String get edit => 'Modifica';

  @override
  String get cancel => 'Annulla';

  @override
  String get requiredField => 'Campo obbligatorio';

  @override
  String get invalidNumber => 'Numero non valido';

  @override
  String get select => 'Seleziona';

  @override
  String get seeAll => 'Tutto';

  @override
  String get tapToStart => 'Tocca «Aggiungi» per iniziare';

  @override
  String get income => 'Entrate';

  @override
  String get expenses => 'Spese';

  @override
  String get netIncome => 'Reddito netto';

  @override
  String get addFirstProperty => 'Aggiungi il tuo primo immobile';

  @override
  String get noActiveTenants => 'Nessun inquilino attivo';

  @override
  String overduePaymentsCount(int count) {
    return 'Pagamenti scaduti: $count';
  }

  @override
  String get requiresAttention => 'Richiede attenzione';

  @override
  String get view => 'Visualizza';

  @override
  String get propertiesTitle => 'Immobili';

  @override
  String get noProperties => 'Nessun immobile';

  @override
  String get deletePropertyTitle => 'Eliminare l\'immobile?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» sarà eliminato definitivamente.';
  }

  @override
  String get newProperty => 'Nuovo immobile';

  @override
  String get editProperty => 'Modifica immobile';

  @override
  String get addProperty => 'Aggiungi immobile';

  @override
  String get propertyName => 'Nome';

  @override
  String get propertyNameHint => 'Appartamento in Via Roma';

  @override
  String get propertyAddress => 'Indirizzo';

  @override
  String get addressHint => 'Via Roma 1, apt. 25';

  @override
  String get propertyType => 'Tipo di immobile';

  @override
  String get propertyArea => 'Superficie, m²';

  @override
  String get purchasePrice => 'Prezzo d\'acquisto';

  @override
  String get notes => 'Note';

  @override
  String get notesHint => 'Informazioni aggiuntive...';

  @override
  String get typeApartment => 'Appartamento';

  @override
  String get typeHouse => 'Casa';

  @override
  String get typeRoom => 'Stanza';

  @override
  String get tenantsTitle => 'Inquilini';

  @override
  String get noTenants => 'Nessun inquilino';

  @override
  String get deleteTenantTitle => 'Eliminare l\'inquilino?';

  @override
  String deleteTenantMessage(String name) {
    return '$name sarà eliminato.';
  }

  @override
  String get newTenant => 'Nuovo inquilino';

  @override
  String get editTenant => 'Modifica inquilino';

  @override
  String get addTenant => 'Aggiungi inquilino';

  @override
  String get personalInfo => 'Dati personali';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get phone => 'Telefono';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Immobile';

  @override
  String get selectProperty => 'Seleziona immobile';

  @override
  String get leaseTerms => 'Condizioni di locazione';

  @override
  String get rentPerMonth => 'Affitto';

  @override
  String get depositLabel => 'Deposito';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Giorno di pagamento: $day';
  }

  @override
  String paymentDayValue(int day) {
    return 'Giorno $day';
  }

  @override
  String get leaseStart => 'Inizio locazione';

  @override
  String get leaseEnd => 'Fine locazione';

  @override
  String get indefinite => 'Indeterminato';

  @override
  String get rent => 'Affitto';

  @override
  String get paymentDay => 'Giorno di pagamento';

  @override
  String get remaining => 'Rimanente';

  @override
  String daysLeft(int n) {
    return '$n g.';
  }

  @override
  String get expired => 'Scaduto';

  @override
  String get paymentsTitle => 'Pagamenti';

  @override
  String get noPayments => 'Nessun pagamento';

  @override
  String get addFirstPayment =>
      'Tocca «Aggiungi» per registrare il primo pagamento';

  @override
  String get newPayment => 'Nuovo pagamento';

  @override
  String get selectTenant => 'Seleziona inquilino';

  @override
  String get amount => 'Importo';

  @override
  String get status => 'Stato';

  @override
  String get date => 'Data';

  @override
  String get addPayment => 'Aggiungi pagamento';

  @override
  String get markAsPaid => 'Segna come pagato';

  @override
  String get paymentTypeRent => 'Affitto';

  @override
  String get paymentTypeDeposit => 'Deposito';

  @override
  String get paymentTypeUtility => 'Utenze';

  @override
  String get paymentTypeOther => 'Altro';

  @override
  String get statusPending => 'In attesa';

  @override
  String get statusPaid => 'Pagato';

  @override
  String get statusOverdue => 'Scaduto';

  @override
  String get expensesTitle => 'Spese';

  @override
  String get noExpenses => 'Nessuna spesa';

  @override
  String get addFirstExpense => 'Tocca «Aggiungi» per registrare una spesa';

  @override
  String get newExpense => 'Nuova spesa';

  @override
  String get description => 'Descrizione';

  @override
  String get descriptionHint => 'Riparazione idraulica';

  @override
  String get addExpense => 'Aggiungi spesa';

  @override
  String get categoryRepair => 'Riparazione';

  @override
  String get categoryTax => 'Tassa';

  @override
  String get categoryInsurance => 'Assicurazione';

  @override
  String get categoryUtility => 'Utenze';

  @override
  String get categoryManagement => 'Gestione';

  @override
  String get categoryOther => 'Altro';

  @override
  String get reportsTitle => 'Rapporti';

  @override
  String get exportPdf => 'Esporta PDF';

  @override
  String get yearlyIncome => 'Entrate annuali';

  @override
  String get yearlyExpenses => 'Spese annuali';

  @override
  String get netProfit => 'Profitto netto';

  @override
  String get profit => 'Profitto';

  @override
  String get loss => 'Perdita';

  @override
  String get incomeExpensesByMonth => 'Entrate e spese per mese';

  @override
  String get noDataForYear => 'Nessun dato per quest\'anno';

  @override
  String get byMonth => 'Per mese';

  @override
  String get month => 'Mese';

  @override
  String get expense => 'Spesa';

  @override
  String get net => 'Netto';

  @override
  String get incomeTooltip => 'Entrate';

  @override
  String get expenseTooltip => 'Spesa';

  @override
  String get chartMonthAbbr => 'G,F,M,A,M,G,L,A,S,O,N,D';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get appearance => 'Aspetto';

  @override
  String get aboutApp => 'Informazioni';

  @override
  String get versionLabel => 'Versione';

  @override
  String get propertyLimit => 'Limite immobili';

  @override
  String propertyLimitValue(int n) {
    return '$n (Gratuito)';
  }

  @override
  String get contactDeveloper => 'Contatta lo sviluppatore';

  @override
  String get rateApp => 'Valuta l\'app';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get notificationsSection => 'Notifiche';

  @override
  String get enableNotifications => 'Abilita notifiche';

  @override
  String get permissionRequested => 'Autorizzazione richiesta';

  @override
  String get dataSection => 'Dati';

  @override
  String get proSection => 'Funzionalità Pro';

  @override
  String get backupToGoogleDrive => 'Backup su Google Drive';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get restorePurchasesSuccess => 'Acquisti ripristinati';

  @override
  String get restoreFromBackup => 'Ripristina dal backup';

  @override
  String get restoreDataTitle => 'Ripristinare i dati?';

  @override
  String get restoreDataMessage =>
      'I dati correnti saranno sostituiti con i dati di Google Drive.';

  @override
  String get restore => 'Ripristina';

  @override
  String get googleSignInFailed => 'Accesso a Google non riuscito';

  @override
  String get backupSaved => 'Backup salvato su Google Drive';

  @override
  String get backupFailed => 'Backup non riuscito';

  @override
  String get dataRestored => 'Dati ripristinati con successo';

  @override
  String get backupNotFound => 'Backup non trovato';

  @override
  String get restartApp => 'Riavvia';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get currency => 'Valuta';

  @override
  String get proDescription => 'Fino a 20 immobili, report PDF e backup cloud';

  @override
  String get proCta => 'Prova per 6,99 €/mese';

  @override
  String get perMonth => '/mese';

  @override
  String get proCtaYearly => 'o 59,99 €/anno';

  @override
  String get deleteExpenseTitle => 'Eliminare la spesa?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» verrà eliminato.';
  }

  @override
  String get biometricSection => 'Sicurezza';

  @override
  String get enableBiometric => 'Sblocca con impronta';

  @override
  String get proFeatureMessage => 'Disponibile nella versione PRO';

  @override
  String get onboardingSkip => 'Salta';

  @override
  String get onboardingNext => 'Avanti';

  @override
  String get onboardingStart => 'Inizia';

  @override
  String get onboarding1Title => 'Benvenuto in RentFlow';

  @override
  String get onboarding1Body =>
      'Gestione affitti semplice per i proprietari privati';

  @override
  String get onboarding2Title => 'Immobili & Inquilini';

  @override
  String get onboarding2Body =>
      'Aggiungi immobili e inquilini in pochi secondi';

  @override
  String get onboarding3Title => 'Pagamenti & Report';

  @override
  String get onboarding3Body =>
      'Monitora entrate, spese e pagamenti in ritardo in tempo reale';

  @override
  String get notificationPaymentTitle => 'Promemoria pagamento';

  @override
  String get notificationLeaseEndTitle => 'Contratto in scadenza';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — contratto termina il $date';
  }

  @override
  String get pdfReportTitlePrefix => 'Report finanziario per';

  @override
  String get pdfSummary => 'Riepilogo';

  @override
  String get pdfByMonths => 'Per mese';

  @override
  String get pdfNet => 'Netto';

  @override
  String get pdfTotal => 'Totale';

  @override
  String get pdfGeneratedBy => 'Generato in RentFlow';

  @override
  String get paymentHistory => 'Storico pagamenti';

  @override
  String get totalPaid => 'Totale pagato';

  @override
  String get thisMonth => 'Questo mese';

  @override
  String get allTime => 'Tutto il tempo';

  @override
  String get search => 'Cerca';

  @override
  String get searchHint => 'Cerca per nome o telefono…';

  @override
  String get noResults => 'Nessun risultato';

  @override
  String get propertyDetails => 'Dettagli immobile';

  @override
  String get recurringExpenses => 'Spese ricorrenti';

  @override
  String get repeatMonthly => 'Ripeti mensilmente';

  @override
  String get repeatDay => 'Giorno del mese';

  @override
  String get recurringExpenseHint =>
      'Creato automaticamente ogni mese in questo giorno';

  @override
  String get noRecurringExpenses => 'Nessuna spesa ricorrente';

  @override
  String get addRecurringExpense => 'Aggiungi modello';

  @override
  String get proFeatureRecurring => 'Le spese ricorrenti sono una funzione Pro';

  @override
  String get customCategories => 'Categorie personalizzate';

  @override
  String get addCategory => 'Aggiungi categoria';

  @override
  String get categoryName => 'Nome categoria';

  @override
  String get yourCategories => 'Le tue categorie';

  @override
  String get proFeatureCategories =>
      'Le categorie personalizzate sono una funzione Pro';

  @override
  String get meterReadings => 'Letture contatori';

  @override
  String get addReading => 'Aggiungi lettura';

  @override
  String get lastReading => 'Ultima lettura';

  @override
  String get consumption => 'Consumo';

  @override
  String get noReadings => 'Nessuna lettura ancora';

  @override
  String get meterWaterCold => 'Acqua fredda';

  @override
  String get meterWaterHot => 'Acqua calda';

  @override
  String get meterGas => 'Gas';

  @override
  String get meterElectricity => 'Elettricità';

  @override
  String get meterHeat => 'Calore';

  @override
  String get meterElectricityT1 => 'Elettricità T1 (Giorno)';

  @override
  String get meterElectricityT2 => 'Elettricità T2 (Notte)';

  @override
  String get meterElectricityT3 => 'Elettricità T3 (Sera)';

  @override
  String get meterHistory => 'Storico letture';

  @override
  String get meterPdfTitle => 'Report letture contatori';

  @override
  String get meterPdfPrevious => 'Precedente';

  @override
  String get meterPdfCurrent => 'Attuale';

  @override
  String get meterPdfElecTotal => 'Elettricità (totale)';

  @override
  String get meterPdfTotalConsumption => 'Consumo totale';

  @override
  String get meterPdfGeneratedBy => 'Generato da RentFlow';

  @override
  String get customType => 'Tipo personalizzato';

  @override
  String get editReading => 'Modifica';

  @override
  String get typeName => 'Nome tipo';

  @override
  String get selectPeriod => 'Seleziona periodo';

  @override
  String get pdfPeriod => 'Periodo';

  @override
  String get readingValue => 'Valore contatore';

  @override
  String get notifyDaysBefore => 'Promemoria prima (giorni)';

  @override
  String get exportCsv => 'Esporta CSV';

  @override
  String get csvCopied => 'CSV copiato negli appunti';

  @override
  String get faqTitle => 'FAQ & Guida';

  @override
  String get faqHowToUseTab => 'Come usare';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Primi passi';

  @override
  String get faqStep1Title => 'Aggiungi immobile';

  @override
  String get faqStep1Body =>
      'Vai su «Immobili» → «+» e inserisci nome, indirizzo e tipo.';

  @override
  String get faqStep2Title => 'Aggiungi inquilino';

  @override
  String get faqStep2Body =>
      'In «Inquilini» → «+» inserisci i dati, seleziona l\'immobile, imposta affitto e giorno di pagamento.';

  @override
  String get faqStep3Title => 'Registra pagamenti';

  @override
  String get faqStep3Body =>
      'In «Pagamenti» → «+» aggiungi un pagamento. Scorri a destra per segnarlo come pagato.';

  @override
  String get faqStep4Title => 'Traccia spese';

  @override
  String get faqStep4Body =>
      'In «Spese» → «+» aggiungi un costo, collegalo all\'immobile e scegli la categoria.';

  @override
  String get faqStep5Title => 'Visualizza report';

  @override
  String get faqStep5Body =>
      '«Report» mostra reddito annuale, spese e utile netto con grafico e tabella mensile.';

  @override
  String get faqTipsTitle => 'Suggerimenti';

  @override
  String get faqTip1 =>
      'Scorri a destra su un pagamento per segnarlo pagato senza aprire il modulo.';

  @override
  String get faqTip2 =>
      'Tocca una scheda inquilino o immobile per vedere dettagli e cronologia.';

  @override
  String get faqTip3 =>
      'Passa alla vista calendario in Pagamenti per vedere i pagamenti per data.';

  @override
  String get faqProProperties => 'Fino a 20 proprietà';

  @override
  String get faqProNotifications => 'Notifiche personalizzate';

  @override
  String get faqProRecurring => 'Spese ricorrenti';

  @override
  String get splashPhrases =>
      'Controllo degli affitti\nnelle tue mani|Monitora i tuoi affitti —\nsempre e facilmente|Ogni pagamento\nsotto controllo|Le tue proprietà\nsempre con te|Gestisci in modo più smart —\nguadagna di più|Affitti senza caos|Il tuo gestore personale\nimmobiliare|Sappi tutto\nsui tuoi affitti|I redditi crescono —\nle spese sotto controllo|Affitto come business —\ncon RentFlow';
}
