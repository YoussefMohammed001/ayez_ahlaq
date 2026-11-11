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
import 'package:ayez_ahlaq/features/barber/money/presentation/manager/money_pin_state.dart';
import 'package:ayez_ahlaq/features/barber/money/presentation/widgets/owner_money_pin_gate.dart';
import 'package:ayez_ahlaq/features/barber/profile/domain/entities/barber_profile.dart';
import 'package:ayez_ahlaq/features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import 'package:ayez_ahlaq/features/barber/profile/presentation/manager/barber_profile_state.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
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

class _Profile extends Cubit<BarberProfileState> implements BarberProfileCubit {
  _Profile(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

BarberProfileState _profile({required bool owner}) => BarberProfileState(
  status: BarberProfileStatus.success,
  profile: BarberProfile(
    id: 1,
    name: 'x',
    phoneNumber: '0100',
    shopId: 3,
    shopName: 'shop',
    owner: owner,
    active: true,
    servesClients: true,
    mustChangePassword: false,
    rating: 0,
    ratingCount: 0,
  ),
);

MoneyPinCubit _cubit(_FakePinRepo repo) => MoneyPinCubit(
  CheckMoneyPinUseCase(repo),
  SetupMoneyPinUseCase(repo),
  VerifyMoneyPinUseCase(repo),
  ChangeMoneyPinUseCase(repo),
  GetMoneyPinResetStatusUseCase(repo),
  RequestMoneyPinResetUseCase(repo),
);

const _secret = Key('team-secret');

Future<void> _open(
  WidgetTester tester, {
  required MoneyPinCubit pin,
  required BarberProfileState profile,
  bool showGate = true,
}) async {
  tester.view.physicalSize = const Size(1200, 2600);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider<MoneyPinCubit>.value(value: pin),
          BlocProvider<BarberProfileCubit>.value(value: _Profile(profile)),
        ],
        child: MaterialApp(
          theme: lightTheme,
          home: showGate
              ? OwnerMoneyPinGate(
                  title: S().teamTitle,
                  enterTitle: S().teamPinEnterTitle,
                  setupTitle: S().teamPinSetupTitle,
                  child: const Scaffold(body: Text('salaries', key: _secret)),
                )
              : const SizedBox(),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

Future<void> _type(WidgetTester tester, String pin) async {
  await tester.enterText(find.byType(Pinput), pin);
  await tester.pump();
  await tester.tap(find.text(S().moneyPinConfirmAction));
  await tester.pumpAndSettle();
}

Future<void> _unmount(WidgetTester tester) async {
  tester.view.reset();
  await tester.pump();
  await tester.pumpWidget(const SizedBox());
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('an owner with a PIN sees the PIN prompt, not the salaries', (
    tester,
  ) async {
    final repo = _FakePinRepo();
    await _open(tester, pin: _cubit(repo), profile: _profile(owner: true));

    expect(find.byKey(_secret), findsNothing);
    expect(find.text(S().teamPinEnterTitle), findsOneWidget);
    expect(find.byType(Pinput), findsOneWidget);
    expect(repo.calls, containsAll(['hasPin', 'resetStatus']));
  });

  testWidgets('a wrong PIN keeps the section locked and clears the field', (
    tester,
  ) async {
    final repo = _FakePinRepo();
    await _open(tester, pin: _cubit(repo), profile: _profile(owner: true));

    await _type(tester, '9999');

    expect(repo.calls, contains('verify:9999'));
    expect(find.byKey(_secret), findsNothing);
    expect(find.text(S().teamPinEnterTitle), findsOneWidget);
  });

  testWidgets('the right PIN opens the section', (tester) async {
    final repo = _FakePinRepo();
    final pin = _cubit(repo);
    await _open(tester, pin: pin, profile: _profile(owner: true));

    await _type(tester, '1234');

    expect(find.byKey(_secret), findsOneWidget);
    expect(find.byType(Pinput), findsNothing);
    expect(pin.state.stage, MoneyPinStage.unlocked);
  });

  testWidgets('with no PIN yet it asks to create the money PIN first', (
    tester,
  ) async {
    final repo = _FakePinRepo()..hasPinValue = false;
    await _open(tester, pin: _cubit(repo), profile: _profile(owner: true));

    expect(find.text(S().teamPinSetupTitle), findsOneWidget);
    expect(find.byKey(_secret), findsNothing);

    await tester.enterText(find.byType(Pinput), '4321');
    await tester.pump();
    await tester.tap(find.text(S().moneyPinSetupAction));
    await tester.pumpAndSettle();

    expect(repo.calls, contains('setup:4321'));
    expect(find.byKey(_secret), findsOneWidget);
  });

  testWidgets('a section already unlocked by the money PIN opens at once', (
    tester,
  ) async {
    final repo = _FakePinRepo();
    final pin = _cubit(repo);
    await pin.verify('1234');
    repo.calls.clear();

    await _open(tester, pin: pin, profile: _profile(owner: true));

    expect(find.byKey(_secret), findsOneWidget);
    expect(repo.calls, isEmpty);
  });

  testWidgets('a team member is never asked for the owner PIN', (tester) async {
    final repo = _FakePinRepo();
    await _open(tester, pin: _cubit(repo), profile: _profile(owner: false));

    expect(find.byKey(_secret), findsOneWidget);
    expect(find.byType(Pinput), findsNothing);
    expect(repo.calls, isEmpty);
  });

  testWidgets('leaving the section locks the PIN again', (tester) async {
    final repo = _FakePinRepo();
    final pin = _cubit(repo);
    await pin.verify('1234');

    await _open(tester, pin: pin, profile: _profile(owner: true));
    expect(pin.state.stage, MoneyPinStage.unlocked);

    await _unmount(tester);

    expect(pin.state.stage, MoneyPinStage.locked);
  });

  testWidgets('opened directly, like from a notification, it still locks', (
    tester,
  ) async {
    final repo = _FakePinRepo();
    final pin = _cubit(repo);
    await _open(tester, pin: pin, profile: _profile(owner: true));

    await _type(tester, '1234');
    expect(find.byKey(_secret), findsOneWidget);
    expect(pin.state.stage, MoneyPinStage.unlocked);

    await _unmount(tester);

    expect(pin.state.stage, MoneyPinStage.locked);
  });

  testWidgets('a screen inside the section does not lock it while open', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final repo = _FakePinRepo();
    final pin = _cubit(repo);
    await pin.verify('1234');
    final showInner = ValueNotifier(true);
    final showOuter = ValueNotifier(true);

    Widget gate(Widget child) => OwnerMoneyPinGate(
      title: S().teamTitle,
      child: Scaffold(body: child),
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, _) => MultiBlocProvider(
          providers: [
            BlocProvider<MoneyPinCubit>.value(value: pin),
            BlocProvider<BarberProfileCubit>.value(
              value: _Profile(_profile(owner: true)),
            ),
          ],
          child: MaterialApp(
            theme: lightTheme,
            home: ValueListenableBuilder<bool>(
              valueListenable: showOuter,
              builder: (_, outer, _) => outer
                  ? gate(
                      ValueListenableBuilder<bool>(
                        valueListenable: showInner,
                        builder: (_, inner, _) => inner
                            ? gate(const Text('detail', key: _secret))
                            : const Text('list'),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byKey(_secret), findsOneWidget);

    showInner.value = false;
    await tester.pump();
    await tester.pump();
    expect(pin.state.stage, MoneyPinStage.unlocked);
    expect(find.text('list'), findsOneWidget);

    showOuter.value = false;
    await tester.pump();
    await tester.pump();
    expect(pin.state.stage, MoneyPinStage.locked);
  });
}
