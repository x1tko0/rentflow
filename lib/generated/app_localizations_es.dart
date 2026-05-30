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
  String get proSection => 'Funciones Pro';

  @override
  String get backupToGoogleDrive => 'Copia de seguridad en Google Drive';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restorePurchasesSuccess => 'Compras restauradas';

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
  String get dataRestored => 'Datos restaurados correctamente';

  @override
  String get backupNotFound => 'Copia de seguridad no encontrada';

  @override
  String get restartApp => 'Reiniciar';

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
      'Hasta 20 propiedades, informes PDF y copia en la nube';

  @override
  String get proCta => 'Prueba por \$6.99/mes';

  @override
  String get perMonth => '/mes';

  @override
  String get proCtaYearly => 'o \$59.99/año';

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
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingStart => 'Empezar';

  @override
  String get onboarding1Title => 'Bienvenido a RentFlow';

  @override
  String get onboarding1Body =>
      'Gestión de alquileres sencilla para propietarios privados';

  @override
  String get onboarding2Title => 'Propiedades & Inquilinos';

  @override
  String get onboarding2Body => 'Agrega propiedades e inquilinos en segundos';

  @override
  String get onboarding3Title => 'Pagos & Reportes';

  @override
  String get onboarding3Body =>
      'Rastrea ingresos, gastos y pagos vencidos en tiempo real';

  @override
  String get notificationPaymentTitle => 'Recordatorio de pago';

  @override
  String get notificationLeaseEndTitle => 'Contrato próximo a vencer';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — contrato termina el $date';
  }

  @override
  String get pdfReportTitlePrefix => 'Informe financiero de';

  @override
  String get pdfSummary => 'Resumen';

  @override
  String get pdfByMonths => 'Por mes';

  @override
  String get pdfNet => 'Neto';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfGeneratedBy => 'Generado en RentFlow';

  @override
  String get paymentHistory => 'Historial de pagos';

  @override
  String get totalPaid => 'Total pagado';

  @override
  String get thisMonth => 'Este mes';

  @override
  String get allTime => 'Todo el tiempo';

  @override
  String get search => 'Buscar';

  @override
  String get searchHint => 'Buscar por nombre o teléfono…';

  @override
  String get noResults => 'Sin resultados';

  @override
  String get propertyDetails => 'Detalles del inmueble';

  @override
  String get recurringExpenses => 'Gastos recurrentes';

  @override
  String get repeatMonthly => 'Repetir mensualmente';

  @override
  String get repeatDay => 'Día del mes';

  @override
  String get recurringExpenseHint =>
      'Se crea automáticamente cada mes en este día';

  @override
  String get noRecurringExpenses => 'Sin gastos recurrentes';

  @override
  String get addRecurringExpense => 'Agregar plantilla';

  @override
  String get proFeatureRecurring =>
      'Los gastos recurrentes son una función Pro';

  @override
  String get customCategories => 'Categorías personalizadas';

  @override
  String get addCategory => 'Agregar categoría';

  @override
  String get categoryName => 'Nombre de categoría';

  @override
  String get yourCategories => 'Sus categorías';

  @override
  String get proFeatureCategories =>
      'Las categorías personalizadas son una función Pro';

  @override
  String get meterReadings => 'Lecturas de medidores';

  @override
  String get addReading => 'Agregar lectura';

  @override
  String get lastReading => 'Última lectura';

  @override
  String get consumption => 'Consumo';

  @override
  String get noReadings => 'Sin lecturas aún';

  @override
  String get meterWaterCold => 'Agua fría';

  @override
  String get meterWaterHot => 'Agua caliente';

  @override
  String get meterGas => 'Gas';

  @override
  String get meterElectricity => 'Electricidad';

  @override
  String get meterHeat => 'Calor';

  @override
  String get meterElectricityT1 => 'Electricidad T1 (Día)';

  @override
  String get meterElectricityT2 => 'Electricidad T2 (Noche)';

  @override
  String get meterElectricityT3 => 'Electricidad T3 (Tarde)';

  @override
  String get meterHistory => 'Historial de lecturas';

  @override
  String get meterPdfTitle => 'Informe de lecturas de contadores';

  @override
  String get meterPdfPrevious => 'Anterior';

  @override
  String get meterPdfCurrent => 'Actual';

  @override
  String get meterPdfElecTotal => 'Electricidad (total)';

  @override
  String get meterPdfTotalConsumption => 'Consumo total';

  @override
  String get meterPdfGeneratedBy => 'Generado por RentFlow';

  @override
  String get customType => 'Tipo personalizado';

  @override
  String get editReading => 'Editar';

  @override
  String get typeName => 'Nombre del tipo';

  @override
  String get selectPeriod => 'Seleccionar período';

  @override
  String get pdfPeriod => 'Período';

  @override
  String get readingValue => 'Valor del medidor';

  @override
  String get notifyDaysBefore => 'Recordar antes (días)';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get csvCopied => 'CSV copiado al portapapeles';

  @override
  String get faqTitle => 'FAQ & Ayuda';

  @override
  String get faqHowToUseTab => 'Cómo usar';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Primeros pasos';

  @override
  String get faqStep1Title => 'Añadir inmueble';

  @override
  String get faqStep1Body =>
      'Ve a «Inmuebles» → «+» e introduce nombre, dirección y tipo.';

  @override
  String get faqStep2Title => 'Añadir inquilino';

  @override
  String get faqStep2Body =>
      'En «Inquilinos» → «+» introduce datos, selecciona el inmueble y establece alquiler y día de pago.';

  @override
  String get faqStep3Title => 'Registrar pagos';

  @override
  String get faqStep3Body =>
      'En «Pagos» → «+» añade un pago. Desliza a la derecha para marcarlo como pagado.';

  @override
  String get faqStep4Title => 'Seguir gastos';

  @override
  String get faqStep4Body =>
      'En «Gastos» → «+» añade un gasto, vincúlalo al inmueble y elige categoría.';

  @override
  String get faqStep5Title => 'Ver informes';

  @override
  String get faqStep5Body =>
      '«Informes» muestra ingresos anuales, gastos y beneficio neto con gráfico y tabla mensual.';

  @override
  String get faqTipsTitle => 'Consejos';

  @override
  String get faqTip1 =>
      'Desliza a la derecha un pago para marcarlo pagado sin abrir el formulario.';

  @override
  String get faqTip2 =>
      'Toca una tarjeta de inquilino o inmueble para ver detalles e historial.';

  @override
  String get faqTip3 =>
      'Cambia a la vista de calendario en Pagos para ver pagos por fecha.';

  @override
  String get faqProProperties => 'Hasta 20 propiedades';

  @override
  String get faqProNotifications => 'Notificaciones personalizadas';

  @override
  String get faqProRecurring => 'Gastos recurrentes';

  @override
  String get splashPhrases =>
      'Control de alquiler\nen sus manos|Gestione sus alquileres —\nfácil y con confianza|Cada pago\nbajo control|Sus propiedades\nsiempre a mano|Gestione más inteligente —\ngane más|Alquiler sin caos|Su gestor personal\nde propiedades|Conozca todo\nsobre su alquiler|Los ingresos crecen —\ngastos bajo control|Alquiler como negocio —\ncon RentFlow';
}
