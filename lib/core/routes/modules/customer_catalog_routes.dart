import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/presentation/pages/customer_shell.dart';
import '../../../features/customer/store/presentation/widgets/store_cart_busy_scope.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';
import '../logout_handlers.dart';

final List<RouteBase> customerCatalogRoutes = [
  GoRoute(
    path: Routes.customerShell,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customerShopsCubit),
        BlocProvider.value(value: customerStoreOrdersCubit),
        BlocProvider.value(value: customerStoreFeedCubit),
        BlocProvider.value(value: customerStoreCartCubit),
        BlocProvider.value(value: customerFavoritesCubit),
        BlocProvider.value(value: customerProfileCubit),
        BlocProvider.value(value: customerNotificationsCubit),
        BlocProvider.value(value: myBookingsCubit),
      ],
      child: StoreCartBusyScope(
        child: CustomerShell(onLogout: handleCustomerLogout),
      ),
    ),
  ),
];
