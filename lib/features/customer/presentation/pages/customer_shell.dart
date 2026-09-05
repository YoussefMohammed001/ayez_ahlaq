import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../booking/presentation/manager/my_bookings_cubit.dart';
import '../../favorites/presentation/manager/favorites_cubit.dart';
import '../../favorites/presentation/pages/favorites_screen.dart';
import '../../notifications/presentation/manager/customer_notifications_cubit.dart';
import '../../profile/presentation/manager/customer_profile_cubit.dart';
import '../../profile/presentation/pages/customer_profile_screen.dart';
import '../../shops/presentation/manager/customer_shops_cubit.dart';
import '../../store/presentation/manager/store_orders_cubit.dart';
import '../../store/presentation/pages/my_store_orders_screen.dart';
import '../../../../generated/l10n.dart';
import '../widgets/customer_bottom_nav_bar.dart';
import '../widgets/customer_booking_fab.dart';
import 'customer_dashboard_screen.dart';

class CustomerShell extends StatefulWidget {
  final VoidCallback onLogout;

  const CustomerShell({super.key, required this.onLogout});

  @override
  State<CustomerShell> createState() => _CustomerShellState();
}

class _CustomerShellState extends State<CustomerShell> {
  int _index = 0;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.receipt_long_outlined, S().tabOrders),
    NavTabItem(Icons.favorite_border_rounded, S().tabFavorites),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  void initState() {
    super.initState();
    context.read<CustomerShopsCubit>().loadShops();
    context.read<StoreOrdersCubit>().loadOrders();
    context.read<FavoritesCubit>().loadFavorites();
    context.read<CustomerProfileCubit>().loadProfile();
    context.read<CustomerNotificationsCubit>().refreshUnseenCount();
    context.read<MyBookingsCubit>().loadBookings();
  }

  void _goToHomeTab() => setState(() => _index = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const CustomerDashboardScreen(),
          const MyStoreOrdersScreen(),
          const FavoritesScreen(),
          CustomerProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      floatingActionButton: CustomerBookingFab(onPressed: _goToHomeTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomerBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
