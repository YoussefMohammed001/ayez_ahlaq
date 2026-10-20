import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/auth/presentation/pages/customer_login_screen.dart';
import '../../../features/customer/auth/presentation/pages/customer_register_screen.dart';
import '../../../features/customer/auth/presentation/pages/customer_verify_otp_screen.dart';
import '../../../features/customer/auth/presentation/pages/customer_forgot_password_screen.dart';
import '../../../features/customer/auth/presentation/pages/customer_reset_password_otp_screen.dart';
import '../../../features/customer/auth/presentation/pages/customer_reset_password_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';

final List<RouteBase> customerAuthRoutes = [
  GoRoute(
    path: Routes.customerLoginScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerAuthCubit,
      child: const CustomerLoginScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerRegisterScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerAuthCubit,
      child: const CustomerRegisterScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerVerifyOtpScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerAuthCubit,
      child: const CustomerVerifyOtpScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerForgotPasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerAuthCubit,
      child: const CustomerForgotPasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerResetPasswordOtpScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerAuthCubit,
      child: const CustomerResetPasswordOtpScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerResetPasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerAuthCubit,
      child: const CustomerResetPasswordScreen(),
    ),
  ),
];
