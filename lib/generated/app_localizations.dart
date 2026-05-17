import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('uk'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'RentFlow'**
  String get appName;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get navDashboard;

  /// No description provided for @navProperties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get navProperties;

  /// No description provided for @navTenants.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get navTenants;

  /// No description provided for @navPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get navPayments;

  /// No description provided for @navExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get navExpenses;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredField;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get seeAll;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap «Add» to get started'**
  String get tapToStart;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @netIncome.
  ///
  /// In en, this message translates to:
  /// **'Net income'**
  String get netIncome;

  /// No description provided for @addFirstProperty.
  ///
  /// In en, this message translates to:
  /// **'Add your first property'**
  String get addFirstProperty;

  /// No description provided for @noActiveTenants.
  ///
  /// In en, this message translates to:
  /// **'No active tenants'**
  String get noActiveTenants;

  /// No description provided for @overduePaymentsCount.
  ///
  /// In en, this message translates to:
  /// **'Overdue payments: {count}'**
  String overduePaymentsCount(int count);

  /// No description provided for @requiresAttention.
  ///
  /// In en, this message translates to:
  /// **'Requires attention'**
  String get requiresAttention;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @propertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get propertiesTitle;

  /// No description provided for @noProperties.
  ///
  /// In en, this message translates to:
  /// **'No properties'**
  String get noProperties;

  /// No description provided for @deletePropertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete property?'**
  String get deletePropertyTitle;

  /// No description provided for @deletePropertyMessage.
  ///
  /// In en, this message translates to:
  /// **'«{name}» will be permanently deleted.'**
  String deletePropertyMessage(String name);

  /// No description provided for @newProperty.
  ///
  /// In en, this message translates to:
  /// **'New property'**
  String get newProperty;

  /// No description provided for @editProperty.
  ///
  /// In en, this message translates to:
  /// **'Edit property'**
  String get editProperty;

  /// No description provided for @addProperty.
  ///
  /// In en, this message translates to:
  /// **'Add property'**
  String get addProperty;

  /// No description provided for @propertyName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get propertyName;

  /// No description provided for @propertyNameHint.
  ///
  /// In en, this message translates to:
  /// **'Apartment on Main St.'**
  String get propertyNameHint;

  /// No description provided for @propertyAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get propertyAddress;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Main St. 1, apt. 25'**
  String get addressHint;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Property type'**
  String get propertyType;

  /// No description provided for @propertyArea.
  ///
  /// In en, this message translates to:
  /// **'Area, m²'**
  String get propertyArea;

  /// No description provided for @purchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase price'**
  String get purchasePrice;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Additional info...'**
  String get notesHint;

  /// No description provided for @typeApartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get typeApartment;

  /// No description provided for @typeHouse.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get typeHouse;

  /// No description provided for @typeRoom.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get typeRoom;

  /// No description provided for @tenantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get tenantsTitle;

  /// No description provided for @noTenants.
  ///
  /// In en, this message translates to:
  /// **'No tenants'**
  String get noTenants;

  /// No description provided for @deleteTenantTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete tenant?'**
  String get deleteTenantTitle;

  /// No description provided for @deleteTenantMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} will be deleted.'**
  String deleteTenantMessage(String name);

  /// No description provided for @newTenant.
  ///
  /// In en, this message translates to:
  /// **'New tenant'**
  String get newTenant;

  /// No description provided for @editTenant.
  ///
  /// In en, this message translates to:
  /// **'Edit tenant'**
  String get editTenant;

  /// No description provided for @addTenant.
  ///
  /// In en, this message translates to:
  /// **'Add tenant'**
  String get addTenant;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal info'**
  String get personalInfo;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get emailHint;

  /// No description provided for @propertySection.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get propertySection;

  /// No description provided for @selectProperty.
  ///
  /// In en, this message translates to:
  /// **'Select property'**
  String get selectProperty;

  /// No description provided for @leaseTerms.
  ///
  /// In en, this message translates to:
  /// **'Lease terms'**
  String get leaseTerms;

  /// No description provided for @rentPerMonth.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rentPerMonth;

  /// No description provided for @depositLabel.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get depositLabel;

  /// No description provided for @paymentDayPickerLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment day: {day}'**
  String paymentDayPickerLabel(int day);

  /// No description provided for @paymentDayValue.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String paymentDayValue(int day);

  /// No description provided for @leaseStart.
  ///
  /// In en, this message translates to:
  /// **'Lease start'**
  String get leaseStart;

  /// No description provided for @leaseEnd.
  ///
  /// In en, this message translates to:
  /// **'Lease end'**
  String get leaseEnd;

  /// No description provided for @indefinite.
  ///
  /// In en, this message translates to:
  /// **'Indefinite'**
  String get indefinite;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @paymentDay.
  ///
  /// In en, this message translates to:
  /// **'Payment day'**
  String get paymentDay;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{n} d.'**
  String daysLeft(int n);

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @paymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsTitle;

  /// No description provided for @noPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments'**
  String get noPayments;

  /// No description provided for @addFirstPayment.
  ///
  /// In en, this message translates to:
  /// **'Tap «Add» to record the first payment'**
  String get addFirstPayment;

  /// No description provided for @newPayment.
  ///
  /// In en, this message translates to:
  /// **'New payment'**
  String get newPayment;

  /// No description provided for @selectTenant.
  ///
  /// In en, this message translates to:
  /// **'Select tenant'**
  String get selectTenant;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @addPayment.
  ///
  /// In en, this message translates to:
  /// **'Add payment'**
  String get addPayment;

  /// No description provided for @markAsPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark as paid'**
  String get markAsPaid;

  /// No description provided for @paymentTypeRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get paymentTypeRent;

  /// No description provided for @paymentTypeDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get paymentTypeDeposit;

  /// No description provided for @paymentTypeUtility.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get paymentTypeUtility;

  /// No description provided for @paymentTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get paymentTypeOther;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get statusOverdue;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTitle;

  /// No description provided for @noExpenses.
  ///
  /// In en, this message translates to:
  /// **'No expenses'**
  String get noExpenses;

  /// No description provided for @addFirstExpense.
  ///
  /// In en, this message translates to:
  /// **'Tap «Add» to record an expense'**
  String get addFirstExpense;

  /// No description provided for @newExpense.
  ///
  /// In en, this message translates to:
  /// **'New expense'**
  String get newExpense;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Plumbing repair'**
  String get descriptionHint;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get addExpense;

  /// No description provided for @categoryRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get categoryRepair;

  /// No description provided for @categoryTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get categoryTax;

  /// No description provided for @categoryInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get categoryInsurance;

  /// No description provided for @categoryUtility.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get categoryUtility;

  /// No description provided for @categoryManagement.
  ///
  /// In en, this message translates to:
  /// **'Management'**
  String get categoryManagement;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @yearlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Yearly income'**
  String get yearlyIncome;

  /// No description provided for @yearlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Yearly expenses'**
  String get yearlyExpenses;

  /// No description provided for @netProfit.
  ///
  /// In en, this message translates to:
  /// **'Net profit'**
  String get netProfit;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @loss.
  ///
  /// In en, this message translates to:
  /// **'Loss'**
  String get loss;

  /// No description provided for @incomeExpensesByMonth.
  ///
  /// In en, this message translates to:
  /// **'Income & expenses by month'**
  String get incomeExpensesByMonth;

  /// No description provided for @noDataForYear.
  ///
  /// In en, this message translates to:
  /// **'No data for this year'**
  String get noDataForYear;

  /// No description provided for @byMonth.
  ///
  /// In en, this message translates to:
  /// **'By month'**
  String get byMonth;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get net;

  /// No description provided for @incomeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get incomeTooltip;

  /// No description provided for @expenseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expenseTooltip;

  /// No description provided for @chartMonthAbbr.
  ///
  /// In en, this message translates to:
  /// **'J,F,M,A,M,J,J,A,S,O,N,D'**
  String get chartMonthAbbr;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutApp;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @propertyLimit.
  ///
  /// In en, this message translates to:
  /// **'Property limit'**
  String get propertyLimit;

  /// No description provided for @propertyLimitValue.
  ///
  /// In en, this message translates to:
  /// **'{n} (Free)'**
  String propertyLimitValue(int n);

  /// No description provided for @contactDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Contact developer'**
  String get contactDeveloper;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the app'**
  String get rateApp;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @notificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSection;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enableNotifications;

  /// No description provided for @permissionRequested.
  ///
  /// In en, this message translates to:
  /// **'Permission requested'**
  String get permissionRequested;

  /// No description provided for @dataSection.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get dataSection;

  /// No description provided for @backupToGoogleDrive.
  ///
  /// In en, this message translates to:
  /// **'Backup to Google Drive'**
  String get backupToGoogleDrive;

  /// No description provided for @restoreFromBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore from backup'**
  String get restoreFromBackup;

  /// No description provided for @restoreDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore data?'**
  String get restoreDataTitle;

  /// No description provided for @restoreDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Current data will be replaced with data from Google Drive.'**
  String get restoreDataMessage;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign in to Google'**
  String get googleSignInFailed;

  /// No description provided for @backupSaved.
  ///
  /// In en, this message translates to:
  /// **'Backup saved to Google Drive'**
  String get backupSaved;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed'**
  String get backupFailed;

  /// No description provided for @dataRestored.
  ///
  /// In en, this message translates to:
  /// **'Data restored. Please restart the app.'**
  String get dataRestored;

  /// No description provided for @backupNotFound.
  ///
  /// In en, this message translates to:
  /// **'Backup not found'**
  String get backupNotFound;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @proDescription.
  ///
  /// In en, this message translates to:
  /// **'Up to 10 properties, PDF reports and cloud backup'**
  String get proDescription;

  /// No description provided for @proCta.
  ///
  /// In en, this message translates to:
  /// **'Try for \$2.99/mo'**
  String get proCta;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/mo'**
  String get perMonth;

  /// No description provided for @proCtaYearly.
  ///
  /// In en, this message translates to:
  /// **'or \$24.99/year'**
  String get proCtaYearly;

  /// No description provided for @deleteExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete expense?'**
  String get deleteExpenseTitle;

  /// No description provided for @deleteExpenseMessage.
  ///
  /// In en, this message translates to:
  /// **'«{name}» will be deleted.'**
  String deleteExpenseMessage(String name);

  /// No description provided for @biometricSection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get biometricSection;

  /// No description provided for @enableBiometric.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint'**
  String get enableBiometric;

  /// No description provided for @proFeatureMessage.
  ///
  /// In en, this message translates to:
  /// **'Available in PRO version'**
  String get proFeatureMessage;

  /// No description provided for @splashPhrases.
  ///
  /// In en, this message translates to:
  /// **'Rental control\nin your hands|Track your rentals —\nsimply and confidently|Every payment\nunder control|Your properties\nalways with you|Manage smarter —\nearn more|Rental without chaos|Your personal\nproperty manager|Know everything\nabout your rentals|Income grows —\nexpenses under control|Rental as a business —\nwith RentFlow'**
  String get splashPhrases;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'pl',
    'pt',
    'ru',
    'tr',
    'uk',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
