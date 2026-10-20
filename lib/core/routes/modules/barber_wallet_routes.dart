import '../../../features/barber/money/presentation/widgets/money_pin_lock_on_exit.dart';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/wallet/domain/entities/wallet_request.dart'
    as barber_wallet;
import '../../../features/barber/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as barber_wallet;
import '../../../features/barber/wallet/presentation/pages/barber_wallet_requests_screen.dart';
import '../../../features/barber/wallet/presentation/pages/create_wallet_request_screen.dart';
import '../../../features/barber/wallet/presentation/pages/wallet_request_detail_screen.dart';
import '../../../features/barber/wallet/presentation/pages/wallet_request_attachment_screen.dart'
    as barber_wallet;
import '../../../features/barber/money/presentation/pages/money_pin_screen.dart';
import '../../../generated/l10n.dart';
import '../../../features/barber/wallet/presentation/pages/barber_wallet_screen.dart';
import '../../di/services_locator.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberWalletRoutes = [
  GoRoute(
    path: Routes.barberWalletScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberWalletCubit..loadWallet(),
      child: MoneyPinLockOnExit(
        pinCubit: moneyPinCubit,
        child: const BarberWalletScreen(),
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberWalletRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberWalletRequestsCubit..loadRequests(),
      child: const BarberWalletRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.createBarberWalletRequestScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<barber_wallet.CreateWalletRequestCubit>(),
      child: const CreateWalletRequestScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberWalletRequestDetailScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberWalletRequestsCubit,
      child: WalletRequestDetailScreen(
        request: state.extra as barber_wallet.WalletRequest,
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberWalletRequestAttachmentScreen,
    builder: (_, state) => barber_wallet.WalletRequestAttachmentScreen(
      bytes: state.extra as Uint8List,
    ),
  ),
  GoRoute(
    path: Routes.barberWalletPinScreen,
    builder: (_, __) => BlocProvider.value(
      value: moneyPinCubit,
      child: MoneyPinScreen(
        redirectRoute: Routes.barberWalletScreen,
        title: S().walletTitle,
      ),
    ),
  ),
];
