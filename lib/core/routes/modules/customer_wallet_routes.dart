import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/wallet/domain/entities/wallet_request.dart';
import '../../../shared/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../../../shared/wallet/presentation/manager/wallet_cubit.dart';
import '../../../shared/wallet/presentation/manager/wallet_requests_cubit.dart';
import '../../../shared/wallet/presentation/pages/create_wallet_request_screen.dart';
import '../../../shared/wallet/presentation/pages/wallet_request_attachment_screen.dart';
import '../../../shared/wallet/presentation/pages/wallet_request_detail_screen.dart';
import '../../../shared/wallet/presentation/pages/wallet_requests_screen.dart';
import '../../../shared/wallet/presentation/pages/wallet_screen.dart';
import '../../../shared/wallet/presentation/wallet_routes.dart';
import '../../di/sl.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> customerWalletRoutes = [
  GoRoute(
    path: Routes.customerWalletScreen,
    builder: (_, __) => BlocProvider<WalletCubit>.value(
      value: customerWalletCubit..loadWallet(),
      child: const WalletScreen(routes: WalletRoutes.customer),
    ),
  ),
  GoRoute(
    path: Routes.customerWalletRequestsScreen,
    builder: (_, __) => BlocProvider<WalletRequestsCubit>.value(
      value: customerWalletRequestsCubit..loadRequests(),
      child: const WalletRequestsScreen(routes: WalletRoutes.customer),
    ),
  ),
  GoRoute(
    path: Routes.createCustomerWalletRequestScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CreateWalletRequestCubit>(instanceName: 'customer'),
        ),
        BlocProvider<WalletCubit>.value(value: customerWalletCubit),
      ],
      child: const CreateWalletRequestScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerWalletRequestDetailScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<WalletRequest>(state),
    builder: (_, state) => BlocProvider<WalletRequestsCubit>.value(
      value: customerWalletRequestsCubit,
      child: WalletRequestDetailScreen(
        request: state.extra as WalletRequest,
        routes: WalletRoutes.customer,
      ),
    ),
  ),
  GoRoute(
    path: Routes.customerWalletRequestAttachmentScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<Uint8List>(state),
    builder: (_, state) =>
        WalletRequestAttachmentScreen(bytes: state.extra as Uint8List),
  ),
];
