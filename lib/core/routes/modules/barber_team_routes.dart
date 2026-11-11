import '../../../features/barber/money/presentation/widgets/owner_money_pin_gate.dart';
import '../../../features/barber/salary/presentation/manager/member_commission_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../features/barber/salary/presentation/manager/member_salary_cubit.dart';
import '../../di/sl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/team/presentation/pages/team_member_detail_screen.dart';
import '../../../features/barber/team/presentation/widgets/team_list_sync.dart';
import '../../../features/barber/team/presentation/pages/team_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> barberTeamRoutes = [
  GoRoute(
    path: Routes.barberTeamScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberTeamCubit..loadTeam()),
        BlocProvider.value(value: barberProfileCubit),
        BlocProvider.value(value: moneyPinCubit),
      ],
      child: OwnerMoneyPinGate(
        title: S().teamTitle,
        enterTitle: S().teamPinEnterTitle,
        setupTitle: S().teamPinSetupTitle,
        child: const TeamScreen(),
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberTeamMemberDetailScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) {
      final memberId = state.extra as int;
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: teamMemberDetailCubit..loadMember(memberId),
          ),
          BlocProvider.value(value: memberHoursCubit..loadHours(memberId)),
          BlocProvider.value(
            value: memberServicesCubit..loadServices(memberId),
          ),
          BlocProvider.value(
            value: memberEarningsCubit..loadEarnings(memberId),
          ),
          BlocProvider.value(value: memberClientsCubit..loadClients(memberId)),
          BlocProvider(
            create: (_) => sl<MemberSalaryCubit>()..loadMember(memberId),
          ),
          BlocProvider(
            create: (_) => sl<MemberCommissionCubit>()..load(memberId),
          ),
          BlocProvider.value(value: barberTeamCubit),
          BlocProvider.value(value: barberProfileCubit),
          BlocProvider.value(value: moneyPinCubit),
        ],
        child: OwnerMoneyPinGate(
          title: S().teamTitle,
          enterTitle: S().teamPinEnterTitle,
          setupTitle: S().teamPinSetupTitle,
          child: const TeamListSync(child: TeamMemberDetailScreen()),
        ),
      );
    },
  ),
];
