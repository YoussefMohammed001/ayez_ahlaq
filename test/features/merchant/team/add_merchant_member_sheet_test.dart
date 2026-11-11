import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/core/widgets/toggle_switch.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/entities/merchant_member_permissions.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/widgets/add_merchant_member_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

typedef _Sent = ({
  String name,
  String phone,
  String? password,
  double? salary,
  MerchantMemberPermissions permissions,
});

void main() {
  late List<_Sent> sent;

  Future<void> open(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 3600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    sent = [];

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, _) => MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: AddMerchantMemberSheet(
              onSubmit:
                  ({
                    required name,
                    required phone,
                    password,
                    salary,
                    required permissions,
                  }) async {
                    sent.add((
                      name: name,
                      phone: phone,
                      password: password,
                      salary: salary,
                      permissions: permissions,
                    ));
                  },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fill(
    WidgetTester tester, {
    String name = 'Sub',
    String phone = '01012345678',
    String password = '',
    String salary = '',
  }) async {
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), name);
    await tester.enterText(fields.at(1), phone);
    await tester.enterText(fields.at(2), password);
    await tester.enterText(fields.at(3), salary);
  }

  Future<void> save(WidgetTester tester) async {
    await tester.tap(find.byType(PrimaryCtaButton));
    await tester.pumpAndSettle();
  }

  testWidgets('only the required fields: no password, no salary', (
    tester,
  ) async {
    await open(tester);
    await fill(tester);

    await save(tester);

    expect(sent.single.name, 'Sub');
    expect(sent.single.password, isNull);
    expect(sent.single.salary, isNull);
    expect(sent.single.permissions, const MerchantMemberPermissions());
  });

  testWidgets('a typed password, salary and a permission are all sent', (
    tester,
  ) async {
    await open(tester);
    await fill(tester, password: 'Abc12345', salary: '4500');
    await tester.tap(find.byType(ToggleSwitch).last);
    await tester.pump();

    await save(tester);

    expect(sent.single.password, 'Abc12345');
    expect(sent.single.salary, 4500);
    expect(sent.single.permissions.canSell, isTrue);
    expect(sent.single.permissions.canManageProducts, isFalse);
  });

  testWidgets('an empty name blocks the save', (tester) async {
    await open(tester);
    await fill(tester, name: '');

    await save(tester);

    expect(sent, isEmpty);
  });

  testWidgets('a phone that is not Egyptian blocks the save', (tester) async {
    await open(tester);
    await fill(tester, phone: '0abc');

    await save(tester);

    expect(sent, isEmpty);
  });

  testWidgets('a password shorter than six characters blocks the save', (
    tester,
  ) async {
    await open(tester);
    await fill(tester, password: '123');

    await save(tester);

    expect(sent, isEmpty);
  });

  testWidgets('a zero salary blocks the save', (tester) async {
    await open(tester);
    await fill(tester, salary: '0');

    await save(tester);

    expect(sent, isEmpty);
  });
}
