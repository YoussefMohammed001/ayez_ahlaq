import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/help/presentation/widgets/barber_help_entries.dart';
import 'package:ayez_ahlaq/features/barber/help/presentation/widgets/help_entry.dart';
import 'package:ayez_ahlaq/features/barber/help/presentation/widgets/help_faq_item.dart';
import 'package:ayez_ahlaq/features/barber/tour/presentation/manager/barber_tour_cubit.dart';

void main() {
  test('owners and team members get their own questions', () {
    final owner = BarberHelpEntries.of(isTeamMember: false);
    final member = BarberHelpEntries.of(isTeamMember: true);

    expect(owner, hasLength(4));
    expect(member, hasLength(3));
    expect(
      owner.map((e) => e.question).toSet().intersection(
        member.map((e) => e.question).toSet(),
      ),
      isEmpty,
    );
    expect(
      [...owner, ...member].every(
        (e) => e.question.isNotEmpty && e.answer.isNotEmpty,
      ),
      isTrue,
    );
  });

  testWidgets('an answer shows only after the question is tapped', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(
          theme: lightTheme,
          home: const Scaffold(
            body: HelpFaqItem(entry: HelpEntry('سؤال؟', 'هذه هي الإجابة')),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('سؤال؟'), findsOneWidget);
    expect(find.text('هذه هي الإجابة'), findsNothing);

    await tester.tap(find.text('سؤال؟'));
    await tester.pumpAndSettle();

    expect(find.text('هذه هي الإجابة'), findsOneWidget);
  });

  test('every tour request is a new state so listeners fire each time', () {
    final cubit = BarberTourCubit();

    cubit.requestTour();
    cubit.requestTour();

    expect(cubit.state.requestCount, 2);
  });
}
