import 'package:go_router/go_router.dart';
import '../../../features/merchant/presentation/pages/merchant_shell.dart';
import '../route_paths.dart';
import '../merchant_providers.dart';
import '../logout_handlers.dart';

final List<RouteBase> merchantShellRoutes = [
  GoRoute(
    path: Routes.merchantShell,
    builder: (_, state) => merchantProviders(
      child: MerchantShell(
        onLogout: handleMerchantLogout,
        initialIndex: state.extra as int? ?? 0,
      ),
    ),
  ),
];
