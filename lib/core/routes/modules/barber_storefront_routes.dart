import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/storefront/orders/domain/entities/storefront_order.dart';
import '../../../features/barber/storefront/orders/presentation/pages/storefront_order_details_screen.dart';
import '../../../features/barber/storefront/presentation/pages/storefront_home_screen.dart';
import '../../../features/barber/storefront/products/domain/entities/storefront_product.dart';
import '../../../features/barber/storefront/products/presentation/pages/storefront_product_details_screen.dart';
import '../../../features/barber/storefront/products/presentation/pages/storefront_product_form_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> barberStorefrontRoutes = [
  GoRoute(
    path: Routes.barberStorefrontHomeScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: barberStorefrontProductsCubit..loadProducts(),
        ),
        BlocProvider.value(
          value: barberStorefrontCategoriesCubit..loadCategories(),
        ),
        BlocProvider.value(
          value: barberStorefrontDeliveryCubit..loadDelivery(),
        ),
        BlocProvider.value(value: barberStorefrontOrdersCubit..loadOrders()),
      ],
      child: StorefrontHomeScreen(
        initialTabIndex: state.extra as int? ?? 0,
        showBackButton: true,
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberStorefrontProductFormScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberStorefrontProductsCubit),
        BlocProvider.value(value: barberStorefrontCategoriesCubit),
      ],
      child: StorefrontProductFormScreen(
        product: state.extra as StorefrontProduct?,
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberStorefrontProductDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) => BlocProvider.value(
      value: barberStorefrontProductsCubit,
      child: StorefrontProductDetailsScreen(productId: state.extra as int),
    ),
  ),
  GoRoute(
    path: Routes.barberStorefrontOrderDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<StorefrontOrder>(state),
    builder: (_, state) => BlocProvider.value(
      value: barberStorefrontOrdersCubit,
      child: StorefrontOrderDetailsScreen(
        order: state.extra as StorefrontOrder,
      ),
    ),
  ),
];
