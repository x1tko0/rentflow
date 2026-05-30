import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentflow/app/app.dart';
import 'package:rentflow/main.dart' as app_main;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_done': false});
    app_main.globalPrefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(const ProviderScope(child: RentFlowApp()));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to RentFlow'), findsOneWidget);
  });
}
