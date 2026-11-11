import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_setting_log_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_settings_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_team_cubit.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_history_screen.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_setting_log_screen.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_settings_screen.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_team_screen.dart';
import '../../di/modules/merchant_attendance_di.dart';
import '../../di/sl.dart';
import '../route_guards.dart';
import '../route_paths.dart';

final List<RouteBase> merchantAttendanceRoutes = [
  GoRoute(
    path: Routes.merchantTeamAttendanceScreen,
    builder: (_, _) => BlocProvider(
      create: (_) =>
          sl<AttendanceTeamCubit>(instanceName: merchantAttendanceTeamCubitName)
            ..load(),
      child: Builder(
        builder: (context) => AttendanceTeamScreen(
          onMemberTap: (member) => context.push(
            Routes.merchantMemberAttendanceScreen,
            extra: member.barberId,
          ),
        ),
      ),
    ),
  ),
  GoRoute(
    path: Routes.merchantAttendanceSettingsScreen,
    builder: (_, _) => BlocProvider(
      create: (_) => sl<AttendanceSettingsCubit>(
        instanceName: merchantAttendanceSettingsCubitName,
      )..load(),
      child: const AttendanceSettingsScreen(
        logRoute: Routes.merchantAttendanceSettingLogScreen,
      ),
    ),
  ),
  GoRoute(
    path: Routes.merchantAttendanceSettingLogScreen,
    builder: (_, _) => BlocProvider(
      create: (_) => sl<AttendanceSettingLogCubit>(
        instanceName: merchantAttendanceLogCubitName,
      )..load(),
      child: const AttendanceSettingLogScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantMemberAttendanceScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) => BlocProvider(
      create: (_) => sl<AttendanceHistoryCubit>(
        instanceName: merchantMemberHistoryCubitName,
        param1: state.extra as int,
      )..load(),
      child: const AttendanceHistoryScreen(canCorrect: true),
    ),
  ),
];
