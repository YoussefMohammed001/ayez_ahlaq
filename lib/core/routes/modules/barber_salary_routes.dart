import '../../../features/barber/attendance/presentation/manager/worked_hours_cubit.dart';
import '../../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/salary/presentation/manager/my_salary_cubit.dart';
import '../../../features/barber/salary/presentation/manager/salary_deductions_cubit.dart';
import '../../../features/barber/salary/presentation/pages/my_salary_screen.dart';
import '../../../features/barber/salary/presentation/pages/salary_deductions_screen.dart';
import '../../di/sl.dart';
import '../route_paths.dart';

final List<RouteBase> barberSalaryRoutes = [
  GoRoute(
    path: Routes.barberMySalaryScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MySalaryCubit>()..load()),
        BlocProvider(create: (_) => sl<WorkedHoursCubit>()..load()),
        BlocProvider(create: (_) => sl<BarberHoursCubit>()..loadHours()),
      ],
      child: const MySalaryScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberSalaryDeductionsScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<SalaryDeductionsCubit>()..load(),
      child: const SalaryDeductionsScreen(),
    ),
  ),
];
