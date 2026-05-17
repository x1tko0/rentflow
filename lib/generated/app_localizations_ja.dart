// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'RentFlow';

  @override
  String get navDashboard => '概要';

  @override
  String get navProperties => '物件';

  @override
  String get navTenants => '賃借人';

  @override
  String get navPayments => '支払い';

  @override
  String get navExpenses => '経費';

  @override
  String get navReports => 'レポート';

  @override
  String get add => '追加';

  @override
  String get save => '保存';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get delete => '削除';

  @override
  String get edit => '編集';

  @override
  String get cancel => 'キャンセル';

  @override
  String get requiredField => '必須項目';

  @override
  String get invalidNumber => '無効な数値';

  @override
  String get select => '選択';

  @override
  String get seeAll => 'すべて';

  @override
  String get tapToStart => '「追加」をタップして開始';

  @override
  String get income => '収入';

  @override
  String get expenses => '支出';

  @override
  String get netIncome => '純収入';

  @override
  String get addFirstProperty => '最初の物件を追加';

  @override
  String get noActiveTenants => 'アクティブな賃借人なし';

  @override
  String overduePaymentsCount(int count) {
    return '延滞支払: $count';
  }

  @override
  String get requiresAttention => '注意が必要';

  @override
  String get view => '表示';

  @override
  String get propertiesTitle => '物件';

  @override
  String get noProperties => '物件なし';

  @override
  String get deletePropertyTitle => '物件を削除しますか？';

  @override
  String deletePropertyMessage(String name) {
    return '「$name」は完全に削除されます。';
  }

  @override
  String get newProperty => '新しい物件';

  @override
  String get editProperty => '物件を編集';

  @override
  String get addProperty => '物件を追加';

  @override
  String get propertyName => '名称';

  @override
  String get propertyNameHint => 'メインストリートのアパート';

  @override
  String get propertyAddress => '住所';

  @override
  String get addressHint => 'メインストリート1番地25号室';

  @override
  String get propertyType => '物件タイプ';

  @override
  String get propertyArea => '面積、m²';

  @override
  String get purchasePrice => '購入価格';

  @override
  String get notes => 'メモ';

  @override
  String get notesHint => '追加情報...';

  @override
  String get typeApartment => 'アパート';

  @override
  String get typeHouse => '一戸建て';

  @override
  String get typeRoom => '部屋';

  @override
  String get tenantsTitle => '賃借人';

  @override
  String get noTenants => '賃借人なし';

  @override
  String get deleteTenantTitle => '賃借人を削除しますか？';

  @override
  String deleteTenantMessage(String name) {
    return '$nameが削除されます。';
  }

  @override
  String get newTenant => '新しい賃借人';

  @override
  String get editTenant => '賃借人を編集';

  @override
  String get addTenant => '賃借人を追加';

  @override
  String get personalInfo => '個人情報';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get phone => '電話';

  @override
  String get emailHint => 'example@gmail.com';

  @override
  String get propertySection => '物件';

  @override
  String get selectProperty => '物件を選択';

  @override
  String get leaseTerms => 'リース条件';

  @override
  String get rentPerMonth => '家賃、/月';

  @override
  String get depositLabel => '保証金';

  @override
  String paymentDayPickerLabel(int day) {
    return '支払日: $day日';
  }

  @override
  String paymentDayValue(int day) {
    return '$day日';
  }

  @override
  String get leaseStart => 'リース開始';

  @override
  String get leaseEnd => 'リース終了';

  @override
  String get indefinite => '無期限';

  @override
  String get rent => '家賃';

  @override
  String get paymentDay => '支払日';

  @override
  String get remaining => '残り';

  @override
  String daysLeft(int n) {
    return '$n日';
  }

  @override
  String get expired => '期限切れ';

  @override
  String get paymentsTitle => '支払い';

  @override
  String get noPayments => '支払いなし';

  @override
  String get addFirstPayment => '「追加」をタップして最初の支払いを記録';

  @override
  String get newPayment => '新しい支払い';

  @override
  String get selectTenant => '賃借人を選択';

  @override
  String get amount => '金額';

  @override
  String get status => 'ステータス';

  @override
  String get date => '日付';

  @override
  String get addPayment => '支払いを追加';

  @override
  String get markAsPaid => '支払済みにする';

  @override
  String get paymentTypeRent => '家賃';

  @override
  String get paymentTypeDeposit => '保証金';

  @override
  String get paymentTypeUtility => '光熱費';

  @override
  String get paymentTypeOther => 'その他';

  @override
  String get statusPending => '保留中';

  @override
  String get statusPaid => '支払済み';

  @override
  String get statusOverdue => '延滞';

  @override
  String get expensesTitle => '経費';

  @override
  String get noExpenses => '経費なし';

  @override
  String get addFirstExpense => '「追加」をタップして経費を記録';

  @override
  String get newExpense => '新しい経費';

  @override
  String get description => '説明';

  @override
  String get descriptionHint => '配管修理';

  @override
  String get addExpense => '経費を追加';

  @override
  String get categoryRepair => '修繕';

  @override
  String get categoryTax => '税金';

  @override
  String get categoryInsurance => '保険';

  @override
  String get categoryUtility => '光熱費';

  @override
  String get categoryManagement => '管理';

  @override
  String get categoryOther => 'その他';

  @override
  String get reportsTitle => 'レポート';

  @override
  String get exportPdf => 'PDFエクスポート';

  @override
  String get yearlyIncome => '年間収入';

  @override
  String get yearlyExpenses => '年間支出';

  @override
  String get netProfit => '純利益';

  @override
  String get profit => '利益';

  @override
  String get loss => '損失';

  @override
  String get incomeExpensesByMonth => '月別収入・支出';

  @override
  String get noDataForYear => 'この年のデータなし';

  @override
  String get byMonth => '月別';

  @override
  String get month => '月';

  @override
  String get expense => '経費';

  @override
  String get net => '純額';

  @override
  String get incomeTooltip => '収入';

  @override
  String get expenseTooltip => '支出';

  @override
  String get chartMonthAbbr => '1,2,3,4,5,6,7,8,9,10,11,12';

  @override
  String get settingsTitle => '設定';

  @override
  String get appearance => '外観';

  @override
  String get aboutApp => 'アプリについて';

  @override
  String get versionLabel => 'バージョン';

  @override
  String get propertyLimit => '物件制限';

  @override
  String propertyLimitValue(int n) {
    return '$n (無料)';
  }

  @override
  String get contactDeveloper => '開発者に連絡';

  @override
  String get rateApp => 'アプリを評価';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get notificationsSection => '通知';

  @override
  String get enableNotifications => '通知を有効にする';

  @override
  String get permissionRequested => '権限が要求されました';

  @override
  String get dataSection => 'データ';

  @override
  String get backupToGoogleDrive => 'Google Driveにバックアップ';

  @override
  String get restoreFromBackup => 'バックアップから復元';

  @override
  String get restoreDataTitle => 'データを復元しますか？';

  @override
  String get restoreDataMessage => '現在のデータはGoogle Driveのデータに置き換えられます。';

  @override
  String get restore => '復元';

  @override
  String get googleSignInFailed => 'Googleへのログインに失敗しました';

  @override
  String get backupSaved => 'バックアップをGoogle Driveに保存しました';

  @override
  String get backupFailed => 'バックアップが失敗しました';

  @override
  String get dataRestored => 'データが復元されました。アプリを再起動してください。';

  @override
  String get backupNotFound => 'バックアップが見つかりません';

  @override
  String get theme => 'テーマ';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get currency => '通貨';

  @override
  String get proDescription => '最大10物件、PDFレポート、クラウドバックアップ';

  @override
  String get proCta => '2.99\$/月で試してみる';

  @override
  String get perMonth => '/月';

  @override
  String get proCtaYearly => 'または\$24.99/年';

  @override
  String get deleteExpenseTitle => '支出を削除しますか？';

  @override
  String deleteExpenseMessage(String name) {
    return '「$name」が削除されます。';
  }

  @override
  String get biometricSection => 'セキュリティ';

  @override
  String get enableBiometric => '指紋でロック解除';

  @override
  String get proFeatureMessage => 'PRO版で利用可能';

  @override
  String get splashPhrases =>
      '賃貸管理を\nあなたの手に|賃貸をシンプルに\n自信を持って管理|すべての支払いを\nコントロール|あなたの物件\nいつでも手元に|もっとスマートに管理—\nもっと稼ごう|混乱のない賃貸管理|あなた専用の\n不動産マネージャー|賃貸に関するすべてを\n把握する|収入が増える—\n支出はコントロール下に|ビジネスとして\nRentFlowで賃貸管理';
}
