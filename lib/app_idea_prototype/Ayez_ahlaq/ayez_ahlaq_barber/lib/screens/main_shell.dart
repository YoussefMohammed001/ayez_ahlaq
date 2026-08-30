import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'queue_screen.dart';
import 'store_screen.dart';
import 'team_screen.dart';
import 'earnings_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index = widget.initialIndex;

  static const _tabs = [
    NavTabItem(Icons.home_rounded, 'لوحتي'),
    NavTabItem(Icons.list_alt_rounded, 'الطابور'),
    NavTabItem(Icons.shopping_bag_rounded, 'المتجر'),
    NavTabItem(Icons.groups_rounded, 'الفريق'),
    NavTabItem(Icons.account_balance_wallet_rounded, 'أرباحي'),
    NavTabItem(Icons.person_rounded, 'حسابي'),
  ];

  void _goToTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(onGoToQueue: () => _goToTab(1)),
      const QueueScreen(),
      const StoreScreen(),
      const TeamScreen(),
      const EarningsScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNavBar(items: _tabs, currentIndex: _index, onTap: _goToTab),
    );
  }
}
