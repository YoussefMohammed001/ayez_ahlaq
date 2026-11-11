import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_history_screen.dart';
import '../../../features/merchant/sub_merchant/presentation/pages/sub_merchant_shell.dart';
import '../../../features/merchant/team/presentation/manager/my_schedule_cubit.dart';
import '../../../features/merchant/team/presentation/pages/member_change_password_screen.dart';
import '../../di/modules/merchant_attendance_di.dart';
import '../../di/sl.dart';
import '../logout_handlers.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> subMerchantShellRoutes = [
  GoRoute(
    path: Routes.subMerchantShell,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: myMerchantMemberCubit),
        BlocProvider.value(value: memberAttendanceCubit),
        BlocProvider.value(value: merchantOrdersCubit),
        BlocProvider.value(value: merchantProductsCubit),
        BlocProvider.value(value: merchantProfileCubit),
        BlocProvider.value(value: salesCubit),
        BlocProvider.value(value: merchantNotificationsCubit),
        BlocProvider(create: (_) => sl<MyScheduleCubit>()),
      ],
      child: SubMerchantShell(
        onLogout: handleMerchantLogout,
        initialIndex: state.extra as int? ?? 0,
      ),
    ),
  ),
  GoRoute(
    path: Routes.memberAttendanceHistoryScreen,
    builder: (_, _) => BlocProvider(
      create: (_) => sl<AttendanceHistoryCubit>(
        instanceName: memberAttendanceHistoryCubitName,
      )..load(),
      child: const AttendanceHistoryScreen(canCorrect: false),
    ),
  ),
  GoRoute(
    path: Routes.memberChangePasswordScreen,
    builder: (_, _) => BlocProvider.value(
      value: myMerchantMemberCubit,
      child: const MemberChangePasswordScreen(),
    ),
  ),
];
