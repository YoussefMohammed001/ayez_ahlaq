import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/wallet/domain/entities/wallet_request.dart';
import '../../../shared/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../../../features/merchant/wallet/presentation/pages/merchant_wallet_screen.dart';
import '../../../features/merchant/wallet/presentation/pages/merchant_wallet_requests_screen.dart';
import '../../../features/merchant/wallet/presentation/pages/create_merchant_wallet_request_screen.dart';
import '../../../features/merchant/wallet/presentation/pages/merchant_wallet_request_detail_screen.dart';
import '../../../features/merchant/wallet/presentation/pages/wallet_request_attachment_screen.dart'
    as merchant_wallet;
import '../../di/services_locator.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> merchantWalletRoutes = [
  GoRoute(
    path: Routes.merchantWalletScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantWalletCubit..loadWallet(),
      child: const MerchantWalletScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantWalletRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantWalletRequestsCubit..loadRequests(),
      child: const MerchantWalletRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.createMerchantWalletRequestScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CreateWalletRequestCubit>(instanceName: 'merchant'),
        ),
        BlocProvider.value(value: merchantWalletCubit),
      ],
      child: const CreateMerchantWalletRequestScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantWalletRequestDetailScreen,
    builder: (_, state) => BlocProvider.value(
      value: merchantWalletRequestsCubit,
      child: MerchantWalletRequestDetailScreen(
        request: state.extra as WalletRequest,
      ),
    ),
  ),
  GoRoute(
    path: Routes.merchantWalletRequestAttachmentScreen,
    builder: (_, state) => merchant_wallet.WalletRequestAttachmentScreen(
      bytes: state.extra as Uint8List,
    ),
  ),
];
