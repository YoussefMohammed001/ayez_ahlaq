import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/wallet/presentation/widgets/withdraw_balance_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpSummary(
  WidgetTester tester,
  TextEditingController controller,
  int? available,
) {
  return tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, __) => MaterialApp(
        locale: const Locale('en'),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Scaffold(
          body: WithdrawBalanceSummary(
            available: available,
            amountController: controller,
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('shows the balance and updates the remainder as you type', (
    tester,
  ) async {
    final controller = TextEditingController();
    await pumpSummary(tester, controller, 500);

    expect(find.text('Your available balance: \u2066500\u2069 EGP'), findsOneWidget);
    expect(find.text('Remaining after withdrawal: \u2066500\u2069 EGP'), findsOneWidget);

    controller.text = '120';
    await tester.pump();

    expect(
      find.text('Remaining after withdrawal: \u2066380\u2069 EGP'),
      findsOneWidget,
    );
  });

  testWidgets('keeps the minus sign in front of a negative remainder', (
    tester,
  ) async {
    final controller = TextEditingController(text: '620');
    await pumpSummary(tester, controller, 500);

    expect(
      find.text('Remaining after withdrawal: \u2066-120\u2069 EGP'),
      findsOneWidget,
    );
  });

  testWidgets('shows a loading note while the balance is unknown', (
    tester,
  ) async {
    await pumpSummary(tester, TextEditingController(), null);

    expect(find.text('Loading your balance...'), findsOneWidget);
  });
}
