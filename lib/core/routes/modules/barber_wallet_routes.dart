import '../../../features/barber/money/presentation/pages/money_pin_screen.dart';
import '../../../features/barber/money/presentation/widgets/money_pin_lock_on_exit.dart';
import '../../../generated/l10n.dart';
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
import '../scoped_cubits/barber_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> barberWalletRoutes = [
  GoRoute(
    path: Routes.barberWalletScreen,
    builder: (_, __) => BlocProvider<WalletCubit>.value(
      value: barberWalletCubit..loadWallet(),
      child: MoneyPinLockOnExit(
        pinCubit: moneyPinCubit,
        child: const WalletScreen(routes: WalletRoutes.barber),
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberWalletRequestsScreen,
    builder: (_, __) => BlocProvider<WalletRequestsCubit>.value(
      value: barberWalletRequestsCubit..loadRequests(),
      child: const WalletRequestsScreen(routes: WalletRoutes.barber),
    ),
  ),
  GoRoute(
    path: Routes.createBarberWalletRequestScreen,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CreateWalletRequestCubit>(instanceName: 'barber'),
        ),
        BlocProvider<WalletCubit>.value(value: barberWalletCubit),
      ],
      child: const CreateWalletRequestScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberWalletRequestDetailScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<WalletRequest>(state),
    builder: (_, state) => BlocProvider<WalletRequestsCubit>.value(
      value: barberWalletRequestsCubit,
      child: WalletRequestDetailScreen(
        request: state.extra as WalletRequest,
        routes: WalletRoutes.barber,
      ),
    ),
  ),
  GoRoute(
    path: Routes.barberWalletRequestAttachmentScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<Uint8List>(state),
    builder: (_, state) =>
        WalletRequestAttachmentScreen(bytes: state.extra as Uint8List),
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
