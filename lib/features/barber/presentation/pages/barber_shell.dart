import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../bookings/presentation/manager/bookings_cubit.dart';
import '../../bookings/presentation/pages/bookings_home_screen.dart';
import '../../notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../profile/presentation/pages/barber_profile_screen.dart';
import '../../services/presentation/manager/barber_services_cubit.dart';
import '../../store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../store/presentation/pages/barber_store_merchants_screen.dart';
import '../../../../generated/l10n.dart';

class BarberShell extends StatefulWidget {
  final VoidCallback onLogout;

  const BarberShell({super.key, required this.onLogout});

  @override
  State<BarberShell> createState() => _BarberShellState();
}

class _BarberShellState extends State<BarberShell> {
  int _index = 0;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.event_available_rounded, S().tabBookings),
    NavTabItem(Icons.storefront_outlined, S().tabStore),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  void initState() {
    super.initState();
    context.read<BarberProfileCubit>().loadProfile();
    context.read<BarberServicesCubit>().loadServices();
    context.read<BarberStoreMerchantsCubit>().loadMerchants();
    context.read<BarberNotificationsCubit>().refreshUnseenCount();
    context.read<BookingsCubit>().loadPending();
    context.read<BookingsCubit>().loadQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const BookingsHomeScreen(),
          const BarberStoreMerchantsScreen(),
          BarberProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
