import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_progress.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_step.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/presentation/widgets/profile_setup_checklist.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

void main() {
  Future<({List<ProfileSetupStep> taps, int dismisses})> pump(
    WidgetTester tester,
    ProfileSetupProgress progress, {
    bool Function(ProfileSetupStep)? blocked,
  }) async {
    tester.view.physicalSize = const Size(804, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final taps = <ProfileSetupStep>[];
    var dismisses = 0;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileSetupChecklist(
                progress: progress,
                isBlocked: blocked ?? (_) => false,
                onStepTap: taps.add,
                onStartTour: () {},
                onDismiss: () => dismisses++,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return (taps: taps, dismisses: dismisses);
  }

  testWidgets('lists only the steps it is given, with the count', (
    tester,
  ) async {
    await pump(
      tester,
      const ProfileSetupProgress(
        done: {ProfileSetupStep.hours},
        steps: [ProfileSetupStep.hours, ProfileSetupStep.services],
      ),
    );

    expect(find.text(S().setupStepHoursTitle), findsOneWidget);
    expect(find.text(S().setupStepServicesTitle), findsOneWidget);
    expect(find.text(S().setupStepTeamTitle), findsNothing);
    expect(find.text(S().setupChecklistProgress(1, 2)), findsOneWidget);
  });

  testWidgets(
    'shows the team steps and holds back the ones that wait for a member',
    (tester) async {
      final log = await pump(
        tester,
        const ProfileSetupProgress(
          done: {},
          steps: [
            ProfileSetupStep.team,
            ProfileSetupStep.teamHours,
            ProfileSetupStep.teamServices,
          ],
        ),
        blocked: (step) => step.dependsOnTeam,
      );

      expect(find.text(S().setupStepBlockedHint), findsNWidgets(2));

      await tester.tap(find.text(S().setupStepTeamTitle));
      await tester.tap(find.text(S().setupStepTeamHoursTitle));

      expect(log.taps, [ProfileSetupStep.team]);
    },
  );

  testWidgets('has a hide button', (tester) async {
    var dismissed = 0;
    tester.view.physicalSize = const Size(804, 2400);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(
          theme: lightTheme,
          home: Scaffold(
            body: ProfileSetupChecklist(
              progress: const ProfileSetupProgress(
                done: {},
                steps: [ProfileSetupStep.hours],
              ),
              isBlocked: (_) => false,
              onStepTap: (_) {},
              onStartTour: () {},
              onDismiss: () => dismissed++,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(S().setupHide));

    expect(dismissed, 1);
  });
}
