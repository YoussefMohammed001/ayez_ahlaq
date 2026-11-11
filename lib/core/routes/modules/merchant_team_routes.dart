import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/team/presentation/manager/member_hours_cubit.dart';
import '../../../features/merchant/team/presentation/manager/merchant_member_detail_cubit.dart';
import '../../../features/merchant/team/presentation/manager/merchant_team_cubit.dart';
import '../../../features/merchant/team/presentation/pages/merchant_member_detail_screen.dart';
import '../../../features/merchant/team/presentation/pages/merchant_team_screen.dart';
import '../../di/modules/merchant_team_di.dart';
import '../../di/sl.dart';
import '../route_guards.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> merchantTeamRoutes = [
  GoRoute(
    path: Routes.merchantTeamScreen,
    builder: (_, _) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MerchantTeamCubit>()..load()),
        BlocProvider.value(value: merchantSubscriptionCubit),
      ],
      child: const MerchantTeamScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantTeamMemberScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) {
      final memberId = state.extra as int;
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<MerchantMemberDetailCubit>()..load(memberId),
          ),
          BlocProvider(
            create: (_) =>
                sl<MemberHoursCubit>(instanceName: merchantMemberHoursCubitName)
                  ..loadHours(memberId),
          ),
        ],
        child: const MerchantMemberDetailScreen(),
      );
    },
  ),
];
