import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/discounts/domain/entities/barber_discount.dart';
import '../../../features/barber/discounts/presentation/pages/barber_discount_form_screen.dart';
import '../../../features/barber/discounts/presentation/pages/barber_discounts_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberCatalogRoutes = [
  GoRoute(
    path: Routes.barberDiscountsScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberDiscountsCubit),
        BlocProvider.value(
          value: barberStorefrontProductsCubit..loadProducts(),
        ),
      ],
      child: const BarberDiscountsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberDiscountFormScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberDiscountsCubit),
        BlocProvider.value(value: barberStorefrontProductsCubit),
      ],
      child: BarberDiscountFormScreen(discount: state.extra as BarberDiscount?),
    ),
  ),
];
