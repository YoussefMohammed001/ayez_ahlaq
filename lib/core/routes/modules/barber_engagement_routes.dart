import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/sponsorship/presentation/pages/barber_sponsorship_screen.dart';
import '../../../features/barber/reviews/presentation/pages/barber_reviews_screen.dart';
import '../../../features/barber/invite/presentation/pages/barber_invite_screen.dart';
import '../../../features/barber/subscription/presentation/pages/barber_subscription_screen.dart';
import '../../../features/barber/subscription/presentation/pages/barber_subscription_requests_screen.dart';
import '../../../features/barber/broadcast/presentation/pages/barber_broadcast_screen.dart';
import '../../../features/barber/broadcast/presentation/pages/broadcast_list_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberEngagementRoutes = [
  GoRoute(
    path: Routes.barberSponsorshipScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberSponsorshipCubit..loadSponsorship(),
      child: const BarberSponsorshipScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberReviewsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberReviewsCubit..loadReviews(),
      child: const BarberReviewsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberInviteScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberInviteCubit..loadInvite(),
      child: const BarberInviteScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberSubscriptionScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberSubscriptionCubit..load(),
      child: const BarberSubscriptionScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberSubscriptionRequestsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberSubscriptionRequestsCubit..loadRequests(),
      child: const BarberSubscriptionRequestsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberBroadcastScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberBroadcastCubit,
      child: const BarberBroadcastScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberBroadcastListScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberBroadcastListCubit,
      child: const BroadcastListScreen(),
    ),
  ),
];
