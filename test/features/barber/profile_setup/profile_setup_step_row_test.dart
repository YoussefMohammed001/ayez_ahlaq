import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_step.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/presentation/widgets/profile_setup_step_row.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, __) => MaterialApp(
        theme: lightTheme,
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a pending step shows its hint and reacts to taps', (
    tester,
  ) async {
    var taps = 0;
    await _pump(
      tester,
      ProfileSetupStepRow(
        step: ProfileSetupStep.hours,
        done: false,
        onTap: () => taps++,
      ),
    );

    expect(find.text(S().setupStepHoursTitle), findsOneWidget);
    expect(find.text(S().setupStepHoursHint), findsOneWidget);

    await tester.tap(find.byType(ProfileSetupStepRow));
    expect(taps, 1);
  });

  testWidgets('a done step drops the hint and ignores taps', (tester) async {
    var taps = 0;
    await _pump(
      tester,
      ProfileSetupStepRow(
        step: ProfileSetupStep.services,
        done: true,
        onTap: () => taps++,
      ),
    );

    expect(find.text(S().setupStepServicesTitle), findsOneWidget);
    expect(find.text(S().setupStepServicesHint), findsNothing);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    await tester.tap(find.byType(ProfileSetupStepRow));
    expect(taps, 0);
  });

  testWidgets('a blocked step explains what to do first and ignores taps', (
    tester,
  ) async {
    var taps = 0;
    await _pump(
      tester,
      ProfileSetupStepRow(
        step: ProfileSetupStep.teamHours,
        done: false,
        blocked: true,
        onTap: () => taps++,
      ),
    );

    expect(find.text(S().setupStepTeamHoursTitle), findsOneWidget);
    expect(find.text(S().setupStepBlockedHint), findsOneWidget);
    expect(find.text(S().setupStepTeamHoursHint), findsNothing);

    await tester.tap(find.byType(ProfileSetupStepRow));
    expect(taps, 0);
  });
}
