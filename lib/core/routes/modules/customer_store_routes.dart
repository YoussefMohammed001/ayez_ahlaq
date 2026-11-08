import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/store/domain/entities/store_order.dart'
    as customer_store;
import '../../../features/customer/store/presentation/pages/my_store_orders_screen.dart';
import '../../../features/customer/store/presentation/pages/store_cart_screen.dart';
import '../../../features/customer/store/presentation/pages/store_order_details_screen.dart'
    as customer_store;
import '../../../features/customer/store/presentation/pages/store_products_screen.dart';
import '../../../features/customer/store/presentation/pages/store_feed_product_details_args.dart'
    as customer_feed;
import '../../../features/customer/store/presentation/pages/store_feed_product_details_screen.dart'
    as customer_feed;
import '../../../features/customer/store/presentation/pages/store_product_details_args.dart';
import '../../../features/customer/store/presentation/pages/store_product_details_screen.dart';
import '../../../features/customer/store/presentation/widgets/store_cart_busy_scope.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> customerStoreRoutes = [
  GoRoute(
    path: Routes.customerStoreProductsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<int>(state),
    builder: (_, state) => BlocProvider.value(
      value: customerStoreCartCubit,
      child: StoreCartBusyScope(
        child: StoreProductsScreen(shopId: state.extra as int),
      ),
    ),
  ),
  GoRoute(
    path: Routes.customerStoreProductDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<StoreProductDetailsArgs>(state),
    builder: (_, state) => BlocProvider.value(
      value: customerStoreCartCubit,
      child: StoreCartBusyScope(
        child: StoreProductDetailsScreen(
          args: state.extra as StoreProductDetailsArgs,
        ),
      ),
    ),
  ),
  GoRoute(
    path: Routes.customerStoreFeedProductDetailsScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<customer_feed.StoreFeedProductDetailsArgs>(state),
    builder: (_, state) => BlocProvider.value(
      value: customerStoreCartCubit,
      child: StoreCartBusyScope(
        child: customer_feed.StoreFeedProductDetailsScreen(
          args: state.extra as customer_feed.StoreFeedProductDetailsArgs,
        ),
      ),
    ),
  ),
  GoRoute(
    path: Routes.customerStoreCartScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customerStoreCartCubit),
        BlocProvider.value(value: customerPaymentMethodsCubit),
      ],
      child: const StoreCartBusyScope(child: StoreCartScreen()),
    ),
  ),
  GoRoute(
    path: Routes.customerStoreOrdersScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerStoreOrdersCubit,
      child: const MyStoreOrdersScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerStoreOrderDetailScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<customer_store.StoreOrder>(state),
    builder: (_, state) => BlocProvider.value(
      value: customerStoreOrdersCubit,
      child: customer_store.StoreOrderDetailsScreen(
        order: state.extra as customer_store.StoreOrder,
      ),
    ),
  ),
];
