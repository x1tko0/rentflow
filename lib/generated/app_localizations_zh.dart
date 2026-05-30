// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => '概览';

  @override
  String get navProperties => '房产';

  @override
  String get navTenants => '租客';

  @override
  String get navPayments => '收款';

  @override
  String get navExpenses => '支出';

  @override
  String get navReports => '报表';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get saveChanges => '保存更改';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get cancel => '取消';

  @override
  String get requiredField => '必填项';

  @override
  String get invalidNumber => '无效数字';

  @override
  String get select => '选择';

  @override
  String get seeAll => '全部';

  @override
  String get tapToStart => '点击「添加」开始使用';

  @override
  String get income => '收入';

  @override
  String get expenses => '支出';

  @override
  String get netIncome => '净收入';

  @override
  String get addFirstProperty => '添加您的第一个房产';

  @override
  String get noActiveTenants => '暂无活跃租客';

  @override
  String overduePaymentsCount(int count) {
    return '逾期付款：$count笔';
  }

  @override
  String get requiresAttention => '需要关注';

  @override
  String get view => '查看';

  @override
  String get propertiesTitle => '房产';

  @override
  String get noProperties => '暂无房产';

  @override
  String get deletePropertyTitle => '删除房产？';

  @override
  String deletePropertyMessage(String name) {
    return '「$name」将被永久删除。';
  }

  @override
  String get newProperty => '新建房产';

  @override
  String get editProperty => '编辑房产';

  @override
  String get addProperty => '添加房产';

  @override
  String get propertyName => '名称';

  @override
  String get propertyNameHint => '中山路25号公寓';

  @override
  String get propertyAddress => '地址';

  @override
  String get addressHint => '中山路1号，25室';

  @override
  String get propertyType => '房产类型';

  @override
  String get propertyArea => '面积，㎡';

  @override
  String get purchasePrice => '购买价格';

  @override
  String get notes => '备注';

  @override
  String get notesHint => '其他信息...';

  @override
  String get typeApartment => '公寓';

  @override
  String get typeHouse => '独栋';

  @override
  String get typeRoom => '单间';

  @override
  String get tenantsTitle => '租客';

  @override
  String get noTenants => '暂无租客';

  @override
  String get deleteTenantTitle => '删除租客？';

  @override
  String deleteTenantMessage(String name) {
    return '将删除 $name。';
  }

  @override
  String get newTenant => '新建租客';

  @override
  String get editTenant => '编辑租客';

  @override
  String get addTenant => '添加租客';

  @override
  String get personalInfo => '个人信息';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get phone => '电话';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => '房产';

  @override
  String get selectProperty => '选择房产';

  @override
  String get leaseTerms => '租约条款';

  @override
  String get rentPerMonth => '月租金';

  @override
  String get depositLabel => '押金';

  @override
  String paymentDayPickerLabel(int day) {
    return '付款日：$day号';
  }

  @override
  String paymentDayValue(int day) {
    return '$day号';
  }

  @override
  String get leaseStart => '租约开始';

  @override
  String get leaseEnd => '租约结束';

  @override
  String get indefinite => '不限期';

  @override
  String get rent => '租金';

  @override
  String get paymentDay => '付款日';

  @override
  String get remaining => '剩余';

  @override
  String daysLeft(int n) {
    return '$n天';
  }

  @override
  String get expired => '已到期';

  @override
  String get paymentsTitle => '收款';

  @override
  String get noPayments => '暂无收款记录';

  @override
  String get addFirstPayment => '点击「添加」记录第一笔收款';

  @override
  String get newPayment => '新建收款';

  @override
  String get selectTenant => '选择租客';

  @override
  String get amount => '金额';

  @override
  String get status => '状态';

  @override
  String get date => '日期';

  @override
  String get addPayment => '添加收款';

  @override
  String get markAsPaid => '标记已付';

  @override
  String get paymentTypeRent => '租金';

  @override
  String get paymentTypeDeposit => '押金';

  @override
  String get paymentTypeUtility => '水电费';

  @override
  String get paymentTypeOther => '其他';

  @override
  String get statusPending => '待付';

  @override
  String get statusPaid => '已付';

  @override
  String get statusOverdue => '逾期';

  @override
  String get expensesTitle => '支出';

  @override
  String get noExpenses => '暂无支出记录';

  @override
  String get addFirstExpense => '点击「添加」记录支出';

  @override
  String get newExpense => '新建支出';

  @override
  String get description => '描述';

  @override
  String get descriptionHint => '管道维修';

  @override
  String get addExpense => '添加支出';

  @override
  String get categoryRepair => '维修';

  @override
  String get categoryTax => '税费';

  @override
  String get categoryInsurance => '保险';

  @override
  String get categoryUtility => '水电';

  @override
  String get categoryManagement => '管理费';

  @override
  String get categoryOther => '其他';

  @override
  String get reportsTitle => '报表';

  @override
  String get exportPdf => '导出PDF';

  @override
  String get yearlyIncome => '年度收入';

  @override
  String get yearlyExpenses => '年度支出';

  @override
  String get netProfit => '净利润';

  @override
  String get profit => '盈利';

  @override
  String get loss => '亏损';

  @override
  String get incomeExpensesByMonth => '月度收支对比';

  @override
  String get noDataForYear => '本年度暂无数据';

  @override
  String get byMonth => '按月';

  @override
  String get month => '月份';

  @override
  String get expense => '支出';

  @override
  String get net => '净额';

  @override
  String get incomeTooltip => '收入';

  @override
  String get expenseTooltip => '支出';

  @override
  String get chartMonthAbbr => '1,2,3,4,5,6,7,8,9,10,11,12';

  @override
  String get settingsTitle => '设置';

  @override
  String get appearance => '外观';

  @override
  String get aboutApp => '关于';

  @override
  String get versionLabel => '版本';

  @override
  String get propertyLimit => '房产限制';

  @override
  String propertyLimitValue(int n) {
    return '$n（免费）';
  }

  @override
  String get contactDeveloper => '联系开发者';

  @override
  String get rateApp => '给我们评分';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get notificationsSection => '通知';

  @override
  String get enableNotifications => '启用通知';

  @override
  String get permissionRequested => '已请求权限';

  @override
  String get dataSection => '数据';

  @override
  String get proSection => 'Pro功能';

  @override
  String get backupToGoogleDrive => '备份到Google云端';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get restorePurchasesSuccess => '购买已恢复';

  @override
  String get restoreFromBackup => '从备份恢复';

  @override
  String get restoreDataTitle => '恢复数据？';

  @override
  String get restoreDataMessage => '当前数据将被Google云端数据替换。';

  @override
  String get restore => '恢复';

  @override
  String get googleSignInFailed => 'Google登录失败';

  @override
  String get backupSaved => '备份已保存到Google云端';

  @override
  String get backupFailed => '备份失败';

  @override
  String get dataRestored => '数据已恢复，请重启应用。';

  @override
  String get backupNotFound => '未找到备份';

  @override
  String get restartApp => '重启';

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get currency => '货币';

  @override
  String get proDescription => '最多20个房产，PDF报表和云备份';

  @override
  String get proCta => '试用 \$6.99/月';

  @override
  String get perMonth => '/月';

  @override
  String get proCtaYearly => '或 \$59.99/年';

  @override
  String get deleteExpenseTitle => '删除支出？';

  @override
  String deleteExpenseMessage(String name) {
    return '「$name」将被删除。';
  }

  @override
  String get biometricSection => '安全';

  @override
  String get enableBiometric => '指纹解锁';

  @override
  String get proFeatureMessage => '此功能需要PRO版本';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingStart => '开始使用';

  @override
  String get onboarding1Title => '欢迎使用RentFlow';

  @override
  String get onboarding1Body => '为私人房东打造的简单租房管理工具';

  @override
  String get onboarding2Title => '房产与租客';

  @override
  String get onboarding2Body => '几秒钟内添加您的房产和租客信息';

  @override
  String get onboarding3Title => '收款与报表';

  @override
  String get onboarding3Body => '实时追踪收入、支出和逾期付款';

  @override
  String get notificationPaymentTitle => '付款提醒';

  @override
  String get notificationLeaseEndTitle => '租约即将到期';

  @override
  String notificationLeaseEndBody(String name, String date) {
    return '$name — 租约到期日 $date';
  }

  @override
  String get pdfReportTitlePrefix => '财务报告';

  @override
  String get pdfSummary => '摘要';

  @override
  String get pdfByMonths => '按月统计';

  @override
  String get pdfNet => '净额';

  @override
  String get pdfTotal => '合计';

  @override
  String get pdfGeneratedBy => '由RentFlow生成';

  @override
  String get paymentHistory => '付款记录';

  @override
  String get totalPaid => '累计已付';

  @override
  String get thisMonth => '本月';

  @override
  String get allTime => '全部时间';

  @override
  String get search => '搜索';

  @override
  String get searchHint => '按姓名或电话搜索…';

  @override
  String get noResults => '未找到结果';

  @override
  String get propertyDetails => '房产详情';

  @override
  String get recurringExpenses => '定期支出';

  @override
  String get repeatMonthly => '每月重复';

  @override
  String get repeatDay => '月中日期';

  @override
  String get recurringExpenseHint => '每月此日自动创建';

  @override
  String get noRecurringExpenses => '暂无定期支出';

  @override
  String get addRecurringExpense => '添加模板';

  @override
  String get proFeatureRecurring => '定期支出为PRO功能';

  @override
  String get customCategories => '自定义分类';

  @override
  String get addCategory => '添加分类';

  @override
  String get categoryName => '分类名称';

  @override
  String get yourCategories => '我的分类';

  @override
  String get proFeatureCategories => '自定义分类为PRO功能';

  @override
  String get meterReadings => '仪表读数';

  @override
  String get addReading => '添加读数';

  @override
  String get lastReading => '上次读数';

  @override
  String get consumption => '用量';

  @override
  String get noReadings => '暂无读数';

  @override
  String get meterWaterCold => '冷水';

  @override
  String get meterWaterHot => '热水';

  @override
  String get meterGas => '燃气';

  @override
  String get meterElectricity => '电力';

  @override
  String get meterHeat => '暖气';

  @override
  String get meterElectricityT1 => '电力T1（白天）';

  @override
  String get meterElectricityT2 => '电力T2（夜间）';

  @override
  String get meterElectricityT3 => '电力T3（晚间）';

  @override
  String get meterHistory => '读数历史';

  @override
  String get meterPdfTitle => '仪表读数报告';

  @override
  String get meterPdfPrevious => '上期';

  @override
  String get meterPdfCurrent => '本期';

  @override
  String get meterPdfElecTotal => '电力（合计）';

  @override
  String get meterPdfTotalConsumption => '总用量';

  @override
  String get meterPdfGeneratedBy => '由RentFlow生成';

  @override
  String get customType => '自定义类型';

  @override
  String get editReading => '编辑读数';

  @override
  String get typeName => '类型名称';

  @override
  String get selectPeriod => '选择时间段';

  @override
  String get pdfPeriod => '时间段';

  @override
  String get readingValue => '仪表数值';

  @override
  String get notifyDaysBefore => '提前提醒（天）';

  @override
  String get exportCsv => '导出CSV';

  @override
  String get csvCopied => 'CSV已复制到剪贴板';

  @override
  String get faqTitle => '常见问题';

  @override
  String get faqHowToUseTab => '使用指南';

  @override
  String get faqProTab => 'PRO';

  @override
  String get faqGettingStarted => '快速开始';

  @override
  String get faqStep1Title => '添加房产';

  @override
  String get faqStep1Body => '点击「房产」→「+」，填写房产名称、地址和类型。';

  @override
  String get faqStep2Title => '添加租客';

  @override
  String get faqStep2Body => '在「租客」→「+」中填写信息，选择房产，设置月租金和付款日。';

  @override
  String get faqStep3Title => '记录收款';

  @override
  String get faqStep3Body => '打开「收款」→「+」记录收款。向右滑动任意行可快速标记为已付。';

  @override
  String get faqStep4Title => '追踪支出';

  @override
  String get faqStep4Body => '在「支出」→「+」中添加费用，关联房产并选择分类。';

  @override
  String get faqStep5Title => '查看报表';

  @override
  String get faqStep5Body => '「报表」显示年度收入、支出和净利润，含图表和月度明细。';

  @override
  String get faqTipsTitle => '使用技巧';

  @override
  String get faqTip1 => '向右滑动付款条目可快速标记为已付，无需打开表单。';

  @override
  String get faqTip2 => '点击租客或房产卡片可查看完整详情和历史记录。';

  @override
  String get faqTip3 => '在收款页面切换到日历视图，可按日期查看所有收款。';

  @override
  String get faqProProperties => '最多20个房产';

  @override
  String get faqProNotifications => '自定义提醒设置';

  @override
  String get faqProRecurring => '定期支出';

  @override
  String get splashPhrases =>
      '租房管理\n尽在掌握|轻松追踪\n您的租房收益|每笔收款\n清晰可见|您的房产\n随时随地|智慧管理\n收益更高|租房不再混乱|您的专属\n房产管家|掌握每个\n房产动态|收入增长\n支出可控|像经营事业\n一样管理租房';
}
