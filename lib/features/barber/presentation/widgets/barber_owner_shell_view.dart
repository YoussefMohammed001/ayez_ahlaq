import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/lazy_tab.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../../../core/widgets/notched_bottom_nav_bar.dart';
import '../../../../generated/l10n.dart';
import '../../bookings/presentation/pages/bookings_home_screen.dart';
import '../../home/presentation/pages/barber_home_screen.dart';
import '../../profile/presentation/pages/barber_profile_screen.dart';
import '../../storefront/presentation/pages/storefront_home_screen.dart';
import '../../tour/presentation/manager/barber_tour_cubit.dart';
import '../../tour/presentation/widgets/barber_tour_host.dart';
import '../../tour/presentation/widgets/barber_tour_targets.dart';
import 'barber_store_fab.dart';

class BarberOwnerShellView extends StatelessWidget {
  final int index;
  final Set<int> visitedTabs;
  final BarberTourTargets tour;
  final ValueChanged<int> onSelectTab;
  final Future<void> Function() onLogout;

  const BarberOwnerShellView({
    super.key,
    required this.index,
    required this.visitedTabs,
    required this.tour,
    required this.onSelectTab,
    required this.onLogout,
  });

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.event_available_rounded, S().tabBookings),
    NavTabItem(Icons.storefront_outlined, S().storefrontTitle),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  Widget build(BuildContext context) {
    final tourCubit = context.read<BarberTourCubit>();

    return BarberTourHost(
      tourCubit: tourCubit,
      seenKey: PreferencesKeys.barberOwnerTourSeen,
      sequence: () => tour.ownerSequence,
      onShowHome: () => onSelectTab(0),
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children: [
            BarberHomeScreen(
              onGoToTab: onSelectTab,
              tour: tour,
              onStartTour: tourCubit.requestTour,
            ),
            LazyTab(
              visited: visitedTabs.contains(1),
              child: const BookingsHomeScreen(),
            ),
            LazyTab(
              visited: visitedTabs.contains(2),
              child: const StorefrontHomeScreen(),
            ),
            BarberProfileScreen(onLogout: onLogout),
          ],
        ),
        floatingActionButton: BarberStoreFab(
          onPressed: () => context.push(Routes.barberStoreMerchantsScreen),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NotchedBottomNavBar(
          items: _tabs,
          currentIndex: index,
          onTap: onSelectTab,
          tabBuilder: tour.ownerTab,
        ),
      ),
    );
  }
}
