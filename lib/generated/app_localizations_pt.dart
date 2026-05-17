// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => 'Visão geral';

  @override
  String get navProperties => 'Imóveis';

  @override
  String get navTenants => 'Inquilinos';

  @override
  String get navPayments => 'Pagamentos';

  @override
  String get navExpenses => 'Despesas';

  @override
  String get navReports => 'Relatórios';

  @override
  String get add => 'Adicionar';

  @override
  String get save => 'Salvar';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get delete => 'Excluir';

  @override
  String get edit => 'Editar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get invalidNumber => 'Número inválido';

  @override
  String get select => 'Selecionar';

  @override
  String get seeAll => 'Todos';

  @override
  String get tapToStart => 'Toque em «Adicionar» para começar';

  @override
  String get income => 'Receitas';

  @override
  String get expenses => 'Despesas';

  @override
  String get netIncome => 'Renda líquida';

  @override
  String get addFirstProperty => 'Adicione seu primeiro imóvel';

  @override
  String get noActiveTenants => 'Nenhum inquilino ativo';

  @override
  String overduePaymentsCount(int count) {
    return 'Pagamentos em atraso: $count';
  }

  @override
  String get requiresAttention => 'Requer atenção';

  @override
  String get view => 'Ver';

  @override
  String get propertiesTitle => 'Imóveis';

  @override
  String get noProperties => 'Nenhum imóvel';

  @override
  String get deletePropertyTitle => 'Excluir imóvel?';

  @override
  String deletePropertyMessage(String name) {
    return '«$name» será excluído permanentemente.';
  }

  @override
  String get newProperty => 'Novo imóvel';

  @override
  String get editProperty => 'Editar imóvel';

  @override
  String get addProperty => 'Adicionar imóvel';

  @override
  String get propertyName => 'Nome';

  @override
  String get propertyNameHint => 'Apartamento na Rua Principal';

  @override
  String get propertyAddress => 'Endereço';

  @override
  String get addressHint => 'Rua Principal 1, apto. 25';

  @override
  String get propertyType => 'Tipo de imóvel';

  @override
  String get propertyArea => 'Área, m²';

  @override
  String get purchasePrice => 'Preço de compra';

  @override
  String get notes => 'Notas';

  @override
  String get notesHint => 'Informações adicionais...';

  @override
  String get typeApartment => 'Apartamento';

  @override
  String get typeHouse => 'Casa';

  @override
  String get typeRoom => 'Quarto';

  @override
  String get tenantsTitle => 'Inquilinos';

  @override
  String get noTenants => 'Nenhum inquilino';

  @override
  String get deleteTenantTitle => 'Excluir inquilino?';

  @override
  String deleteTenantMessage(String name) {
    return '$name será excluído.';
  }

  @override
  String get newTenant => 'Novo inquilino';

  @override
  String get editTenant => 'Editar inquilino';

  @override
  String get addTenant => 'Adicionar inquilino';

  @override
  String get personalInfo => 'Dados pessoais';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Sobrenome';

  @override
  String get phone => 'Telefone';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => 'Imóvel';

  @override
  String get selectProperty => 'Selecionar imóvel';

  @override
  String get leaseTerms => 'Termos do arrendamento';

  @override
  String get rentPerMonth => 'Aluguel, /mês';

  @override
  String get depositLabel => 'Depósito';

  @override
  String paymentDayPickerLabel(int day) {
    return 'Dia de pagamento: $day';
  }

  @override
  String paymentDayValue(int day) {
    return 'Dia $day';
  }

  @override
  String get leaseStart => 'Início do arrendamento';

  @override
  String get leaseEnd => 'Fim do arrendamento';

  @override
  String get indefinite => 'Indeterminado';

  @override
  String get rent => 'Aluguel';

  @override
  String get paymentDay => 'Dia de pagamento';

  @override
  String get remaining => 'Restante';

  @override
  String daysLeft(int n) {
    return '$n d.';
  }

  @override
  String get expired => 'Expirado';

  @override
  String get paymentsTitle => 'Pagamentos';

  @override
  String get noPayments => 'Nenhum pagamento';

  @override
  String get addFirstPayment =>
      'Toque em «Adicionar» para registrar o primeiro pagamento';

  @override
  String get newPayment => 'Novo pagamento';

  @override
  String get selectTenant => 'Selecionar inquilino';

  @override
  String get amount => 'Valor';

  @override
  String get status => 'Status';

  @override
  String get date => 'Data';

  @override
  String get addPayment => 'Adicionar pagamento';

  @override
  String get markAsPaid => 'Marcar como pago';

  @override
  String get paymentTypeRent => 'Aluguel';

  @override
  String get paymentTypeDeposit => 'Depósito';

  @override
  String get paymentTypeUtility => 'Serviços';

  @override
  String get paymentTypeOther => 'Outro';

  @override
  String get statusPending => 'Pendente';

  @override
  String get statusPaid => 'Pago';

  @override
  String get statusOverdue => 'Em atraso';

  @override
  String get expensesTitle => 'Despesas';

  @override
  String get noExpenses => 'Nenhuma despesa';

  @override
  String get addFirstExpense =>
      'Toque em «Adicionar» para registrar uma despesa';

  @override
  String get newExpense => 'Nova despesa';

  @override
  String get description => 'Descrição';

  @override
  String get descriptionHint => 'Reparação de canalização';

  @override
  String get addExpense => 'Adicionar despesa';

  @override
  String get categoryRepair => 'Reparação';

  @override
  String get categoryTax => 'Imposto';

  @override
  String get categoryInsurance => 'Seguro';

  @override
  String get categoryUtility => 'Serviços';

  @override
  String get categoryManagement => 'Gestão';

  @override
  String get categoryOther => 'Outro';

  @override
  String get reportsTitle => 'Relatórios';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get yearlyIncome => 'Receita anual';

  @override
  String get yearlyExpenses => 'Despesas anuais';

  @override
  String get netProfit => 'Lucro líquido';

  @override
  String get profit => 'Lucro';

  @override
  String get loss => 'Prejuízo';

  @override
  String get incomeExpensesByMonth => 'Receitas e despesas por mês';

  @override
  String get noDataForYear => 'Sem dados para este ano';

  @override
  String get byMonth => 'Por mês';

  @override
  String get month => 'Mês';

  @override
  String get expense => 'Despesa';

  @override
  String get net => 'Líquido';

  @override
  String get incomeTooltip => 'Receita';

  @override
  String get expenseTooltip => 'Despesa';

  @override
  String get chartMonthAbbr => 'J,F,M,A,M,J,J,A,S,O,N,D';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get appearance => 'Aparência';

  @override
  String get aboutApp => 'Sobre';

  @override
  String get versionLabel => 'Versão';

  @override
  String get propertyLimit => 'Limite de imóveis';

  @override
  String propertyLimitValue(int n) {
    return '$n (Grátis)';
  }

  @override
  String get contactDeveloper => 'Contatar o desenvolvedor';

  @override
  String get rateApp => 'Avaliar o app';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get notificationsSection => 'Notificações';

  @override
  String get enableNotifications => 'Ativar notificações';

  @override
  String get permissionRequested => 'Permissão solicitada';

  @override
  String get dataSection => 'Dados';

  @override
  String get backupToGoogleDrive => 'Backup no Google Drive';

  @override
  String get restoreFromBackup => 'Restaurar do backup';

  @override
  String get restoreDataTitle => 'Restaurar dados?';

  @override
  String get restoreDataMessage =>
      'Os dados atuais serão substituídos pelos dados do Google Drive.';

  @override
  String get restore => 'Restaurar';

  @override
  String get googleSignInFailed => 'Falha ao fazer login no Google';

  @override
  String get backupSaved => 'Backup salvo no Google Drive';

  @override
  String get backupFailed => 'Falha no backup';

  @override
  String get dataRestored =>
      'Dados restaurados. Por favor reinicie o aplicativo.';

  @override
  String get backupNotFound => 'Backup não encontrado';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get currency => 'Moeda';

  @override
  String get proDescription =>
      'Até 10 imóveis, relatórios PDF e backup na nuvem';

  @override
  String get proCta => 'Experimente por \$2,99/mês';

  @override
  String get perMonth => '/mês';

  @override
  String get proCtaYearly => 'ou \$24,99/ano';

  @override
  String get deleteExpenseTitle => 'Excluir despesa?';

  @override
  String deleteExpenseMessage(String name) {
    return '«$name» será excluído.';
  }

  @override
  String get biometricSection => 'Segurança';

  @override
  String get enableBiometric => 'Desbloquear com digital';

  @override
  String get proFeatureMessage => 'Disponível na versão PRO';

  @override
  String get splashPhrases =>
      'Controle de aluguel\nnas suas mãos|Acompanhe seus aluguéis —\nde forma simples|Cada pagamento\nsob controle|Seus imóveis\nsempre à mão|Gerencie com mais inteligência —\nganhe mais|Aluguel sem caos|Seu gerente pessoal\nde imóveis|Saiba tudo\nsobre seu aluguel|A renda cresce —\nos gastos sob controle|Aluguel como negócio —\ncom RentFlow';
}
