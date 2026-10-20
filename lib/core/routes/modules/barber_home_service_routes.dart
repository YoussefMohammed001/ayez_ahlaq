import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/home_service/presentation/pages/home_service_settings_screen.dart';
import '../../../features/barber/home_service/presentation/pages/home_service_hours_screen.dart';
import '../../../features/barber/home_service_requests/presentation/pages/home_service_requests_screen.dart'
    as barber_hsr;
import '../../../features/barber/home_service_requests/presentation/pages/home_service_request_detail_screen.dart'
    as barber_hsr;
import '../../../features/barber/home_service_broadcast/presentation/pages/home_service_broadcast_screen.dart';
import '../../../features/barber/home_service_broadcast/presentation/pages/home_service_broadcast_detail_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberHomeServiceRoutes = [
  GoRoute(
    path: Routes.barberHomeServiceSettingsScreen,
    builder: (_, __) => BlocProvider.value(
      value: homeServiceSettingsCubit..loadSettings(),
      child: const HomeServiceSettingsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberHomeServiceHoursScreen,
    builder: (_, __) => BlocProvider.value(
      value: homeServiceHoursCubit..loadHours(),
      child: const HomeServiceHoursScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberHomeServiceRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberHomeServiceRequestsCubit,
      child: const barber_hsr.HomeServiceRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberHomeServiceRequestDetailScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberHomeServiceRequestsCubit,
      child: barber_hsr.HomeServiceRequestDetailScreen(
        requestId: state.extra as int,
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberHomeServiceBroadcastScreen,
    builder: (_, __) => BlocProvider.value(
      value: homeServiceBroadcastCubit,
      child: const HomeServiceBroadcastScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberHomeServiceBroadcastDetailScreen,
    builder: (_, state) => BlocProvider.value(
      value: homeServiceBroadcastCubit,
      child: HomeServiceBroadcastDetailScreen(candidateId: state.extra as int),
    ),
  ),
  GoRoute(
    path: Routes.barberHomeServiceBroadcastRequestDetailScreen,
    builder: (_, state) => BlocProvider.value(
      value: homeServiceBroadcastCubit,
      child: HomeServiceBroadcastDetailScreen(requestId: state.extra as int),
    ),
  ),
];
