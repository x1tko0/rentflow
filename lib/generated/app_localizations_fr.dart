// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navProperties => 'Propriétés';

  @override
  String get navTenants => 'Locataires';

  @override
  String get navPayments => 'Paiements';

  @override
  String get navExpenses => 'Dépenses';

  @override
  String get navReports => 'Rapports';

  @override
  String get add => 'Ajouter';

  @override
  String get save => 'Enregistrer';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get cancel => 'Annuler';

  @override
  String get requiredField => 'Champ obligatoire';

  @override
  String get invalidNumber => 'Nombre invalide';

  @override
  String get select => 'Sélectionner';

  @override
  String get seeAll => 'Tout';

  @override
  String get tapToStart => 'Appuyez sur «Ajouter» pour commencer';

  @override
  String get income => 'Revenus';

  @override
  String get expenses => 'Dépenses';

  @override
  String get netIncome => 'Revenu net';

  @override
  String get addFirstProperty => 'Ajoutez votre première propriété';

  @override
  String get noActiveTenants => 'Aucun locataire actif';

  @override
  String overduePaymentsCount(int count) {
    return 'Paiements en retard: $count';
  }

  @override
  String get requiresAttention => 'Nécessite attention';

  @override
  String get view => 'Voir';

  @override
  String get propertiesTitle => 'Propriétés';

  @override
  String get noProperties => 'Aucune propriété';

  @override
  String get deletePropertyTitle => 'Supprimer la propriété?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» sera supprimé définitivement.';
  }

  @override
  String get newProperty => 'Nouvelle propriété';

  @override
  String get editProperty => 'Modifier la propriété';

  @override
  String get addProperty => 'Ajouter une propriété';

  @override
  String get propertyName => 'Nom';

  @override
  String get propertyNameHint => 'Appartement rue Principale';

  @override
  String get propertyAddress => 'Adresse';

  @override
  String get addressHint => 'Rue Principale 1, apt. 25';

  @override
  String get propertyType => 'Type de propriété';

  @override
  String get propertyArea => 'Superficie, m²';

  @override
  String get purchasePrice => 'Prix d\'achat';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Informations supplémentaires...';

  @override
  String get typeApartment => 'Appartement';

  @override
  String get typeHouse => 'Maison';

  @override
  String get typeRoom => 'Chambre';

  @override
  String get tenantsTitle => 'Locataires';

  @override
  String get noTenants => 'Aucun locataire';

  @override
  String get deleteTenantTitle => 'Supprimer le locataire?';

  @override
  String deleteTenantMessage(String name) {
    return '$name sera supprimé.';
  }

  @override
  String get newTenant => 'Nouveau locataire';

  @override
  String get editTenant => 'Modifier le locataire';

  @override
  String get addTenant => 'Ajouter un locataire';

  @override
  String get personalInfo => 'Données personnelles';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get phone => 'Téléphone';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Propriété';

  @override
  String get selectProperty => 'Sélectionner une propriété';

  @override
  String get leaseTerms => 'Conditions de location';

  @override
  String get rentPerMonth => 'Loyer';

  @override
  String get depositLabel => 'Dépôt de garantie';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Jour de paiement: $day';
  }

  @override
  String paymentDayValue(int day) {
    return 'Jour $day';
  }

  @override
  String get leaseStart => 'Début de location';

  @override
  String get leaseEnd => 'Fin de location';

  @override
  String get indefinite => 'Indéfini';

  @override
  String get rent => 'Loyer';

  @override
  String get paymentDay => 'Jour de paiement';

  @override
  String get remaining => 'Restant';

  @override
  String daysLeft(int n) {
    return '$n j.';
  }

  @override
  String get expired => 'Expiré';

  @override
  String get paymentsTitle => 'Paiements';

  @override
  String get noPayments => 'Aucun paiement';

  @override
  String get addFirstPayment =>
      'Appuyez sur «Ajouter» pour enregistrer le premier paiement';

  @override
  String get newPayment => 'Nouveau paiement';

  @override
  String get selectTenant => 'Sélectionner un locataire';

  @override
  String get amount => 'Montant';

  @override
  String get status => 'Statut';

  @override
  String get date => 'Date';

  @override
  String get addPayment => 'Ajouter un paiement';

  @override
  String get markAsPaid => 'Marquer comme payé';

  @override
  String get paymentTypeRent => 'Loyer';

  @override
  String get paymentTypeDeposit => 'Dépôt';

  @override
  String get paymentTypeUtility => 'Services';

  @override
  String get paymentTypeOther => 'Autre';

  @override
  String get statusPending => 'En attente';

  @override
  String get statusPaid => 'Payé';

  @override
  String get statusOverdue => 'En retard';

  @override
  String get expensesTitle => 'Dépenses';

  @override
  String get noExpenses => 'Aucune dépense';

  @override
  String get addFirstExpense =>
      'Appuyez sur «Ajouter» pour enregistrer une dépense';

  @override
  String get newExpense => 'Nouvelle dépense';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'Réparation de plomberie';

  @override
  String get addExpense => 'Ajouter une dépense';

  @override
  String get categoryRepair => 'Réparation';

  @override
  String get categoryTax => 'Taxe';

  @override
  String get categoryInsurance => 'Assurance';

  @override
  String get categoryUtility => 'Services';

  @override
  String get categoryManagement => 'Gestion';

  @override
  String get categoryOther => 'Autre';

  @override
  String get reportsTitle => 'Rapports';

  @override
  String get exportPdf => 'Exporter PDF';

  @override
  String get yearlyIncome => 'Revenus annuels';

  @override
  String get yearlyExpenses => 'Dépenses annuelles';

  @override
  String get netProfit => 'Bénéfice net';

  @override
  String get profit => 'Bénéfice';

  @override
  String get loss => 'Perte';

  @override
  String get incomeExpensesByMonth => 'Revenus et dépenses par mois';

  @override
  String get noDataForYear => 'Aucune donnée pour cette année';

  @override
  String get byMonth => 'Par mois';

  @override
  String get month => 'Mois';

  @override
  String get expense => 'Dépense';

  @override
  String get net => 'Net';

  @override
  String get incomeTooltip => 'Revenus';

  @override
  String get expenseTooltip => 'Dépense';

  @override
  String get chartMonthAbbr => 'J,F,M,A,M,J,J,A,S,O,N,D';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get appearance => 'Apparence';

  @override
  String get aboutApp => 'À propos';

  @override
  String get versionLabel => 'Version';

  @override
  String get propertyLimit => 'Limite de propriétés';

  @override
  String propertyLimitValue(int n) {
    return '$n (Gratuit)';
  }

  @override
  String get contactDeveloper => 'Contacter le développeur';

  @override
  String get rateApp => 'Évaluer l\'application';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get permissionRequested => 'Permission demandée';

  @override
  String get dataSection => 'Données';

  @override
  String get proSection => 'Fonctionnalités Pro';

  @override
  String get backupToGoogleDrive => 'Sauvegarde sur Google Drive';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get restorePurchasesSuccess => 'Achats restaurés';

  @override
  String get restoreFromBackup => 'Restaurer depuis la sauvegarde';

  @override
  String get restoreDataTitle => 'Restaurer les données?';

  @override
  String get restoreDataMessage =>
      'Les données actuelles seront remplacées par des données de Google Drive.';

  @override
  String get restore => 'Restaurer';

  @override
  String get googleSignInFailed => 'Échec de la connexion à Google';

  @override
  String get backupSaved => 'Sauvegarde enregistrée sur Google Drive';

  @override
  String get backupFailed => 'Échec de la sauvegarde';

  @override
  String get dataRestored => 'Données restaurées avec succès';

  @override
  String get backupNotFound => 'Sauvegarde introuvable';

  @override
  String get restartApp => 'Redémarrer';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get currency => 'Devise';

  @override
  String get proDescription =>
      'Jusqu\'à 20 propriétés, rapports PDF et sauvegarde cloud';

  @override
  String get proCta => 'Essayer pour 6,99 €/mois';

  @override
  String get perMonth => '/mois';

  @override
  String get proCtaYearly => 'ou 59,99 €/an';

  @override
  String get deleteExpenseTitle => 'Supprimer la dépense ?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» sera supprimé.';
  }

  @override
  String get biometricSection => 'Sécurité';

  @override
  String get enableBiometric => 'Déverrouiller avec empreinte';

  @override
  String get proFeatureMessage => 'Disponible en version PRO';

  @override
  String get onboardingSkip => 'Ignorer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get onboarding1Title => 'Bienvenue dans RentFlow';

  @override
  String get onboarding1Body =>
      'Gestion locative simple pour les propriétaires privés';

  @override
  String get onboarding2Title => 'Biens & Locataires';

  @override
  String get onboarding2Body =>
      'Ajoutez vos biens et locataires en quelques secondes';

  @override
  String get onboarding3Title => 'Paiements & Rapports';

  @override
  String get onboarding3Body =>
      'Suivez revenus, dépenses et retards de paiement en temps réel';

  @override
  String get notificationPaymentTitle => 'Rappel de paiement';

  @override
  String get notificationLeaseEndTitle => 'Bail bientôt expiré';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — bail se termine le $date';
  }

  @override
  String get pdfReportTitlePrefix => 'Rapport financier pour';

  @override
  String get pdfSummary => 'Résumé';

  @override
  String get pdfByMonths => 'Par mois';

  @override
  String get pdfNet => 'Net';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfGeneratedBy => 'Généré dans RentFlow';

  @override
  String get paymentHistory => 'Historique des paiements';

  @override
  String get totalPaid => 'Total payé';

  @override
  String get thisMonth => 'Ce mois';

  @override
  String get allTime => 'Tout le temps';

  @override
  String get search => 'Recherche';

  @override
  String get searchHint => 'Rechercher par nom ou téléphone…';

  @override
  String get noResults => 'Aucun résultat';

  @override
  String get propertyDetails => 'Détails du bien';

  @override
  String get recurringExpenses => 'Dépenses récurrentes';

  @override
  String get repeatMonthly => 'Répéter mensuellement';

  @override
  String get repeatDay => 'Jour du mois';

  @override
  String get recurringExpenseHint =>
      'Créé automatiquement chaque mois ce jour-là';

  @override
  String get noRecurringExpenses => 'Aucune dépense récurrente';

  @override
  String get addRecurringExpense => 'Ajouter un modèle';

  @override
  String get proFeatureRecurring =>
      'Les dépenses récurrentes sont une fonctionnalité Pro';

  @override
  String get customCategories => 'Catégories personnalisées';

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get categoryName => 'Nom de la catégorie';

  @override
  String get yourCategories => 'Vos catégories';

  @override
  String get proFeatureCategories =>
      'Les catégories personnalisées sont une fonctionnalité Pro';

  @override
  String get meterReadings => 'Relevés de compteurs';

  @override
  String get addReading => 'Ajouter un relevé';

  @override
  String get lastReading => 'Dernier relevé';

  @override
  String get consumption => 'Consommation';

  @override
  String get noReadings => 'Pas encore de relevés';

  @override
  String get meterWaterCold => 'Eau froide';

  @override
  String get meterWaterHot => 'Eau chaude';

  @override
  String get meterGas => 'Gaz';

  @override
  String get meterElectricity => 'Électricité';

  @override
  String get meterHeat => 'Chaleur';

  @override
  String get meterElectricityT1 => 'Électricité T1 (Jour)';

  @override
  String get meterElectricityT2 => 'Électricité T2 (Nuit)';

  @override
  String get meterElectricityT3 => 'Électricité T3 (Soir)';

  @override
  String get meterHistory => 'Historique des relevés';

  @override
  String get meterPdfTitle => 'Rapport des relevés de compteurs';

  @override
  String get meterPdfPrevious => 'Précédent';

  @override
  String get meterPdfCurrent => 'Actuel';

  @override
  String get meterPdfElecTotal => 'Électricité (total)';

  @override
  String get meterPdfTotalConsumption => 'Consommation totale';

  @override
  String get meterPdfGeneratedBy => 'Généré par RentFlow';

  @override
  String get customType => 'Type personnalisé';

  @override
  String get editReading => 'Modifier';

  @override
  String get typeName => 'Nom du type';

  @override
  String get selectPeriod => 'Sélectionner la période';

  @override
  String get pdfPeriod => 'Période';

  @override
  String get readingValue => 'Valeur du compteur';

  @override
  String get notifyDaysBefore => 'Rappeler avant (jours)';

  @override
  String get exportCsv => 'Exporter CSV';

  @override
  String get csvCopied => 'CSV copié dans le presse-papiers';

  @override
  String get faqTitle => 'FAQ & Aide';

  @override
  String get faqHowToUseTab => 'Utilisation';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Premiers pas';

  @override
  String get faqStep1Title => 'Ajouter un bien';

  @override
  String get faqStep1Body =>
      'Allez dans «Biens» → «+» et renseignez le nom, l\'adresse et le type.';

  @override
  String get faqStep2Title => 'Ajouter un locataire';

  @override
  String get faqStep2Body =>
      'Dans «Locataires» → «+» saisissez les infos, choisissez un bien, définissez le loyer et le jour de paiement.';

  @override
  String get faqStep3Title => 'Enregistrer les paiements';

  @override
  String get faqStep3Body =>
      'Dans «Paiements» → «+» ajoutez un paiement. Glissez à droite pour marquer comme payé.';

  @override
  String get faqStep4Title => 'Suivre les dépenses';

  @override
  String get faqStep4Body =>
      'Dans «Dépenses» → «+» ajoutez un coût, liez-le à un bien et choisissez une catégorie.';

  @override
  String get faqStep5Title => 'Voir les rapports';

  @override
  String get faqStep5Body =>
      '«Rapports» affiche les revenus annuels, les dépenses et le bénéfice net avec un graphique mensuel.';

  @override
  String get faqTipsTitle => 'Astuces';

  @override
  String get faqTip1 =>
      'Glissez à droite sur un paiement pour le marquer payé sans ouvrir le formulaire.';

  @override
  String get faqTip2 =>
      'Appuyez sur une carte locataire ou bien pour voir les détails et l\'historique.';

  @override
  String get faqTip3 =>
      'Passez en vue calendrier dans Paiements pour voir les paiements par date.';

  @override
  String get faqProProperties => 'Jusqu\'à 20 propriétés';

  @override
  String get faqProNotifications => 'Notifications personnalisées';

  @override
  String get faqProRecurring => 'Dépenses récurrentes';

  @override
  String get splashPhrases =>
      'Contrôle locatif\nentre vos mains|Suivez vos locations —\nsimplement et sereinement|Chaque paiement\nsous contrôle|Vos biens\ntoujours à portée|Gérez plus intelligemment —\ngagnez plus|Location sans chaos|Votre gestionnaire\nimmobilier personnel|Tout savoir\nsur votre location|Les revenus augmentent —\nles dépenses sous contrôle|La location comme business —\navec RentFlow';
}
