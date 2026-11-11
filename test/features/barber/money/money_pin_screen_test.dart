import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/entities/money_pin_reset_status.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/repos/i_barber_money_pin_repo.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/change_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/check_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/get_money_pin_reset_status_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/request_money_pin_reset_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/setup_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/domain/use_cases/verify_money_pin_use_case.dart';
import 'package:ayez_ahlaq/features/barber/money/presentation/manager/money_pin_cubit.dart';
import 'package:ayez_ahlaq/features/barber/money/presentation/pages/money_pin_screen.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class _FakePinRepo implements IBarberMoneyPinRepo {
  bool hasPinValue = true;
  String correctPin = '1234';
  final calls = <String>[];

  @override
  Future<Either<Failure, bool>> hasPin() async {
    calls.add('hasPin');
    return Right(hasPinValue);
  }

  @override
  Future<Either<Failure, void>> setup(String pin) async {
    calls.add('setup:$pin');
    correctPin = pin;
    hasPinValue = true;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> verify(String pin) async {
    calls.add('verify:$pin');
    return pin == correctPin
        ? const Right(null)
        : Left(Failure('الرقم السري غير صحيح', 400, const {}));
  }

  @override
  Future<Either<Failure, void>> change({
    required String currentPin,
    required String newPin,
  }) async => const Right(null);

  @override
  Future<Either<Failure, MoneyPinResetStatus>> getResetRequestStatus() async {
    calls.add('resetStatus');
    return const Right(MoneyPinResetStatus(pending: false));
  }

  @override
  Future<Either<Failure, MoneyPinResetStatus>> sendResetRequest() async =>
      const Right(MoneyPinResetStatus(pending: true));
}

MoneyPinCubit _cubit(_FakePinRepo repo) => MoneyPinCubit(
  CheckMoneyPinUseCase(repo),
  SetupMoneyPinUseCase(repo),
  VerifyMoneyPinUseCase(repo),
  ChangeMoneyPinUseCase(repo),
  GetMoneyPinResetStatusUseCase(repo),
  RequestMoneyPinResetUseCase(repo),
);

Future<void> _open(WidgetTester tester, MoneyPinCubit pin) async {
  tester.view.physicalSize = const Size(1200, 2600);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/pin',
    routes: [
      GoRoute(
        path: '/pin',
        builder: (_, _) => BlocProvider<MoneyPinCubit>.value(
          value: pin,
          child: const MoneyPinScreen(redirectRoute: '/done'),
        ),
      ),
      GoRoute(
        path: '/done',
        builder: (_, _) => const Scaffold(body: Text('opened')),
      ),
    ],
  );
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) =>
          MaterialApp.router(theme: lightTheme, routerConfig: router),
    ),
  );
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('shows the money PIN prompt with its own title', (tester) async {
    await _open(tester, _cubit(_FakePinRepo()));

    expect(find.text(S().moneyManagerTitle), findsOneWidget);
    expect(find.text(S().moneyPinEnterTitle), findsOneWidget);
    expect(find.text('opened'), findsNothing);
  });

  testWidgets('the right PIN goes on to the screen it was opened for', (
    tester,
  ) async {
    await _open(tester, _cubit(_FakePinRepo()));

    await tester.enterText(find.byType(Pinput), '1234');
    await tester.pump();
    await tester.tap(find.text(S().moneyPinConfirmAction));
    await tester.pumpAndSettle();

    expect(find.text('opened'), findsOneWidget);
  });

  testWidgets('a wrong PIN stays on the prompt', (tester) async {
    await _open(tester, _cubit(_FakePinRepo()));

    await tester.enterText(find.byType(Pinput), '0000');
    await tester.pump();
    await tester.tap(find.text(S().moneyPinConfirmAction));
    await tester.pumpAndSettle();

    expect(find.text('opened'), findsNothing);
    expect(find.text(S().moneyPinEnterTitle), findsOneWidget);
  });

  testWidgets('an already unlocked PIN goes straight through', (tester) async {
    final pin = _cubit(_FakePinRepo());
    await pin.verify('1234');

    await _open(tester, pin);
    await tester.pumpAndSettle();

    expect(find.text('opened'), findsOneWidget);
  });
}
