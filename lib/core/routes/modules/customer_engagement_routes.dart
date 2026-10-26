import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/customer/favorites/presentation/pages/enter_invite_code_screen.dart';
import '../../../features/customer/favorites/presentation/pages/favorites_screen.dart';
import '../../../features/customer/favorites/presentation/pages/invite_preview_screen.dart';
import '../../../features/customer/ratings/presentation/manager/customer_ratings_cubit.dart';
import '../../../features/customer/ratings/presentation/pages/customer_ratings_screen.dart';
import '../../di/services_locator.dart';
import '../route_paths.dart';
import '../scoped_cubits/customer_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> customerEngagementRoutes = [
  GoRoute(
    path: Routes.customerFavoritesScreen,
    builder: (_, __) => BlocProvider.value(
      value: customerFavoritesCubit,
      child: const FavoritesScreen(),
    ),
  ),
  GoRoute(
    path: Routes.customerEnterInviteCodeScreen,
    builder: (_, __) => const EnterInviteCodeScreen(),
  ),
  GoRoute(
    path: Routes.customerInvitePreviewScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<String>(state),
    builder: (_, state) => BlocProvider.value(
      value: customerInvitePreviewCubit,
      child: InvitePreviewScreen(inviteCode: state.extra as String),
    ),
  ),
  GoRoute(
    path: Routes.customerRatingsScreen,
    builder: (_, __) => BlocProvider(
      create: (_) => sl<CustomerRatingsCubit>()..loadRatings(),
      child: const CustomerRatingsScreen(),
    ),
  ),
];
