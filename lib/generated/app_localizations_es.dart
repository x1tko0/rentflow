// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Resumen';

  @override
  String get navProperties => 'Propiedades';

  @override
  String get navTenants => 'Inquilinos';

  @override
  String get navPayments => 'Pagos';

  @override
  String get navExpenses => 'Gastos';

  @override
  String get navReports => 'Informes';

  @override
  String get add => 'Agregar';

  @override
  String get save => 'Guardar';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get requiredField => 'Campo obligatorio';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get select => 'Seleccionar';

  @override
  String get seeAll => 'Todo';

  @override
  String get tapToStart => 'Toca «Agregar» para comenzar';

  @override
  String get income => 'Ingresos';

  @override
  String get expenses => 'Gastos';

  @override
  String get netIncome => 'Ingreso neto';

  @override
  String get addFirstProperty => 'Agrega tu primera propiedad';

  @override
  String get noActiveTenants => 'No hay inquilinos activos';

  @override
  String overduePaymentsCount(int count) {
    return 'Pagos vencidos: $count';
  }

  @override
  String get requiresAttention => 'Requiere atención';

  @override
  String get view => 'Ver';

  @override
  String get propertiesTitle => 'Propiedades';

  @override
  String get noProperties => 'Sin propiedades';

  @override
  String get deletePropertyTitle => '¿Eliminar propiedad?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» será eliminado permanentemente.';
  }

  @override
  String get newProperty => 'Nueva propiedad';

  @override
  String get editProperty => 'Editar propiedad';

  @override
  String get addProperty => 'Agregar propiedad';

  @override
  String get propertyName => 'Nombre';

  @override
  String get propertyNameHint => 'Apartamento en Calle Principal';

  @override
  String get propertyAddress => 'Dirección';

  @override
  String get addressHint => 'Calle Principal 1, apto. 25';

  @override
  String get propertyType => 'Tipo de propiedad';

  @override
  String get propertyArea => 'Área, m²';

  @override
  String get purchasePrice => 'Precio de compra';

  @override
  String get notes => 'Notas';

  @override
  String get notesHint => 'Información adicional...';

  @override
  String get typeApartment => 'Apartamento';

  @override
  String get typeHouse => 'Casa';

  @override
  String get typeRoom => 'Habitación';

  @override
  String get tenantsTitle => 'Inquilinos';

  @override
  String get noTenants => 'Sin inquilinos';

  @override
  String get deleteTenantTitle => '¿Eliminar inquilino?';

  @override
  String deleteTenantMessage(String name) {
    return '$name será eliminado.';
  }

  @override
  String get newTenant => 'Nuevo inquilino';

  @override
  String get editTenant => 'Editar inquilino';

  @override
  String get addTenant => 'Agregar inquilino';

  @override
  String get personalInfo => 'Datos personales';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get phone => 'Teléfono';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Propiedad';

  @override
  String get selectProperty => 'Seleccionar propiedad';

  @override
  String get leaseTerms => 'Condiciones del arrendamiento';

  @override
  String get rentPerMonth => 'Alquiler, /mes';

  @override
  String get depositLabel => 'Depósito';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Día de pago: $day';
  }

  @override
  String paymentDayValue(int day) {
    return 'Día $day';
  }

  @override
  String get leaseStart => 'Inicio del arrendamiento';

  @override
  String get leaseEnd => 'Fin del arrendamiento';

  @override
  String get indefinite => 'Indefinido';

  @override
  String get rent => 'Alquiler';

  @override
  String get paymentDay => 'Día de pago';

  @override
  String get remaining => 'Restante';

  @override
  String daysLeft(int n) {
    return '$n d.';
  }

  @override
  String get expired => 'Expirado';

  @override
  String get paymentsTitle => 'Pagos';

  @override
  String get noPayments => 'Sin pagos';

  @override
  String get addFirstPayment => 'Toca «Agregar» para registrar el primer pago';

  @override
  String get newPayment => 'Nuevo pago';

  @override
  String get selectTenant => 'Seleccionar inquilino';

  @override
  String get amount => 'Monto';

  @override
  String get status => 'Estado';

  @override
  String get date => 'Fecha';

  @override
  String get addPayment => 'Agregar pago';

  @override
  String get markAsPaid => 'Marcar como pagado';

  @override
  String get paymentTypeRent => 'Alquiler';

  @override
  String get paymentTypeDeposit => 'Depósito';

  @override
  String get paymentTypeUtility => 'Servicios';

  @override
  String get paymentTypeOther => 'Otro';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusPaid => 'Pagado';

  @override
  String get statusOverdue => 'Vencido';

  @override
  String get expensesTitle => 'Gastos';

  @override
  String get noExpenses => 'Sin gastos';

  @override
  String get addFirstExpense => 'Toca «Agregar» para registrar un gasto';

  @override
  String get newExpense => 'Nuevo gasto';

  @override
  String get description => 'Descripción';

  @override
  String get descriptionHint => 'Reparación de fontanería';

  @override
  String get addExpense => 'Agregar gasto';

  @override
  String get categoryRepair => 'Reparación';

  @override
  String get categoryTax => 'Impuesto';

  @override
  String get categoryInsurance => 'Seguro';

  @override
  String get categoryUtility => 'Servicios';

  @override
  String get categoryManagement => 'Gestión';

  @override
  String get categoryOther => 'Otro';

  @override
  String get reportsTitle => 'Informes';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get yearlyIncome => 'Ingresos anuales';

  @override
  String get yearlyExpenses => 'Gastos anuales';

  @override
  String get netProfit => 'Ganancia neta';

  @override
  String get profit => 'Beneficio';

  @override
  String get loss => 'Pérdida';

  @override
  String get incomeExpensesByMonth => 'Ingresos y gastos por mes';

  @override
  String get noDataForYear => 'Sin datos para este año';

  @override
  String get byMonth => 'Por mes';

  @override
  String get month => 'Mes';

  @override
  String get expense => 'Gasto';

  @override
  String get net => 'Neto';

  @override
  String get incomeTooltip => 'Ingreso';

  @override
  String get expenseTooltip => 'Gasto';

  @override
  String get chartMonthAbbr => 'E,F,M,A,M,J,J,A,S,O,N,D';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get appearance => 'Apariencia';

  @override
  String get aboutApp => 'Acerca de';

  @override
  String get versionLabel => 'Versión';

  @override
  String get propertyLimit => 'Límite de propiedades';

  @override
  String propertyLimitValue(int n) {
    return '$n (Gratis)';
  }

  @override
  String get contactDeveloper => 'Contactar al desarrollador';

  @override
  String get rateApp => 'Calificar la app';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get notificationsSection => 'Notificaciones';

  @override
  String get enableNotifications => 'Activar notificaciones';

  @override
  String get permissionRequested => 'Permiso solicitado';

  @override
  String get dataSection => 'Datos';

  @override
  String get backupToGoogleDrive => 'Copia de seguridad en Google Drive';

  @override
  String get restoreFromBackup => 'Restaurar desde copia de seguridad';

  @override
  String get restoreDataTitle => '¿Restaurar datos?';

  @override
  String get restoreDataMessage =>
      'Los datos actuales serán reemplazados con datos de Google Drive.';

  @override
  String get restore => 'Restaurar';

  @override
  String get googleSignInFailed => 'Error al iniciar sesión en Google';

  @override
  String get backupSaved => 'Copia de seguridad guardada en Google Drive';

  @override
  String get backupFailed => 'Error en la copia de seguridad';

  @override
  String get dataRestored =>
      'Datos restaurados. Por favor reinicia la aplicación.';

  @override
  String get backupNotFound => 'Copia de seguridad no encontrada';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get currency => 'Moneda';

  @override
  String get proDescription =>
      'Hasta 10 propiedades, informes PDF y copia en la nube';

  @override
  String get proCta => 'Prueba por \$2.99/mes';

  @override
  String get perMonth => '/mes';

  @override
  String get proCtaYearly => 'o \$24.99/año';

  @override
  String get deleteExpenseTitle => '¿Eliminar gasto?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» será eliminado.';
  }

  @override
  String get biometricSection => 'Seguridad';

  @override
  String get enableBiometric => 'Desbloquear con huella';

  @override
  String get proFeatureMessage => 'Disponible en versión PRO';

  @override
  String get splashPhrases =>
      'Control de alquiler\nen sus manos|Gestione sus alquileres —\nfácil y con confianza|Cada pago\nbajo control|Sus propiedades\nsiempre a mano|Gestione más inteligente —\ngane más|Alquiler sin caos|Su gestor personal\nde propiedades|Conozca todo\nsobre su alquiler|Los ingresos crecen —\ngastos bajo control|Alquiler como negocio —\ncon RentFlow';
}
