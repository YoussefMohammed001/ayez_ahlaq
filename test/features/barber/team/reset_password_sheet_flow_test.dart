import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/entities/team_member_detail.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/repos/i_barber_team_repo.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/activate_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/block_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/delete_team_member_permanently_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/reset_member_password_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/set_member_availability_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/update_member_permissions_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/update_team_member_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/team_member_detail_cubit.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/manager/team_member_detail_state.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/widgets/member_detail_sheets.dart';
import 'package:ayez_ahlaq/features/barber/team/presentation/widgets/reset_member_password_sheet.dart';
import 'package:ayez_ahlaq/shared/widgets/busy_error_listener.dart';

const _member = TeamMemberDetail(
  id: 7,
  name: 'x',
  phoneNumber: '01111111111',
  tagline: '',
  available: true,
  active: true,
  mustChangePassword: true,
  rating: 0,
  ratingCount: 0,
);

class _SlowRepo implements IBarberTeamRepo {
  Either<Failure, Unit> resetResult = const Right(unit);
  String? sentPassword;

  @override
  Future<Either<Failure, TeamMemberDetail>> getMember(int id) async =>
      const Right(_member);

  @override
  Future<Either<Failure, Unit>> resetPassword(int id, String tempPassword) async {
    sentPassword = tempPassword;
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return resetResult;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

TeamMemberDetailCubit _cubit(_SlowRepo repo) => TeamMemberDetailCubit(
  GetTeamMemberUseCase(repo),
  UpdateTeamMemberUseCase(repo),
  SetMemberAvailabilityUseCase(repo),
  BlockTeamMemberUseCase(repo),
  ActivateTeamMemberUseCase(repo),
  DeleteTeamMemberPermanentlyUseCase(repo),
  UpdateMemberPermissionsUseCase(repo),
  ResetMemberPasswordUseCase(repo),
);

Widget _app(TeamMemberDetailCubit cubit) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    navigatorKey: rootNavigatorKey,
    theme: lightTheme,
    home: BlocProvider.value(
      value: cubit,
      child:
          BusyErrorListener<TeamMemberDetailCubit, TeamMemberDetailState>(
            isBusy: (state) => state.isSubmitting,
            errorMessage: (state) => state.errorMessage,
            child: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => MemberDetailSheets.resetPassword(context),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
    ),
  ),
);

void main() {
  testWidgets('the sheet closes right when saved and the reset still runs', (tester) async {
    tester.view.physicalSize = const Size(1200, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final repo = _SlowRepo();
    final cubit = _cubit(repo);
    await cubit.loadMember(7);
    await tester.pumpWidget(_app(cubit));

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(ResetMemberPasswordSheet), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Reset123');
    await tester.tap(find.byType(PrimaryCtaButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(ResetMemberPasswordSheet), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.byType(ResetMemberPasswordSheet), findsNothing);
    expect(find.text('open'), findsOneWidget);
    expect(repo.sentPassword, 'Reset123');
  });

  testWidgets('the sheet also closes when the server rejects the reset', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final repo = _SlowRepo()
      ..resetResult = Left(Failure('رفض', 403, const {}));
    final cubit = _cubit(repo);
    await cubit.loadMember(7);
    await tester.pumpWidget(_app(cubit));

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Reset123');
    await tester.tap(find.byType(PrimaryCtaButton));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.byType(ResetMemberPasswordSheet), findsNothing);
  });
}
