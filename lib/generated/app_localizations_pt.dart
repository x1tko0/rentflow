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
  String get proSection => 'Recursos Pro';

  @override
  String get backupToGoogleDrive => 'Backup no Google Drive';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restorePurchasesSuccess => 'Compras restauradas';

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
  String get dataRestored => 'Dados restaurados com sucesso';

  @override
  String get backupNotFound => 'Backup não encontrado';

  @override
  String get restartApp => 'Reiniciar';

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
      'Até 20 imóveis, relatórios PDF e backup na nuvem';

  @override
  String get proCta => 'Experimente por \$6,99/mês';

  @override
  String get perMonth => '/mês';

  @override
  String get proCtaYearly => 'ou \$59,99/ano';

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
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingStart => 'Começar';

  @override
  String get onboarding1Title => 'Bem-vindo ao RentFlow';

  @override
  String get onboarding1Body =>
      'Gestão simples de aluguel para proprietários privados';

  @override
  String get onboarding2Title => 'Imóveis & Inquilinos';

  @override
  String get onboarding2Body => 'Adicione imóveis e inquilinos em segundos';

  @override
  String get onboarding3Title => 'Pagamentos & Relatórios';

  @override
  String get onboarding3Body =>
      'Acompanhe receitas, despesas e pagamentos em atraso em tempo real';

  @override
  String get notificationPaymentTitle => 'Lembrete de pagamento';

  @override
  String get notificationLeaseEndTitle => 'Contrato prestes a expirar';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — contrato termina em $date';
  }

  @override
  String get pdfReportTitlePrefix => 'Relatório financeiro de';

  @override
  String get pdfSummary => 'Resumo';

  @override
  String get pdfByMonths => 'Por mês';

  @override
  String get pdfNet => 'Líquido';

  @override
  String get pdfTotal => 'Total';

  @override
  String get pdfGeneratedBy => 'Gerado no RentFlow';

  @override
  String get paymentHistory => 'Histórico de pagamentos';

  @override
  String get totalPaid => 'Total pago';

  @override
  String get thisMonth => 'Este mês';

  @override
  String get allTime => 'Todo o tempo';

  @override
  String get search => 'Pesquisar';

  @override
  String get searchHint => 'Pesquisar por nome ou telefone…';

  @override
  String get noResults => 'Sem resultados';

  @override
  String get propertyDetails => 'Detalhes do imóvel';

  @override
  String get recurringExpenses => 'Despesas recorrentes';

  @override
  String get repeatMonthly => 'Repetir mensalmente';

  @override
  String get repeatDay => 'Dia do mês';

  @override
  String get recurringExpenseHint =>
      'Criado automaticamente todo mês neste dia';

  @override
  String get noRecurringExpenses => 'Sem despesas recorrentes';

  @override
  String get addRecurringExpense => 'Adicionar modelo';

  @override
  String get proFeatureRecurring => 'Despesas recorrentes são um recurso Pro';

  @override
  String get customCategories => 'Categorias personalizadas';

  @override
  String get addCategory => 'Adicionar categoria';

  @override
  String get categoryName => 'Nome da categoria';

  @override
  String get yourCategories => 'Suas categorias';

  @override
  String get proFeatureCategories =>
      'Categorias personalizadas são um recurso Pro';

  @override
  String get meterReadings => 'Leituras de medidores';

  @override
  String get addReading => 'Adicionar leitura';

  @override
  String get lastReading => 'Última leitura';

  @override
  String get consumption => 'Consumo';

  @override
  String get noReadings => 'Sem leituras ainda';

  @override
  String get meterWaterCold => 'Água fria';

  @override
  String get meterWaterHot => 'Água quente';

  @override
  String get meterGas => 'Gás';

  @override
  String get meterElectricity => 'Eletricidade';

  @override
  String get meterHeat => 'Aquecimento';

  @override
  String get meterElectricityT1 => 'Eletricidade T1 (Dia)';

  @override
  String get meterElectricityT2 => 'Eletricidade T2 (Noite)';

  @override
  String get meterElectricityT3 => 'Eletricidade T3 (Tarde)';

  @override
  String get meterHistory => 'Histórico de leituras';

  @override
  String get meterPdfTitle => 'Relatório de leituras de medidores';

  @override
  String get meterPdfPrevious => 'Anterior';

  @override
  String get meterPdfCurrent => 'Atual';

  @override
  String get meterPdfElecTotal => 'Eletricidade (total)';

  @override
  String get meterPdfTotalConsumption => 'Consumo total';

  @override
  String get meterPdfGeneratedBy => 'Gerado por RentFlow';

  @override
  String get customType => 'Tipo personalizado';

  @override
  String get editReading => 'Editar';

  @override
  String get typeName => 'Nome do tipo';

  @override
  String get selectPeriod => 'Selecionar período';

  @override
  String get pdfPeriod => 'Período';

  @override
  String get readingValue => 'Valor do medidor';

  @override
  String get notifyDaysBefore => 'Lembrar antes (dias)';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get csvCopied => 'CSV copiado para a área de transferência';

  @override
  String get faqTitle => 'FAQ & Ajuda';

  @override
  String get faqHowToUseTab => 'Como usar';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => 'Primeiros passos';

  @override
  String get faqStep1Title => 'Adicionar imóvel';

  @override
  String get faqStep1Body =>
      'Vá em «Imóveis» → «+» e preencha nome, endereço e tipo.';

  @override
  String get faqStep2Title => 'Adicionar inquilino';

  @override
  String get faqStep2Body =>
      'Em «Inquilinos» → «+» insira os dados, selecione o imóvel e defina aluguel e dia de pagamento.';

  @override
  String get faqStep3Title => 'Registrar pagamentos';

  @override
  String get faqStep3Body =>
      'Em «Pagamentos» → «+» adicione um pagamento. Deslize à direita para marcá-lo como pago.';

  @override
  String get faqStep4Title => 'Rastrear despesas';

  @override
  String get faqStep4Body =>
      'Em «Despesas» → «+» adicione um custo, vincule ao imóvel e escolha a categoria.';

  @override
  String get faqStep5Title => 'Ver relatórios';

  @override
  String get faqStep5Body =>
      '«Relatórios» exibe renda anual, despesas e lucro líquido com gráfico e tabela mensal.';

  @override
  String get faqTipsTitle => 'Dicas';

  @override
  String get faqTip1 =>
      'Deslize à direita em um pagamento para marcá-lo pago sem abrir o formulário.';

  @override
  String get faqTip2 =>
      'Toque em um cartão de inquilino ou imóvel para ver detalhes e histórico.';

  @override
  String get faqTip3 =>
      'Mude para a vista de calendário em Pagamentos para ver os pagamentos por data.';

  @override
  String get faqProProperties => 'Até 20 propriedades';

  @override
  String get faqProNotifications => 'Notificações personalizadas';

  @override
  String get faqProRecurring => 'Despesas recorrentes';

  @override
  String get splashPhrases =>
      'Controle de aluguel\nnas suas mãos|Acompanhe seus aluguéis —\nde forma simples|Cada pagamento\nsob controle|Seus imóveis\nsempre à mão|Gerencie com mais inteligência —\nganhe mais|Aluguel sem caos|Seu gerente pessoal\nde imóveis|Saiba tudo\nsobre seu aluguel|A renda cresce —\nos gastos sob controle|Aluguel como negócio —\ncom RentFlow';
}
