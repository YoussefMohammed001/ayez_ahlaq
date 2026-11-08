import 'package:go_router/go_router.dart';
import '../analytics/analytics_route_observer.dart';
import '../analytics/i_analytics_service.dart';
import '../../env/env.dart';
import '../di/services_locator.dart';
import 'root_navigator_key.dart';
import 'route_observer.dart';
import 'route_paths.dart';
import 'modules/shared_app_routes.dart';
import 'modules/merchant_auth_routes.dart';
import 'modules/customer_auth_routes.dart';
import 'modules/customer_account_routes.dart';
import 'modules/customer_booking_routes.dart';
import 'modules/barber_account_routes.dart';
import 'modules/merchant_account_routes.dart';
import 'modules/barber_auth_routes.dart';
import 'modules/customer_catalog_routes.dart';
import 'modules/customer_shop_routes.dart';
import 'modules/customer_home_service_routes.dart';
import 'modules/customer_store_routes.dart';
import 'modules/customer_engagement_routes.dart';
import 'modules/customer_notifications_routes.dart';
import 'modules/barber_shell_routes.dart';
import 'modules/barber_barber_shop_routes.dart';
import 'modules/barber_home_service_routes.dart';
import 'modules/barber_engagement_routes.dart';
import 'modules/barber_catalog_routes.dart';
import 'modules/barber_shop_routes.dart';
import 'modules/barber_store_routes.dart';
import 'modules/barber_wallet_routes.dart';
import 'modules/barber_money_routes.dart';
import 'modules/customer_wallet_routes.dart';
import 'modules/barber_notifications_routes.dart';
import 'modules/barber_attendance_routes.dart';
import 'modules/barber_salary_routes.dart';
import 'modules/barber_team_routes.dart';
import 'modules/barber_booking_routes.dart';
import 'modules/merchant_shell_routes.dart';
import 'modules/merchant_catalog_routes.dart';
import 'modules/merchant_notifications_routes.dart';
import 'modules/barber_storefront_routes.dart';
import 'modules/merchant_engagement_routes.dart';
import 'modules/merchant_wallet_routes.dart';

import 'constrained_pages.dart';

export 'root_navigator_key.dart';

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final routes = GoRouter(
  initialLocation: Routes.splashScreen,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: isDevEnvironment(),
  observers: [
    customGoRouterObserver,
    AnalyticsRouteObserver(() => sl<IAnalyticsService>()),
  ],
  routes: constrainPages(_allRoutes, fullWidthPaths: _fullWidthPaths),
);

const _fullWidthPaths = {
  Routes.splashScreen,
  Routes.customerShell,
  Routes.barberShell,
  Routes.merchantShell,
};

final _allRoutes = <RouteBase>[
    ...sharedAppRoutes,
    ...merchantAuthRoutes,
    ...customerAuthRoutes,
    ...customerAccountRoutes,
    ...customerBookingRoutes,
    ...barberAccountRoutes,
    ...merchantAccountRoutes,
    ...barberAuthRoutes,
    ...customerCatalogRoutes,
    ...customerShopRoutes,
    ...customerHomeServiceRoutes,
    ...customerStoreRoutes,
    ...customerEngagementRoutes,
    ...customerNotificationsRoutes,
    ...barberShellRoutes,
    ...barberBarberShopRoutes,
    ...barberHomeServiceRoutes,
    ...barberEngagementRoutes,
    ...barberCatalogRoutes,
    ...barberShopRoutes,
    ...barberStoreRoutes,
    ...barberWalletRoutes,
    ...barberMoneyRoutes,
    ...customerWalletRoutes,
    ...barberNotificationsRoutes,
    ...barberTeamRoutes,
    ...barberAttendanceRoutes,
    ...barberSalaryRoutes,
    ...barberBookingRoutes,
    ...merchantShellRoutes,
    ...merchantCatalogRoutes,
    ...merchantNotificationsRoutes,
    ...barberStorefrontRoutes,
    ...merchantEngagementRoutes,
    ...merchantWalletRoutes,
];
