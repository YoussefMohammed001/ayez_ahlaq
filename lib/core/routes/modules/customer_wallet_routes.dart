import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/wallet/domain/entities/wallet_request.dart';
import '../../../shared/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../../../features/customer/wallet/presentation/pages/customer_wallet_screen.dart';
import '../../../features/customer/wallet/presentation/pages/customer_wallet_requests_screen.dart';
import '../../../features/customer/wallet/presentation/pages/create_customer_wallet_request_screen.dart';
import '../../../features/customer/wallet/presentation/pages/customer_wallet_request_detail_screen.dart';
import '../../../features/customer/wallet/presentation/pages/wallet_request_attachment_screen.dart'
    as customer_wallet;
import '../../di/services_locator.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';

final List<RouteBase> customerWalletRoutes = [
  GoRoute(
    path: Routes.customerWalletScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerWalletCubit..loadWallet(),
      child: const CustomerWalletScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerWalletRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerWalletRequestsCubit..loadRequests(),
      child: const CustomerWalletRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.createCustomerWalletRequestScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<CreateWalletRequestCubit>(instanceName: 'customer'),
      child: const CreateCustomerWalletRequestScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerWalletRequestDetailScreen,
    builder: (_, state) => BlocProvider.value(
      value: customerWalletRequestsCubit,
      child: CustomerWalletRequestDetailScreen(
        request: state.extra as WalletRequest,
      ),
    ),
  ),
  GoRoute(
    path: Routes.customerWalletRequestAttachmentScreen,
    builder: (_, state) => customer_wallet.WalletRequestAttachmentScreen(
      bytes: state.extra as Uint8List,
    ),
  ),
];
