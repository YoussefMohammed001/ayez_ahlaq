import 'package:go_router/go_router.dart';
import '../session/session_scope.dart';
import 'route_paths.dart';
import 'scoped_cubits/merchant_scoped_cubits.dart';
import 'scoped_cubits/customer_scoped_cubits.dart';
import 'scoped_cubits/barber_scoped_cubits.dart';
import 'root_navigator_key.dart';
import '../analytics/app_analytics.dart';
import '../../shared/user_type.dart';
import '../di/services_locator.dart';
import '../../features/barber/auto_attendance/domain/use_cases/disable_auto_attendance_use_case.dart';

Future<void> _stopAutoAttendance() async {
  try {
    await sl<DisableAutoAttendanceUseCase>()();
  } catch (_) {}
}

Future<void> handleMerchantLogout() async {
  sl<AppAnalytics>().loggedOut(UserType.merchant.apiSegment);
  await merchantAuthCubit.logout();
  SessionScope.reset();
  rootNavigatorKey.currentContext?.go(Routes.loginScreen);
}

Future<void> handleBarberLogout() async {
  sl<AppAnalytics>().loggedOut(UserType.barber.apiSegment);
  await _stopAutoAttendance();
  await barberAuthCubit.logout();
  SessionScope.reset();
  rootNavigatorKey.currentContext?.go(Routes.barberLoginScreen);
}

Future<void> handleCustomerLogout() async {
  sl<AppAnalytics>().loggedOut(UserType.customer.apiSegment);
  await customerAuthCubit.logout();
  SessionScope.reset();
  rootNavigatorKey.currentContext?.go(Routes.customerLoginScreen);
}
