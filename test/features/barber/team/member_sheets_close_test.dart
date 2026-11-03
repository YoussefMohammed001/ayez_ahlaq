import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/entities/team_member_detail.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/widgets/add_team_member_sheet.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/widgets/edit_member_sheet.dart';

const _member = TeamMemberDetail(
  id: 7,
  name: 'كريم',
  phoneNumber: '01111111111',
  tagline: 'فيد',
  available: true,
  active: true,
  mustChangePassword: false,
  rating: 0,
  ratingCount: 0,
);

Widget _host(void Function(BuildContext) open) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    theme: lightTheme,
    home: Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => open(context),
          child: const Text('open'),
        ),
      ),
    ),
  ),
);

Future<void> _tallScreen(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 3200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Future<void> _tapSave(WidgetTester tester) async {
  final button = find.byType(PrimaryCtaButton);
  await tester.ensureVisible(button);
  await tester.pumpAndSettle();
  await tester.tap(button);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('add member sheet closes at once while the request is running', (
    tester,
  ) async {
    await _tallScreen(tester);
    final request = Completer<void>();
    String? sentName;
    String? sentPassword;
    await tester.pumpWidget(
      _host(
        (context) => AddTeamMemberSheet.show(
          context,
          onSubmit: (name, phone, tagline, tempPassword, permissions) {
            sentName = name;
            sentPassword = tempPassword;
            return request.future;
          },
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'كريم');
    await tester.enterText(find.byType(TextFormField).at(1), '01012345678');
    await tester.enterText(find.byType(TextFormField).at(3), 'Abc12345');

    await _tapSave(tester);

    expect(find.byType(AddTeamMemberSheet), findsNothing);
    expect(sentName, 'كريم');
    expect(sentPassword, 'Abc12345');

    request.complete();
    await tester.pumpAndSettle();

    expect(find.byType(AddTeamMemberSheet), findsNothing);
    expect(find.text('open'), findsOneWidget);
  });

  testWidgets('add member sheet stays open while the form is invalid', (
    tester,
  ) async {
    await _tallScreen(tester);
    var calls = 0;
    await tester.pumpWidget(
      _host(
        (context) => AddTeamMemberSheet.show(
          context,
          onSubmit: (name, phone, tagline, tempPassword, permissions) async {
            calls++;
          },
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await _tapSave(tester);

    expect(find.byType(AddTeamMemberSheet), findsOneWidget);
    expect(calls, 0);
  });

  testWidgets('edit member sheet closes at once while the request is running', (
    tester,
  ) async {
    await _tallScreen(tester);
    final request = Completer<void>();
    String? sentName;
    String? sentTagline;
    await tester.pumpWidget(
      _host(
        (context) => EditMemberSheet.show(
          context,
          member: _member,
          onSubmit: (name, tagline) {
            sentName = name;
            sentTagline = tagline;
            return request.future;
          },
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'كريم محمد');

    await _tapSave(tester);

    expect(find.byType(EditMemberSheet), findsNothing);
    expect(sentName, 'كريم محمد');
    expect(sentTagline, 'فيد');

    request.complete();
    await tester.pumpAndSettle();

    expect(find.byType(EditMemberSheet), findsNothing);
  });

  testWidgets('edit member sheet stays open when the name is empty', (
    tester,
  ) async {
    await _tallScreen(tester);
    var calls = 0;
    await tester.pumpWidget(
      _host(
        (context) => EditMemberSheet.show(
          context,
          member: _member,
          onSubmit: (name, tagline) async {
            calls++;
          },
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), '');

    await _tapSave(tester);

    expect(find.byType(EditMemberSheet), findsOneWidget);
    expect(calls, 0);
  });
}
