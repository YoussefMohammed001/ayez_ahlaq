import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/merchant/profile/presentation/pages/merchant_delete_account_screen.dart';
import '../../../features/merchant/documents/presentation/helpers/document_view_args.dart';
import '../../../features/merchant/documents/presentation/pages/document_viewer_screen.dart';
import '../../../features/merchant/documents/presentation/pages/merchant_documents_screen.dart';
import '../../../features/merchant/profile/domain/entities/merchant_profile.dart';
import '../../../features/merchant/profile/presentation/pages/change_password_screen.dart';
import '../../../features/merchant/profile/presentation/pages/merchant_location_screen.dart';
import '../../../features/merchant/profile/presentation/pages/merchant_phones_screen.dart';
import '../../../features/merchant/profile/presentation/pages/edit_profile_screen.dart';
import '../route_paths.dart';
import '../scoped_cubits/merchant_scoped_cubits.dart';
import '../route_guards.dart';

final List<RouteBase> merchantAccountRoutes = [
  GoRoute(
    path: Routes.merchantDeleteAccountScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantProfileCubit,
      child: const MerchantDeleteAccountScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantEditProfileScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<MerchantProfile>(state),
    builder: (_, state) => BlocProvider.value(
      value: merchantProfileCubit,
      child: EditProfileScreen(profile: state.extra as MerchantProfile),
    ),
  ),
  GoRoute(
    path: Routes.merchantChangePasswordScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantProfileCubit,
      child: const ChangePasswordScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantPhonesScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantPhonesCubit..loadPhones(),
      child: const MerchantPhonesScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantLocationScreen,
    builder: (_, state) => BlocProvider.value(
      value: merchantProfileCubit,
      child: MerchantLocationScreen(profile: state.extra as MerchantProfile?),
    ),
  ),
  GoRoute(
    path: Routes.merchantDocumentsScreen,
    builder: (_, __) => BlocProvider.value(
      value: merchantDocumentsCubit,
      child: const MerchantDocumentsScreen(),
    ),
  ),
  GoRoute(
    path: Routes.merchantDocumentViewerScreen,
    redirect: (_, state) => redirectToSplashUnlessExtraIs<DocumentViewArgs>(state),
    builder: (_, state) {
      final args = state.extra as DocumentViewArgs;
      return DocumentViewerScreen(document: args.document, bytes: args.bytes);
    },
  ),
];
