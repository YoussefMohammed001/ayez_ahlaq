import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/shops/presentation/pages/customer_shop_detail_screen.dart';
import '../../../features/customer/shops/presentation/pages/browse_shops_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';

final List<RouteBase> customerShopRoutes = [
  GoRoute(
    path: Routes.customerBrowseShopsScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerShopsCubit,
      child: const BrowseShopsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerShopDetailScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customerShopDetailCubit),
        BlocProvider.value(value: customerFavoritesCubit),
      ],
      child: CustomerShopDetailScreen(shopId: state.extra as int),
    ),
  ),
];
