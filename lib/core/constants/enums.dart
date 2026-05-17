import '../../generated/app_localizations.dart';

enum PropertyType {
  apartment('apartment'),
  house('house'),
  room('room');

  final String value;
  const PropertyType(this.value);

  static PropertyType fromValue(String v) =>
      PropertyType.values.firstWhere((e) => e.value == v, orElse: () => PropertyType.apartment);
}

enum PaymentStatus {
  pending('pending'),
  paid('paid'),
  overdue('overdue');

  final String value;
  const PaymentStatus(this.value);

  static PaymentStatus fromValue(String v) =>
      PaymentStatus.values.firstWhere((e) => e.value == v, orElse: () => PaymentStatus.pending);
}

enum PaymentType {
  rent('rent'),
  deposit('deposit'),
  utility('utility'),
  other('other');

  final String value;
  const PaymentType(this.value);
}

enum ExpenseCategory {
  repair('repair'),
  tax('tax'),
  insurance('insurance'),
  utility('utility'),
  management('management'),
  other('other');

  final String value;
  const ExpenseCategory(this.value);

  static ExpenseCategory fromValue(String v) =>
      ExpenseCategory.values.firstWhere((e) => e.value == v, orElse: () => ExpenseCategory.other);
}

extension PropertyTypeL10n on PropertyType {
  String l10n(AppLocalizations l) => switch (this) {
        PropertyType.apartment => l.typeApartment,
        PropertyType.house => l.typeHouse,
        PropertyType.room => l.typeRoom,
      };
}

extension PaymentStatusL10n on PaymentStatus {
  String l10n(AppLocalizations l) => switch (this) {
        PaymentStatus.pending => l.statusPending,
        PaymentStatus.paid => l.statusPaid,
        PaymentStatus.overdue => l.statusOverdue,
      };
}

extension PaymentTypeL10n on PaymentType {
  String l10n(AppLocalizations l) => switch (this) {
        PaymentType.rent => l.paymentTypeRent,
        PaymentType.deposit => l.paymentTypeDeposit,
        PaymentType.utility => l.paymentTypeUtility,
        PaymentType.other => l.paymentTypeOther,
      };
}

extension ExpenseCategoryL10n on ExpenseCategory {
  String l10n(AppLocalizations l) => switch (this) {
        ExpenseCategory.repair => l.categoryRepair,
        ExpenseCategory.tax => l.categoryTax,
        ExpenseCategory.insurance => l.categoryInsurance,
        ExpenseCategory.utility => l.categoryUtility,
        ExpenseCategory.management => l.categoryManagement,
        ExpenseCategory.other => l.categoryOther,
      };
}
