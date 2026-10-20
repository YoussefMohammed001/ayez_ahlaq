import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/notifications/presentation/pages/customer_notifications_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';

final List<RouteBase> customerNotificationsRoutes = [
  GoRoute(
    path: Routes.customerNotificationsScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerNotificationsCubit,
      child: const CustomerNotificationsScreen(),
    ),
  ),
];
