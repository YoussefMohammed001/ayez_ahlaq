import 'package:flutter/material.dart';
import '../../../../core/widgets/flat_bottom_nav_bar.dart';
import '../../../../core/widgets/nav_tab_item.dart';
import '../../../../generated/l10n.dart';
import '../../bookings/presentation/pages/team_member_bookings_screen.dart';
import '../../home/presentation/pages/team_member_home_screen.dart';
import '../../profile/presentation/pages/barber_profile_screen.dart';

class BarberTeamMemberShell extends StatefulWidget {
  final Future<void> Function() onLogout;

  const BarberTeamMemberShell({super.key, required this.onLogout});

  @override
  State<BarberTeamMemberShell> createState() => _BarberTeamMemberShellState();
}

class _BarberTeamMemberShellState extends State<BarberTeamMemberShell> {
  int _index = 0;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.home_rounded, S().tabHome),
    NavTabItem(Icons.event_available_rounded, S().tabBookings),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          TeamMemberHomeScreen(onGoToTab: (i) => setState(() => _index = i)),
          const TeamMemberBookingsScreen(),
          BarberProfileScreen(onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: FlatBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
