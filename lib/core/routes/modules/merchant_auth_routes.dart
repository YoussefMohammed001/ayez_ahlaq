import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/auth/presentation/pages/merchant_verify_otp_screen.dart';
import '../../../features/merchant/auth/presentation/pages/merchant_forgot_password_screen.dart';
import '../../../features/merchant/auth/presentation/pages/merchant_reset_password_otp_screen.dart';
import '../../../features/merchant/auth/presentation/pages/merchant_reset_password_screen.dart';
import '../../../features/merchant/auth/presentation/pages/merchant_login_screen.dart';
import '../../../features/merchant/auth/presentation/pages/merchant_register_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> merchantAuthRoutes = [
  GoRoute(
    path: Routes.loginScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantAuthCubit,
      child: const MerchantLoginScreen(),
    ),
  ),
  GoRoute(
    path: Routes.registerScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantAuthCubit,
      child: const MerchantRegisterScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantVerifyOtpScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantAuthCubit,
      child: const MerchantVerifyOtpScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantForgotPasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantAuthCubit,
      child: const MerchantForgotPasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantResetPasswordOtpScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantAuthCubit,
      child: const MerchantResetPasswordOtpScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantResetPasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantAuthCubit,
      child: const MerchantResetPasswordScreen(),
    ),
  ),
];
