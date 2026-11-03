import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/features/barber/profile/domain/entities/barber_permissions.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/widgets/add_team_member_sheet.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/widgets/reset_member_password_sheet.dart';

Widget _host(Widget child) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    theme: lightTheme,
    home: Scaffold(body: child),
  ),
);

Future<void> _tallScreen(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 3200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Future<void> _tapSave(WidgetTester tester) async {
  await tester.tap(find.byType(PrimaryCtaButton));
  await tester.pumpAndSettle();
}

void main() {
  group('reset password sheet', () {
    testWidgets('a short password is rejected and nothing is sent', (
      tester,
    ) async {
      await _tallScreen(tester);
      final sent = <String>[];
      await tester.pumpWidget(
        _host(
          ResetMemberPasswordSheet(
            onSubmit: (value) async {
              sent.add(value);
            },
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '12345');
      await _tapSave(tester);

      expect(sent, isEmpty);
    });

    testWidgets('an empty password is rejected', (tester) async {
      await _tallScreen(tester);
      final sent = <String>[];
      await tester.pumpWidget(
        _host(
          ResetMemberPasswordSheet(
            onSubmit: (value) async {
              sent.add(value);
            },
          ),
        ),
      );

      await _tapSave(tester);

      expect(sent, isEmpty);
    });

    testWidgets('a valid password is sent as typed', (tester) async {
      await _tallScreen(tester);
      final sent = <String>[];
      await tester.pumpWidget(
        _host(
          ResetMemberPasswordSheet(
            onSubmit: (value) async {
              sent.add(value);
            },
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Reset123');
      await _tapSave(tester);

      expect(sent, ['Reset123']);
    });
  });

  group('add member sheet', () {
    late List<(String, String, String?, String?)> sent;

    Future<void> open(WidgetTester tester) async {
      await _tallScreen(tester);
      sent = [];
      await tester.pumpWidget(
        _host(
          AddTeamMemberSheet(
            onSubmit: (name, phone, tagline, tempPassword, permissions) async {
              sent.add((name, phone, tagline, tempPassword));
            },
          ),
        ),
      );
    }

    Future<void> fillRequired(WidgetTester tester) async {
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'كريم');
      await tester.enterText(fields.at(1), '01012345678');
    }

    testWidgets('a blank password is sent as null', (tester) async {
      await open(tester);
      await fillRequired(tester);

      await _tapSave(tester);

      expect(sent.single.$4, isNull);
      expect(sent.single.$1, 'كريم');
    });

    testWidgets('a typed password is sent as typed', (tester) async {
      await open(tester);
      await fillRequired(tester);
      await tester.enterText(find.byType(TextFormField).at(3), 'Abc12345');

      await _tapSave(tester);

      expect(sent.single.$4, 'Abc12345');
    });

    testWidgets('a short password blocks the save', (tester) async {
      await open(tester);
      await fillRequired(tester);
      await tester.enterText(find.byType(TextFormField).at(3), '123');

      await _tapSave(tester);

      expect(sent, isEmpty);
    });

    testWidgets('the sheet passes the chosen permissions along', (tester) async {
      BarberPermissions? received;
      await _tallScreen(tester);
      await tester.pumpWidget(
        _host(
          AddTeamMemberSheet(
            onSubmit: (name, phone, tagline, tempPassword, permissions) async {
              received = permissions;
            },
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField).at(0), 'كريم');
      await tester.enterText(find.byType(TextFormField).at(1), '01012345678');

      await _tapSave(tester);

      expect(received, BarberPermissions.none);
    });
  });
}
