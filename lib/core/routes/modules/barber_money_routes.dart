import '../../../features/barber/money/presentation/widgets/money_pin_lock_on_exit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/money/presentation/manager/money_home_cubit.dart';
import '../../../features/barber/money/presentation/manager/money_items_cubit.dart';
import '../../../features/barber/money/presentation/manager/money_entries_cubit.dart';
import '../../../features/barber/money/presentation/pages/money_pin_screen.dart';
import '../../../features/barber/money/presentation/pages/change_money_pin_screen.dart';
import '../../../features/barber/money/presentation/pages/money_home_screen.dart';
import '../../../features/barber/money/presentation/pages/money_items_screen.dart';
import '../../../features/barber/money/presentation/pages/money_entries_screen.dart';
import '../../../features/barber/team/presentation/pages/earnings_screen.dart';
import '../../di/services_locator.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberMoneyRoutes = [
  GoRoute(
    path: Routes.barberMoneyPinScreen,
    builder: (_, __) =>
        BlocProvider.value(value: moneyPinCubit, child: const MoneyPinScreen()),
  ),
  GoRoute(
    path: Routes.barberChangeMoneyPinScreen,
    builder: (_, __) => BlocProvider.value(
      value: moneyPinCubit,
      child: const ChangeMoneyPinScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberMoneyHomeScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<MoneyHomeCubit>()..load(),
      child: MoneyPinLockOnExit(
        pinCubit: moneyPinCubit,
        child: const MoneyHomeScreen(),
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberMoneyItemsScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<MoneyItemsCubit>()..load(),
      child: const MoneyItemsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberMoneyEntriesScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<MoneyEntriesCubit>()..load(),
      child: const MoneyEntriesScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberEarningsPinScreen,
    builder: (_, __) => BlocProvider.value(
      value: moneyPinCubit,
      child: const MoneyPinScreen(redirectRoute: Routes.barberEarningsScreen),
    ),
  ),
  GoRoute(
    path: Routes.barberEarningsScreen,
    builder: (_, __) => BlocProvider.value(
      value: earningsCubit..loadEarnings(),
      child: MoneyPinLockOnExit(
        pinCubit: moneyPinCubit,
        child: const EarningsScreen(),
      ),
    ),
  ),
];
