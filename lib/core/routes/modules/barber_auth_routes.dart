import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/auth/presentation/pages/barber_register_screen.dart';
import '../../../features/barber/auth/presentation/pages/barber_verify_otp_screen.dart';
import '../../../features/barber/auth/presentation/pages/barber_forgot_password_screen.dart';
import '../../../features/barber/auth/presentation/pages/barber_reset_password_otp_screen.dart';
import '../../../features/barber/auth/presentation/pages/barber_reset_password_screen.dart';
import '../../../features/barber/auth/presentation/pages/barber_login_screen.dart';
import '../../../features/barber/auth/presentation/pages/barber_role_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberAuthRoutes = [
  GoRoute(
    path: Routes.barberRegisterScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberAuthCubit,
      child: const BarberRegisterScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberVerifyOtpScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberAuthCubit,
      child: const BarberVerifyOtpScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberForgotPasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberAuthCubit,
      child: const BarberForgotPasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberResetPasswordOtpScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberAuthCubit,
      child: const BarberResetPasswordOtpScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberResetPasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberAuthCubit,
      child: const BarberResetPasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberRoleScreen,
    builder: (_, __) => const BarberRoleScreen(),
  ),
  GoRoute(
    path: Routes.barberLoginScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberAuthCubit,
      child: const BarberLoginScreen(),
    ),
  ),
];
