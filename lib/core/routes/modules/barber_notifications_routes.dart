import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/notifications/presentation/pages/barber_notifications_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberNotificationsRoutes = [
  GoRoute(
    path: Routes.barberNotificationsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberNotificationsCubit,
      child: const BarberNotificationsScreen(),
    ),
  ),
];
