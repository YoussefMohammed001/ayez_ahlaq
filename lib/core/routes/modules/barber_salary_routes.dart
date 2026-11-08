import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/salary/presentation/manager/my_salary_cubit.dart';
import '../../../features/barber/salary/presentation/pages/my_salary_screen.dart';
import '../../di/sl.dart';
import '../route_paths.dart';

final List<RouteBase> barberSalaryRoutes = [
  GoRoute(
    path: Routes.barberMySalaryScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<MySalaryCubit>()..load(),
      child: const MySalaryScreen(),
    ),
  ),
];
