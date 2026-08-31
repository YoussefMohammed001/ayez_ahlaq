import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../env/env.dart';
import '../../features/merchant/auth/presentation/manager/merchant_auth_cubit.dart';
import '../../features/merchant/auth/presentation/pages/merchant_login_screen.dart';
import '../../features/merchant/auth/presentation/pages/merchant_register_screen.dart';
import '../../features/merchant/categories/presentation/manager/merchant_categories_cubit.dart';
import '../../features/merchant/categories/presentation/pages/merchant_categories_screen.dart';
import '../../features/merchant/dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../features/merchant/delivery/presentation/manager/merchant_delivery_cubit.dart';
import '../../features/merchant/delivery/presentation/pages/merchant_delivery_screen.dart';
import '../../features/merchant/discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../features/merchant/discounts/domain/entities/discount.dart';
import '../../features/merchant/discounts/presentation/pages/discount_form_screen.dart';
import '../../features/merchant/discounts/presentation/pages/merchant_discounts_screen.dart';
import '../../features/merchant/orders/domain/entities/purchase_order.dart';
import '../../features/merchant/orders/presentation/manager/merchant_orders_cubit.dart';
import '../../features/merchant/orders/presentation/pages/order_details_screen.dart';
import '../../features/merchant/presentation/pages/merchant_shell.dart';
import '../../features/merchant/products/presentation/manager/merchant_products_cubit.dart';
import '../../features/merchant/products/domain/entities/merchant_product.dart';
import '../../features/merchant/products/presentation/pages/product_details_screen.dart';
import '../../features/merchant/products/presentation/pages/product_form_screen.dart';
import '../../features/merchant/profile/domain/entities/merchant_profile.dart';
import '../../features/merchant/profile/presentation/manager/merchant_profile_cubit.dart';
import '../../features/merchant/profile/presentation/manager/merchant_phones_cubit.dart';
import '../../features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../features/merchant/notifications/presentation/pages/merchant_notifications_screen.dart';
import '../../features/merchant/profile/presentation/pages/about_app_screen.dart';
import '../../features/merchant/profile/presentation/pages/change_password_screen.dart';
import '../../features/merchant/profile/presentation/pages/merchant_phones_screen.dart';
import '../../features/merchant/profile/presentation/pages/edit_profile_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/user_type/presentation/pages/user_type_screen.dart';
import '../di/services_locator.dart';
import 'route_observer.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final MerchantProductsCubit _productsCubit = sl<MerchantProductsCubit>();
final MerchantOrdersCubit _ordersCubit = sl<MerchantOrdersCubit>();
final MerchantDashboardCubit _dashboardCubit = sl<MerchantDashboardCubit>();
final MerchantProfileCubit _profileCubit = sl<MerchantProfileCubit>();
final MerchantAuthCubit _authCubit = sl<MerchantAuthCubit>();
final MerchantCategoriesCubit _categoriesCubit = sl<MerchantCategoriesCubit>();
final MerchantDiscountsCubit _discountsCubit = sl<MerchantDiscountsCubit>();
final MerchantPhonesCubit _phonesCubit = sl<MerchantPhonesCubit>();
final MerchantDeliveryCubit _deliveryCubit = sl<MerchantDeliveryCubit>();

final routes = GoRouter(
  initialLocation: Routes.splashScreen,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: isDevEnvironment(),
  observers: [customGoRouterObserver],
  routes: [
    GoRoute(
      path: Routes.splashScreen,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.userTypeScreen,
      builder: (_, __) => const UserTypeScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantLoginScreen(),
      ),
    ),
    GoRoute(
      path: Routes.registerScreen,
      builder: (_, __) => BlocProvider.value(
        value: _authCubit,
        child: const MerchantRegisterScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantShell,
      builder: (_, __) => _merchantProviders(
        child: MerchantShell(onLogout: _handleLogout),
      ),
    ),
    GoRoute(
      path: Routes.merchantProductFormScreen,
      builder: (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _productsCubit),
          BlocProvider.value(value: _categoriesCubit),
        ],
        child: ProductFormScreen(
          product: state.extra as MerchantProduct?,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantProductDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _productsCubit,
        child: ProductDetailsScreen(productId: state.extra as int),
      ),
    ),
    GoRoute(
      path: Routes.merchantCategoriesScreen,
      builder: (_, state) => BlocProvider.value(
        value: _categoriesCubit,
        child: MerchantCategoriesScreen(
          categoryLimit: state.extra as int? ?? 0,
        ),
      ),
    ),
    GoRoute(
      path: Routes.merchantDiscountsScreen,
      builder: (_, __) => BlocProvider.value(
        value: _discountsCubit,
        child: const MerchantDiscountsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantDiscountFormScreen,
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _discountsCubit),
          BlocProvider.value(value: _productsCubit),
        ],
        child: DiscountFormScreen(discount: __.extra as Discount?),
      ),
    ),
    GoRoute(
      path: Routes.merchantEditProfileScreen,
      builder: (_, state) => BlocProvider.value(
        value: _profileCubit,
        child: EditProfileScreen(profile: state.extra as MerchantProfile),
      ),
    ),
    GoRoute(
      path: Routes.merchantChangePasswordScreen,
      builder: (_, __) => BlocProvider.value(
        value: _profileCubit,
        child: const ChangePasswordScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantPhonesScreen,
      builder: (_, __) => BlocProvider.value(
        value: _phonesCubit..loadPhones(),
        child: const MerchantPhonesScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantNotificationsScreen,
      builder: (_, __) => BlocProvider(
        create: (_) => MerchantNotificationsCubit()..loadNotifications(),
        child: const MerchantNotificationsScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantDeliveryScreen,
      builder: (_, __) => BlocProvider.value(
        value: _deliveryCubit..loadDelivery(),
        child: const MerchantDeliveryScreen(),
      ),
    ),
    GoRoute(
      path: Routes.merchantAboutScreen,
      builder: (_, __) => const AboutAppScreen(),
    ),
    GoRoute(
      path: Routes.merchantOrderDetailsScreen,
      builder: (_, state) => BlocProvider.value(
        value: _ordersCubit,
        child: OrderDetailsScreen(order: state.extra as PurchaseOrder),
      ),
    ),
  ],
);

Widget _merchantProviders({required Widget child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _dashboardCubit),
      BlocProvider.value(value: _productsCubit),
      BlocProvider.value(value: _ordersCubit),
      BlocProvider.value(value: _profileCubit),
      BlocProvider.value(value: _categoriesCubit),
    ],
    child: child,
  );
}

Future<void> _handleLogout() async {
  await _authCubit.logout();
  rootNavigatorKey.currentContext?.go(Routes.loginScreen);
}
