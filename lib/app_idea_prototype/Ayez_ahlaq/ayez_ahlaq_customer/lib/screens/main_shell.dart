import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'store_screen.dart';
import 'bookings_screen.dart';
import 'profile_screen.dart';

/// Hosts the five bottom-nav tabs. Each tab keeps its own scroll/selection
/// state alive via [IndexedStack] instead of being rebuilt on every switch.
class MainShell extends StatefulWidget {
  final int initialIndex;
  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index = widget.initialIndex;

  static const _tabs = [
    NavTabItem(Icons.home_rounded, 'الرئيسية'),
    NavTabItem(Icons.favorite_rounded, 'المفضلة'),
    NavTabItem(Icons.shopping_bag_rounded, 'المتجر'),
    NavTabItem(Icons.calendar_month_rounded, 'حجوزاتي'),
    NavTabItem(Icons.person_rounded, 'حسابي'),
  ];

  void _goToTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onGoToFavorites: () => _goToTab(1)),
      const FavoritesScreen(),
      const StoreScreen(),
      const BookingsScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
