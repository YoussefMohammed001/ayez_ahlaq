import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/profile/domain/entities/barber_profile.dart';
import '../../../features/barber/profile/presentation/pages/barber_shop_menu_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';

final List<RouteBase> barberShopRoutes = [
  GoRoute(
    path: Routes.barberShopMenuScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberDocumentsCubit,
      child: BarberShopMenuScreen(profile: state.extra as BarberProfile?),
    ),
  ),
];
