import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/profile/presentation/pages/customer_change_password_screen.dart';
import '../../../features/customer/profile/presentation/pages/customer_delete_account_screen.dart';
import '../../../features/customer/profile/presentation/pages/customer_account_menu_screen.dart';
import '../../../features/customer/profile/presentation/pages/customer_app_settings_menu_screen.dart';
import '../../../features/customer/profile/presentation/pages/customer_support_menu_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';

final List<RouteBase> customerAccountRoutes = [
  GoRoute(
    path: Routes.customerChangePasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerProfileCubit,
      child: const CustomerChangePasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerDeleteAccountScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerProfileCubit,
      child: const CustomerDeleteAccountScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerAccountMenuScreen,
    builder: (_, __) => const CustomerAccountMenuScreen(),
  ),
  GoRoute(
    path: Routes.customerAppSettingsMenuScreen,
    builder: (_, __) => const CustomerAppSettingsMenuScreen(),
  ),
  GoRoute(
    path: Routes.customerSupportMenuScreen,
    builder: (_, __) => const CustomerSupportMenuScreen(),
  ),
];
