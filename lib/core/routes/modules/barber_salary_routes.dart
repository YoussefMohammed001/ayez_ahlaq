import '../../../features/barber/attendance/presentation/manager/worked_hours_cubit.dart';
import '../../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/money/presentation/widgets/owner_money_pin_gate.dart';
import '../../../features/barber/salary/presentation/manager/my_salary_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../features/barber/salary/presentation/manager/salary_deductions_cubit.dart';
import '../../../features/barber/salary/presentation/pages/my_salary_screen.dart';
import '../../../features/barber/salary/presentation/pages/salary_deductions_screen.dart';
import '../../di/sl.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

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
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SalaryDeductionsCubit>()..load()),
        BlocProvider.value(value: barberProfileCubit),
        BlocProvider.value(value: moneyPinCubit),
      ],
      child: OwnerMoneyPinGate(
        title: S().salaryTitle,
        enterTitle: S().teamPinEnterTitle,
        setupTitle: S().teamPinSetupTitle,
        child: const SalaryDeductionsScreen(),
      ),
    ),
  ),
];
