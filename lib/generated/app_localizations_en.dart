// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Overview';

  @override
  String get navProperties => 'Properties';

  @override
  String get navTenants => 'Tenants';

  @override
  String get navPayments => 'Payments';

  @override
  String get navExpenses => 'Expenses';

  @override
  String get navReports => 'Reports';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get requiredField => 'Required field';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get select => 'Select';

  @override
  String get seeAll => 'All';

  @override
  String get tapToStart => 'Tap «Add» to get started';

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get netIncome => 'Net income';

  @override
  String get addFirstProperty => 'Add your first property';

  @override
  String get noActiveTenants => 'No active tenants';

  @override
  String overduePaymentsCount(int count) {
    return 'Overdue payments: $count';
  }

  @override
  String get requiresAttention => 'Requires attention';

  @override
  String get view => 'View';

  @override
  String get propertiesTitle => 'Properties';

  @override
  String get noProperties => 'No properties';

  @override
  String get deletePropertyTitle => 'Delete property?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» will be permanently deleted.';
  }

  @override
  String get newProperty => 'New property';

  @override
  String get editProperty => 'Edit property';

  @override
  String get addProperty => 'Add property';

  @override
  String get propertyName => 'Name';

  @override
  String get propertyNameHint => 'Apartment on Main St.';

  @override
  String get propertyAddress => 'Address';

  @override
  String get addressHint => 'Main St. 1, apt. 25';

  @override
  String get propertyType => 'Property type';

  @override
  String get propertyArea => 'Area, m²';

  @override
  String get purchasePrice => 'Purchase price';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Additional info...';

  @override
  String get typeApartment => 'Apartment';

  @override
  String get typeHouse => 'House';

  @override
  String get typeRoom => 'Room';

  @override
  String get tenantsTitle => 'Tenants';

  @override
  String get noTenants => 'No tenants';

  @override
  String get deleteTenantTitle => 'Delete tenant?';

  @override
  String deleteTenantMessage(String name) {
    return '$name will be deleted.';
  }

  @override
  String get newTenant => 'New tenant';

  @override
  String get editTenant => 'Edit tenant';

  @override
  String get addTenant => 'Add tenant';

  @override
  String get personalInfo => 'Personal info';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get phone => 'Phone';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Property';

  @override
  String get selectProperty => 'Select property';

  @override
  String get leaseTerms => 'Lease terms';

  @override
  String get rentPerMonth => 'Rent';

  @override
  String get depositLabel => 'Deposit';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Payment day: $day';
  }

  @override
  String paymentDayValue(int day) {
    return 'Day $day';
  }

  @override
  String get leaseStart => 'Lease start';

  @override
  String get leaseEnd => 'Lease end';

  @override
  String get indefinite => 'Indefinite';

  @override
  String get rent => 'Rent';

  @override
  String get paymentDay => 'Payment day';

  @override
  String get remaining => 'Remaining';

  @override
  String daysLeft(int n) {
    return '$n d.';
  }

  @override
  String get expired => 'Expired';

  @override
  String get paymentsTitle => 'Payments';

  @override
  String get noPayments => 'No payments';

  @override
  String get addFirstPayment => 'Tap «Add» to record the first payment';

  @override
  String get newPayment => 'New payment';

  @override
  String get selectTenant => 'Select tenant';

  @override
  String get amount => 'Amount';

  @override
  String get status => 'Status';

  @override
  String get date => 'Date';

  @override
  String get addPayment => 'Add payment';

  @override
  String get markAsPaid => 'Mark as paid';

  @override
  String get paymentTypeRent => 'Rent';

  @override
  String get paymentTypeDeposit => 'Deposit';

  @override
  String get paymentTypeUtility => 'Utilities';

  @override
  String get paymentTypeOther => 'Other';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get expensesTitle => 'Expenses';

  @override
  String get noExpenses => 'No expenses';

  @override
  String get addFirstExpense => 'Tap «Add» to record an expense';

  @override
  String get newExpense => 'New expense';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'Plumbing repair';

  @override
  String get addExpense => 'Add expense';

  @override
  String get categoryRepair => 'Repair';

  @override
  String get categoryTax => 'Tax';

  @override
  String get categoryInsurance => 'Insurance';

  @override
  String get categoryUtility => 'Utilities';

  @override
  String get categoryManagement => 'Management';

  @override
  String get categoryOther => 'Other';

  @override
  String get reportsTitle => 'Reports';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get yearlyIncome => 'Yearly income';

  @override
  String get yearlyExpenses => 'Yearly expenses';

  @override
  String get netProfit => 'Net profit';

  @override
  String get profit => 'Profit';

  @override
  String get loss => 'Loss';

  @override
  String get incomeExpensesByMonth => 'Income & expenses by month';

  @override
  String get noDataForYear => 'No data for this year';

  @override
  String get byMonth => 'By month';

  @override
  String get month => 'Month';

  @override
  String get expense => 'Expense';

  @override
  String get net => 'Net';

  @override
  String get incomeTooltip => 'Income';

  @override
  String get expenseTooltip => 'Expense';

  @override
  String get chartMonthAbbr => 'J,F,M,A,M,J,J,A,S,O,N,D';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get aboutApp => 'About';

  @override
  String get versionLabel => 'Version';

  @override
  String get propertyLimit => 'Property limit';

  @override
  String propertyLimitValue(int n) {
    return '$n (Free)';
  }

  @override
  String get contactDeveloper => 'Contact developer';

  @override
  String get rateApp => 'Rate the app';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get enableNotifications => 'Enable notifications';

  @override
  String get permissionRequested => 'Permission requested';

  @override
  String get dataSection => 'Data';

  @override
  String get backupToGoogleDrive => 'Backup to Google Drive';

  @override
  String get restoreFromBackup => 'Restore from backup';

  @override
  String get restoreDataTitle => 'Restore data?';

  @override
  String get restoreDataMessage =>
      'Current data will be replaced with data from Google Drive.';

  @override
  String get restore => 'Restore';

  @override
  String get googleSignInFailed => 'Failed to sign in to Google';

  @override
  String get backupSaved => 'Backup saved to Google Drive';

  @override
  String get backupFailed => 'Backup failed';

  @override
  String get dataRestored => 'Data restored. Please restart the app.';

  @override
  String get backupNotFound => 'Backup not found';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get currency => 'Currency';

  @override
  String get proDescription =>
      'Up to 10 properties, PDF reports and cloud backup';

  @override
  String get proCta => 'Try for \$2.99/mo';

  @override
  String get perMonth => '/mo';

  @override
  String get proCtaYearly => 'or \$24.99/year';

  @override
  String get deleteExpenseTitle => 'Delete expense?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» will be deleted.';
  }

  @override
  String get biometricSection => 'Security';

  @override
  String get enableBiometric => 'Unlock with fingerprint';

  @override
  String get proFeatureMessage => 'Available in PRO version';

  @override
  String get splashPhrases =>
      'Rental control\nin your hands|Track your rentals —\nsimply and confidently|Every payment\nunder control|Your properties\nalways with you|Manage smarter —\nearn more|Rental without chaos|Your personal\nproperty manager|Know everything\nabout your rentals|Income grows —\nexpenses under control|Rental as a business —\nwith RentFlow';
}
