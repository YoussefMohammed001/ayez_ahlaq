import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'products_screen.dart';
import 'orders_screen.dart';
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
    NavTabItem(Icons.inventory_2_rounded, 'منتجاتي'),
    NavTabItem(Icons.receipt_long_rounded, 'الطلبات'),
    NavTabItem(Icons.person_rounded, 'حسابي'),
  ];

  void _goToTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(onGoToOrders: () => _goToTab(2)),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNavBar(items: _tabs, currentIndex: _index, onTap: _goToTab),
    );
  }
}
