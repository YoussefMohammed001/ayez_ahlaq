import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import '../../../features/barber/attendance/presentation/pages/attendance_history_screen.dart';
import '../../../features/barber/attendance/presentation/pages/barber_attendance_screen.dart';
import '../../di/sl.dart';
import '../route_paths.dart';

final List<RouteBase> barberAttendanceRoutes = [
  GoRoute(
    path: Routes.barberAttendanceScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<BarberAttendanceCubit>()..load(),
      child: const BarberAttendanceScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberAttendanceHistoryScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<AttendanceHistoryCubit>()..load(),
      child: const AttendanceHistoryScreen(),
    ),
  ),
];
