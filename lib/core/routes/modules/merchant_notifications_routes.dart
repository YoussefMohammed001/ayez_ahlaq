import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/notifications/presentation/pages/merchant_notifications_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> merchantNotificationsRoutes = [
  GoRoute(
    path: Routes.merchantNotificationsScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantNotificationsCubit,
      child: const MerchantNotificationsScreen(),
    ),
  ),
];
