import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/barber/profile/presentation/pages/barber_delete_account_screen.dart';
import '../../../features/barber/profile/domain/entities/barber_profile.dart';
import '../../../features/barber/profile/presentation/pages/barber_location_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_change_password_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_purchases_menu_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_financial_menu_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_account_menu_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_profile_details_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_app_settings_menu_screen.dart';
import '../../../features/barber/profile/presentation/pages/barber_support_menu_screen.dart';
import '../../../features/barber/documents/presentation/helpers/document_view_args.dart'
    as barber_documents;
import '../../../features/barber/documents/presentation/pages/document_viewer_screen.dart'
    as barber_documents;
import '../../../features/barber/documents/presentation/pages/barber_documents_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/barber_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> barberAccountRoutes = [
  GoRoute(
    path: Routes.barberDeleteAccountScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberProfileCubit,
      child: const BarberDeleteAccountScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberLocationScreen,
    builder: (_, state) => BlocProvider.value(
      value: barberProfileCubit,
      child: BarberLocationScreen(profile: state.extra as BarberProfile?),
    ),
  ),
  GoRoute(
    path: Routes.barberChangePasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberProfileCubit,
      child: const BarberChangePasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberPurchasesMenuScreen,
    builder: (_, __) => const BarberPurchasesMenuScreen(),
  ),
  GoRoute(
    path: Routes.barberFinancialMenuScreen,
    builder: (_, __) => const BarberFinancialMenuScreen(),
  ),
  GoRoute(
    path: Routes.barberAppSettingsMenuScreen,
    builder: (_, __) => const BarberAppSettingsMenuScreen(),
  ),
  GoRoute(
    path: Routes.barberAccountMenuScreen,
    builder: (_, __) => const BarberAccountMenuScreen(),
  ),
  GoRoute(
    path: Routes.barberProfileDetailsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberProfileCubit,
      child: const BarberProfileDetailsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberSupportMenuScreen,
    builder: (_, __) => const BarberSupportMenuScreen(),
  ),
  GoRoute(
    path: Routes.barberDocumentsScreen,
    builder: (_, __) => BlocProvider.value(
      value: barberDocumentsCubit,
      child: const BarberDocumentsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.barberDocumentViewerScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<barber_documents.DocumentViewArgs>(state),
    builder: (_, state) {
      final args = state.extra as barber_documents.DocumentViewArgs;
      return barber_documents.DocumentViewerScreen(
        document: args.document,
        bytes: args.bytes,
      );
    },
  ),
];
