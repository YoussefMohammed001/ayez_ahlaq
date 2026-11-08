import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance_feature/presentation/manager/attendance_feature_request_cubit.dart';
import '../../../features/barber/attendance_feature/presentation/manager/attendance_feature_requests_cubit.dart';
import '../../../features/barber/attendance_feature/presentation/pages/attendance_feature_requests_screen.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_setting_log_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_settings_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_team_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/worked_hours_cubit.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_history_screen.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_setting_log_screen.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_settings_screen.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_team_screen.dart';
import '../../../features/barber/attendance/presentation/pages/barber_attendance_screen.dart';
import '../../di/sl.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberAttendanceRoutes = [
  GoRoute(
    path: Routes.barberAttendanceScreen,
    builder: (_, state) {
      final shared = state.extra;

      return MultiBlocProvider(
        providers: [
          if (shared is BarberAttendanceCubit)
            BlocProvider.value(value: shared..load())
          else
            BlocProvider(create: (_) => sl<BarberAttendanceCubit>()..load()),
          BlocProvider(create: (_) => sl<AttendanceFeatureRequestCubit>()),
          BlocProvider(create: (_) => sl<WorkedHoursCubit>()..load()),
          BlocProvider.value(value: barberProfileCubit),
        ],
        child: const BarberAttendanceScreen(),
      );
    },
  ),
  GoRoute(
    path: Routes.barberAttendanceHistoryScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AttendanceHistoryCubit>()..load()),
        BlocProvider.value(value: barberProfileCubit),
      ],
      child: const AttendanceHistoryScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberAttendanceTeamScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<AttendanceTeamCubit>()..load(),
      child: const AttendanceTeamScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberAttendanceSettingsScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<AttendanceSettingsCubit>()..load(),
      child: const AttendanceSettingsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberAttendanceSettingLogScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<AttendanceSettingLogCubit>()..load(),
      child: const AttendanceSettingLogScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberAttendanceFeatureRequestsScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<AttendanceFeatureRequestsCubit>()..load(),
      child: const AttendanceFeatureRequestsScreen(),
    ),
  ),
];
