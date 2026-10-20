import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/sponsorship/presentation/pages/merchant_sponsorship_screen.dart';
import '../../../features/merchant/subscription/presentation/pages/merchant_subscription_screen.dart';
import '../../../features/merchant/subscription/presentation/pages/merchant_subscription_requests_screen.dart';
import '../../../features/merchant/broadcast/presentation/pages/merchant_broadcast_list_screen.dart';
import '../../../features/merchant/broadcast/presentation/pages/merchant_broadcast_screen.dart';
import '../../../features/merchant/profile/domain/entities/merchant_profile.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';

final List<RouteBase> merchantEngagementRoutes = [
  GoRoute(
    path: Routes.merchantSponsorshipScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantSponsorshipCubit..loadSponsorship(),
      child: const MerchantSponsorshipScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantSubscriptionScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantSubscriptionCubit..load(),
      child: const MerchantSubscriptionScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantSubscriptionRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantSubscriptionRequestsCubit..loadRequests(),
      child: const MerchantSubscriptionRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantBroadcastScreen,
    builder: (_, state) => BlocProvider.value(
      value: merchantBroadcastCubit,
      child: MerchantBroadcastScreen(profile: state.extra as MerchantProfile?),
    ),
  ),
  GoRoute(
    path: Routes.merchantBroadcastListScreen,
    builder: (_, state) => BlocProvider.value(
      value: merchantBroadcastListCubit,
      child: MerchantBroadcastListScreen(
        profile: state.extra as MerchantProfile?,
      ),
    ),
  ),
];
