import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/home_service/domain/entities/home_service_request.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_date_time_screen.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_shop_list_screen.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_shop_list_args.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_request_args.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_request_screen.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_requests_screen.dart';
import '../../../features/customer/home_service/presentation/pages/home_service_request_detail_screen.dart';
import '../../../features/customer/home_service/presentation/widgets/home_service_list_sync.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';

final List<RouteBase> customerHomeServiceRoutes = [
  GoRoute(
    path: Routes.customerHomeServiceDateTimeScreen,
    builder: (_, __) => const HomeServiceDateTimeScreen(),
  ),
  GoRoute(
    path: Routes.customerHomeServiceShopListScreen,
    builder: (_, state) => BlocProvider.value(
      value: homeServiceShopsCubit,
      child: HomeServiceShopListScreen(
        args: state.extra as HomeServiceShopListArgs,
      ),
    ),
  ),
  GoRoute(
    path: Routes.customerHomeServiceRequestScreen,
    builder: (_, state) {
      final extra = state.extra;
      return BlocProvider.value(
        value: homeServiceRequestFormCubit,
        child: HomeServiceRequestScreen(
          requestArgs: extra is HomeServiceRequestArgs ? extra : null,
          retryRequest: extra is HomeServiceRequest ? extra : null,
        ),
      );
    },
  ),
  GoRoute(
    path: Routes.customerHomeServiceRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: homeServiceRequestsCubit,
      child: const HomeServiceRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerHomeServiceRequestDetailScreen,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: homeServiceRequestDetailCubit),
        BlocProvider.value(value: homeServiceRequestsCubit),
      ],
      child: HomeServiceListSync(
        child: HomeServiceRequestDetailScreen(requestId: state.extra as int),
      ),
    ),
  ),
];
