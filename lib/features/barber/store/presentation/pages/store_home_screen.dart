import 'package:flutter/material.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/cart_icon_button.dart';
import 'barber_store_merchants_screen.dart';
import 'barber_store_orders_screen.dart';

class StoreHomeScreen extends StatefulWidget {
  final int initialTabIndex;

  const StoreHomeScreen({super.key, this.initialTabIndex = 0});

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = TabController(
    length: 2,
    vsync: this,
    initialIndex: widget.initialTabIndex,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S().storeTitle, style: HeadingStyles.h4),
        actions: const [CartIconButton()],
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: S().storeTitle),
            Tab(text: S().storeOrdersTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          BarberStoreMerchantsScreen(),
          BarberStoreOrdersScreen(),
        ],
      ),
    );
  }
}
