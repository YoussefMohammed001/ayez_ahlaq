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
import '../scoped_cubits/merchant_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> merchantWalletRoutes = [
  GoRoute(
    path: Routes.merchantWalletScreen,
    builder: (_, __) => BlocProvider<WalletCubit>.value(
      value: merchantWalletCubit..loadWallet(),
      child: const WalletScreen(routes: WalletRoutes.merchant),
    ),
  ),
  GoRoute(
    path: Routes.merchantWalletRequestsScreen,
    builder: (_, __) => BlocProvider<WalletRequestsCubit>.value(
      value: merchantWalletRequestsCubit..loadRequests(),
      child: const WalletRequestsScreen(routes: WalletRoutes.merchant),
    ),
  ),
  GoRoute(
    path: Routes.createMerchantWalletRequestScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CreateWalletRequestCubit>(instanceName: 'merchant'),
        ),
        BlocProvider<WalletCubit>.value(value: merchantWalletCubit),
      ],
      child: const CreateWalletRequestScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantWalletRequestDetailScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<WalletRequest>(state),
    builder: (_, state) => BlocProvider<WalletRequestsCubit>.value(
      value: merchantWalletRequestsCubit,
      child: WalletRequestDetailScreen(
        request: state.extra as WalletRequest,
        routes: WalletRoutes.merchant,
      ),
    ),
  ),
  GoRoute(
    path: Routes.merchantWalletRequestAttachmentScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<Uint8List>(state),
    builder: (_, state) =>
        WalletRequestAttachmentScreen(bytes: state.extra as Uint8List),
  ),
];
