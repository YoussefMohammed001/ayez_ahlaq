import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/hours/presentation/pages/barber_hours_screen.dart';
import '../../../features/barber/drinks/presentation/pages/barber_drinks_screen.dart';
import '../../../features/barber/services/presentation/pages/barber_services_screen.dart';
import '../../../features/barber/services/presentation/pages/haircut_style_pricing_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberBarberShopRoutes = [
  GoRoute(
    path: Routes.barberHoursScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberHoursCubit..loadHours(),
      child: const BarberHoursScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberDrinksScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberDrinksCubit..loadDrinks(),
      child: const BarberDrinksScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberServicesScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberServicesCubit),
        BlocProvider.value(value: ownServicesCubit),
        BlocProvider.value(value: barberProfileCubit),
      ],
      child: const BarberServicesScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberHaircutStylePricingScreen,
    builder: (_, __) => BlocProvider.value(
      value: shopHaircutStylesCubit,
      child: const HaircutStylePricingScreen(),
    ),
  ),
];
