import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_top_bar.dart';
import '../../../features/barber/profile/presentation/pages/barber_store_and_sales_menu_screen.dart';
import '../../../generated/l10n.dart';
import '../../../features/barber/store/domain/entities/store_merchant.dart';
import '../../../features/barber/store/domain/entities/store_order.dart';
import '../../../features/barber/store/presentation/pages/barber_store_cart_screen.dart';
import '../../../features/barber/store/presentation/pages/store_home_screen.dart';
import '../../../features/barber/store/presentation/pages/barber_store_merchants_screen.dart';
import '../../../features/barber/store/presentation/pages/barber_store_order_details_screen.dart';
import '../../../features/barber/store/presentation/pages/barber_store_products_screen.dart';
import '../../../features/barber/store/presentation/pages/store_feed_product_details_args.dart';
import '../../../features/barber/store/presentation/pages/store_feed_product_details_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberStoreRoutes = [
  GoRoute(
    path: Routes.barberStoreAndSalesMenuScreen,
    builder: (_, __) => const BarberStoreAndSalesMenuScreen(),
  ),
  GoRoute(
    path: Routes.barberStoreMerchantsScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberStoreFeedCubit..load()),
        BlocProvider.value(value: barberStoreMerchantsCubit..loadMerchants()),
        BlocProvider.value(value: barberStoreCartCubit),
        BlocProvider.value(value: barberStoreOrdersCubit),
      ],
      child: StoreHomeScreen(initialTabIndex: state.extra as int? ?? 0),
    ),
  ),
  GoRoute(
    path: Routes.barberStoreMerchantsBrowseScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberStoreMerchantsCubit..loadMerchants()),
        BlocProvider.value(value: barberStoreCartCubit),
      ],
      child: Scaffold(
        appBar: AppTopBar(title: S().storeBrowseMerchantsCta),
        body: const BarberStoreMerchantsScreen(),
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberStoreFeedProductDetailsScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberStoreCartCubit,
      child: StoreFeedProductDetailsScreen(
        args: state.extra as StoreFeedProductDetailsArgs,
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberStoreProductsScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberStoreCartCubit,
      child: BarberStoreProductsScreen(merchant: state.extra as StoreMerchant),
    ),
  ),
  GoRoute(
    path: Routes.barberStoreCartScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberStoreCartCubit,
      child: const BarberStoreCartScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberStoreOrderDetailsScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberStoreOrdersCubit,
      child: BarberStoreOrderDetailsScreen(order: state.extra as StoreOrder),
    ),
  ),
];
