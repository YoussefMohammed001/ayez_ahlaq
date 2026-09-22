import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../categories/presentation/manager/merchant_categories_cubit.dart';
import '../../dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../documents/presentation/manager/merchant_documents_cubit.dart';
import '../../documents/presentation/manager/merchant_documents_state.dart';
import '../../documents/presentation/pages/merchant_documents_screen.dart';
import '../../notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../../../shared/widgets/blocking_gate.dart';
import '../../dashboard/presentation/pages/merchant_dashboard_screen.dart';
import '../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../products/presentation/manager/merchant_products_cubit.dart';
import '../../products/presentation/pages/merchant_products_screen.dart';
import '../../orders/presentation/pages/merchant_orders_screen.dart';
import '../../profile/presentation/manager/merchant_profile_cubit.dart';
import '../../profile/presentation/manager/merchant_profile_state.dart';
import '../../profile/presentation/pages/merchant_force_change_password_screen.dart';
import '../../profile/presentation/pages/merchant_location_screen.dart';
import '../../profile/presentation/pages/merchant_profile_screen.dart';
import '../../subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../../../generated/l10n.dart';

class MerchantShell extends StatefulWidget {
  final Future<void> Function() onLogout;
  final int initialIndex;

  const MerchantShell({super.key, required this.onLogout, this.initialIndex = 0});

  @override
  State<MerchantShell> createState() => _MerchantShellState();
}

class _MerchantShellState extends State<MerchantShell> {
  late int _index = widget.initialIndex;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabDashboard),
    NavTabItem(Icons.inventory_2_rounded, S().tabProducts),
    NavTabItem(Icons.receipt_long_rounded, S().tabOrders),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  void initState() {
    super.initState();
    context.read<MerchantDashboardCubit>().loadDashboard();
    context.read<MerchantProductsCubit>().loadProducts();
    context.read<MerchantOrdersCubit>().loadOrders();
    context.read<MerchantProfileCubit>().loadProfile();
    context.read<MerchantCategoriesCubit>().loadCategories();
    context.read<MerchantDiscountsCubit>().loadDiscounts();
    context.read<MerchantDocumentsCubit>().loadDocuments();
    context.read<MerchantNotificationsCubit>().refreshUnseenCount();
    context.read<MerchantSubscriptionCubit>().load();
  }

  void _goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
      buildWhen: (previous, current) => previous.profile != current.profile,
      builder: (context, profileState) {
        final profile = profileState.profile;
        return BlockingGate(
          isBlocked: profile != null && profile.mustChangePassword,
          title: S().forceChangePasswordTitle,
          onLogout: widget.onLogout,
          blockedBuilder: (_) => const MerchantForceChangePasswordScreen(),
          builder: (_) => BlockingGate(
            isBlocked: profile != null && profile.needsLocation,
            title: S().locationTitle,
            onLogout: widget.onLogout,
            blockedBuilder: (_) =>
                MerchantLocationScreen(profile: profile, blocking: true),
            builder: (_) => _buildDocumentsGate(),
          ),
        );
      },
    );
  }

  Widget _buildDocumentsGate() {
    return BlocBuilder<MerchantDocumentsCubit, MerchantDocumentsState>(
      buildWhen: (previous, current) =>
          previous.missingRequiredCount != current.missingRequiredCount,
      builder: (context, documentsState) => BlockingGate(
        isBlocked: documentsState.missingRequiredCount > 0,
        title: S().documentsBlockedTitle,
        onLogout: widget.onLogout,
        blockedBuilder: (_) => const MerchantDocumentsScreen(blocking: true),
        builder: (_) => _buildShell(),
      ),
    );
  }

  Widget _buildShell() {
    return Scaffold(
      body: BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
        builder: (context, state) {
          return IndexedStack(
            index: _index,
            children: [
              MerchantDashboardScreen(
                onGoToOrders: () => _goToTab(2),
                onGoToProducts: () => _goToTab(1),
                onGoToProfile: () => _goToTab(3),
                businessName: state.profile?.businessName ?? '',
              ),
              const MerchantProductsScreen(),
              const MerchantOrdersScreen(),
              MerchantProfileScreen(onLogout: widget.onLogout),
            ],
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: _goToTab,
      ),
    );
  }
}
