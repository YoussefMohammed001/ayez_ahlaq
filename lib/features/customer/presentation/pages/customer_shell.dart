import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../core/widgets/flat_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../booking/presentation/manager/my_bookings_cubit.dart';
import '../../favorites/presentation/manager/favorites_cubit.dart';
import '../../favorites/presentation/pages/favorites_screen.dart';
import '../../notifications/presentation/manager/customer_notifications_cubit.dart';
import '../../profile/presentation/manager/customer_profile_cubit.dart';
import '../../profile/presentation/pages/customer_profile_screen.dart';
import '../../ratings/presentation/widgets/visit_rating_prompt.dart';
import '../../shops/presentation/manager/customer_shops_cubit.dart';
import '../../store/presentation/manager/customer_store_feed_cubit.dart';
import '../../store/presentation/manager/store_orders_cubit.dart';
import '../../store/presentation/pages/customer_store_feed_screen.dart';
import '../../store/presentation/pages/my_store_orders_screen.dart';
import '../../../../generated/l10n.dart';
import '../../../../shared/guest/guest_placeholder.dart';
import 'customer_dashboard_screen.dart';

class CustomerShell extends StatefulWidget {
  final VoidCallback onLogout;

  const CustomerShell({super.key, required this.onLogout});

  @override
  State<CustomerShell> createState() => _CustomerShellState();
}

class _CustomerShellState extends State<CustomerShell> {
  int _index = 0;
  bool _storeFeedLoaded = false;
  bool _isGuest = true;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.storefront_outlined, S().storeTitle),
    NavTabItem(Icons.receipt_long_outlined, S().tabOrders),
    NavTabItem(Icons.favorite_border_rounded, S().tabFavorites),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final isGuest = await UserHelpers.isGuest();
    if (!mounted) return;
    setState(() => _isGuest = isGuest);

    context.read<CustomerShopsCubit>().loadShops();
    if (isGuest) return;

    context.read<StoreOrdersCubit>().loadOrders();
    context.read<FavoritesCubit>().loadFavorites();
    context.read<CustomerProfileCubit>().loadProfile();
    context.read<CustomerNotificationsCubit>().refreshUnseenCount();
    final bookingsCubit = context.read<MyBookingsCubit>();
    bookingsCubit.loadBookings();

    final rated = await VisitRatingPrompt.checkAndShow(context);
    if (rated) bookingsCubit.loadBookings();
  }

  void _onTabTapped(int index) {
    if (index == 1 && !_storeFeedLoaded) {
      _storeFeedLoaded = true;
      context.read<CustomerStoreFeedCubit>().load();
    }
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          CustomerDashboardScreen(
            onGoToTab: _onTabTapped,
            isGuest: _isGuest,
          ),
          const CustomerStoreFeedScreen(),
          _isGuest ? const GuestPlaceholder() : const MyStoreOrdersScreen(),
          _isGuest ? const GuestPlaceholder() : const FavoritesScreen(),
          _isGuest
              ? const GuestPlaceholder()
              : CustomerProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: FlatBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: _onTabTapped,
      ),
    );
  }
}
