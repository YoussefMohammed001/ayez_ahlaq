import 'package:flutter/material.dart';
import '../../../../core/widgets/flat_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../../../generated/l10n.dart';
import '../../bookings/presentation/pages/team_member_bookings_screen.dart';
import '../../home/presentation/pages/team_member_home_screen.dart';
import '../../profile/presentation/pages/barber_profile_screen.dart';
import '../../tour/presentation/manager/barber_tour_cubit.dart';
import '../../tour/presentation/widgets/barber_tour_host.dart';
import '../../tour/presentation/widgets/barber_tour_targets.dart';
import '../../../../core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarberTeamMemberShell extends StatefulWidget {
  final Future<void> Function() onLogout;

  const BarberTeamMemberShell({super.key, required this.onLogout});

  @override
  State<BarberTeamMemberShell> createState() => _BarberTeamMemberShellState();
}

class _BarberTeamMemberShellState extends State<BarberTeamMemberShell> {
  int _index = 0;
  final _tour = BarberTourTargets();

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.event_available_rounded, S().tabBookings),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  Widget build(BuildContext context) {
    return BarberTourHost(
      tourCubit: context.read<BarberTourCubit>(),
      seenKey: PreferencesKeys.barberTeamTourSeen,
      sequence: () => _tour.teamMemberSequence,
      onShowHome: () => setState(() => _index = 0),
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: [
            TeamMemberHomeScreen(
              onGoToTab: (i) => setState(() => _index = i),
              tour: _tour,
            ),
            const TeamMemberBookingsScreen(),
            BarberProfileScreen(onLogout: widget.onLogout),
          ],
        ),
        bottomNavigationBar: FlatBottomNavBar(
          items: _tabs,
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          tabBuilder: _tour.teamMemberTab,
        ),
      ),
    );
  }
}
