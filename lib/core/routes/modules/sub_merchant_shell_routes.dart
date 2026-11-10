import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/sub_merchant/presentation/pages/sub_merchant_shell.dart';
import '../logout_handlers.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> subMerchantShellRoutes = [
  GoRoute(
    path: Routes.subMerchantShell,
    builder: (_, _) => BlocProvider.value(
      value: myMerchantMemberCubit,
      child: const SubMerchantShell(onLogout: handleMerchantLogout),
    ),
  ),
];
