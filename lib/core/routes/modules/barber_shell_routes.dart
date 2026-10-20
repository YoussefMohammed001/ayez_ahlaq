import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/presentation/pages/barber_shell.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';
import '../logout_handlers.dart';

final List<RouteBase> barberShellRoutes = [
  GoRoute(
    path: Routes.barberShell,
    builder: (_, state) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: barberProfileCubit),
        BlocProvider.value(value: barberDocumentsCubit),
        BlocProvider.value(value: barberServicesCubit),
        BlocProvider.value(value: ownServicesCubit),
        BlocProvider.value(value: shopHaircutStylesCubit),
        BlocProvider.value(value: barberStoreMerchantsCubit),
        BlocProvider.value(value: barberStoreCartCubit),
        BlocProvider.value(value: barberNotificationsCubit),
        BlocProvider.value(value: bookingsCubit),
        BlocProvider.value(value: barberStorefrontProductsCubit),
        BlocProvider.value(value: barberStorefrontCategoriesCubit),
        BlocProvider.value(value: barberStorefrontDeliveryCubit),
        BlocProvider.value(value: barberStorefrontOrdersCubit),
        BlocProvider.value(value: homeServiceSettingsCubit),
        BlocProvider.value(value: barberHomeServiceRequestsCubit),
        BlocProvider.value(value: homeServiceBroadcastCubit),
        BlocProvider.value(value: earningsCubit),
        BlocProvider.value(value: barberSubscriptionCubit),
        BlocProvider.value(value: moneyPinCubit),
      ],
      child: BarberShell(
        onLogout: handleBarberLogout,
        initialIndex: state.extra as int? ?? 0,
      ),
    ),
  ),
];
