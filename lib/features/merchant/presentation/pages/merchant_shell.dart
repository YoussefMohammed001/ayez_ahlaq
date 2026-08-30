import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../categories/presentation/manager/merchant_categories_cubit.dart';
import '../../dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../dashboard/presentation/pages/merchant_dashboard_screen.dart';
import '../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../products/presentation/manager/merchant_products_cubit.dart';
import '../../products/presentation/pages/merchant_products_screen.dart';
import '../../orders/presentation/pages/merchant_orders_screen.dart';
import '../../profile/presentation/manager/merchant_profile_cubit.dart';
import '../../profile/presentation/manager/merchant_profile_state.dart';
import '../../profile/presentation/pages/merchant_profile_screen.dart';
import '../../../../generated/l10n.dart';

class MerchantShell extends StatefulWidget {
  final VoidCallback onLogout;

  const MerchantShell({super.key, required this.onLogout});

  @override
  State<MerchantShell> createState() => _MerchantShellState();
}

class _MerchantShellState extends State<MerchantShell> {
  int _index = 0;

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
  }

  void _goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
        builder: (context, state) {
          return IndexedStack(
            index: _index,
            children: [
              MerchantDashboardScreen(
                onGoToOrders: () => _goToTab(2),
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
