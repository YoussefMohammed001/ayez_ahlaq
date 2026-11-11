import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/repos/i_merchant_member_self_repo.dart';
import 'package:ayez_ahlaq/features/merchant/team/domain/use_cases/get_my_merchant_hours_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_schedule_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/team/presentation/manager/my_schedule_state.dart';
import 'package:ayez_ahlaq/shared/auth/presentation/widgets/change_password_form.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSelfRepo extends Fake implements IMerchantMemberSelfRepo {
  Either<Failure, List<WorkingDay>> hours = const Right([]);

  @override
  Future<Either<Failure, List<WorkingDay>>> getMyHours() async => hours;
}

Widget _form({
  required Future<bool> Function(String, String) onSubmit,
  String? error,
}) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, _) => MaterialApp(
    theme: lightTheme,
    home: ChangePasswordForm(
      isSubmitting: false,
      onSubmit: onSubmit,
      errorMessage: () => error,
    ),
  ),
);

Future<void> _fill(
  WidgetTester tester, {
  String current = '123456',
  String updated = 'NewPass123',
  String confirm = 'NewPass123',
}) async {
  final fields = find.byType(TextFormField);
  await tester.enterText(fields.at(0), current);
  await tester.enterText(fields.at(1), updated);
  await tester.enterText(fields.at(2), confirm);
}

Future<void> _save(WidgetTester tester) async {
  await tester.tap(find.byType(PrimaryCtaButton));
  await tester.pumpAndSettle();
}

void main() {
  group('MyScheduleCubit', () {
    test('keeps the week as the server sent it', () async {
      final repo = _FakeSelfRepo()
        ..hours = const Right([
          WorkingDay(
            dayOfWeek: 0,
            isOpen: true,
            openTime: '09:00:00',
            closeTime: '17:00:00',
          ),
          WorkingDay.closed(1),
        ]);
      final cubit = MyScheduleCubit(GetMyMerchantHoursUseCase(repo));

      await cubit.load();

      expect(cubit.state.status, MyScheduleStatus.success);
      expect(cubit.state.days.length, 2);
      expect(cubit.state.days.first.isOpen, isTrue);
    });

    test('a failure leaves no days instead of throwing', () async {
      final repo = _FakeSelfRepo()
        ..hours = Left(Failure('offline', 500, const {}));
      final cubit = MyScheduleCubit(GetMyMerchantHoursUseCase(repo));

      await cubit.load();

      expect(cubit.state.status, MyScheduleStatus.failure);
      expect(cubit.state.days, isEmpty);
    });
  });

  group('ChangePasswordForm', () {
    testWidgets('sends the current and the new password', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final sent = <(String, String)>[];
      await tester.pumpWidget(
        _form(
          onSubmit: (current, updated) async {
            sent.add((current, updated));
            return false;
          },
        ),
      );

      await _fill(tester);
      await _save(tester);

      expect(sent, [('123456', 'NewPass123')]);
    });

    testWidgets('a short new password is not sent', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      var calls = 0;
      await tester.pumpWidget(
        _form(
          onSubmit: (_, _) async {
            calls++;
            return true;
          },
        ),
      );

      await _fill(tester, updated: '123', confirm: '123');
      await _save(tester);

      expect(calls, 0);
    });

    testWidgets('a mismatching confirmation is not sent', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      var calls = 0;
      await tester.pumpWidget(
        _form(
          onSubmit: (_, _) async {
            calls++;
            return true;
          },
        ),
      );

      await _fill(tester, confirm: 'Different1');
      await _save(tester);

      expect(calls, 0);
    });
  });
}
