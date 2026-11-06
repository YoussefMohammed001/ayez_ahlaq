import 'package:go_router/go_router.dart';
import '../session/session_scope.dart';
import 'route_paths.dart';
import 'scoped_cubits/merchant_scoped_cubits.dart';
import 'scoped_cubits/customer_scoped_cubits.dart';
import 'scoped_cubits/barber_scoped_cubits.dart';
import 'root_navigator_key.dart';
import '../di/services_locator.dart';
import '../../features/barber/auto_attendance/domain/use_cases/disable_auto_attendance_use_case.dart';

Future<void> handleMerchantLogout() async {
  await merchantAuthCubit.logout();
  SessionScope.reset();
  rootNavigatorKey.currentContext?.go(Routes.loginScreen);
}

Future<void> handleBarberLogout() async {
  await sl<DisableAutoAttendanceUseCase>()();
  await barberAuthCubit.logout();
  SessionScope.reset();
  rootNavigatorKey.currentContext?.go(Routes.barberLoginScreen);
}

Future<void> handleCustomerLogout() async {
  await customerAuthCubit.logout();
  SessionScope.reset();
  rootNavigatorKey.currentContext?.go(Routes.customerLoginScreen);
}
