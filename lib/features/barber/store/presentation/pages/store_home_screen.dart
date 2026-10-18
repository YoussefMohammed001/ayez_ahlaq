import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_store_orders_cubit.dart';
import '../widgets/cart_icon_button.dart';
import 'barber_store_feed_screen.dart';
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
  )..addListener(_onTabChanged);
  bool _ordersLoaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialTabIndex == 1) _loadOrdersOnce();
  }

  void _onTabChanged() {
    if (_controller.index == 1) _loadOrdersOnce();
  }

  void _loadOrdersOnce() {
    if (_ordersLoaded) return;
    _ordersLoaded = true;
    context.read<BarberStoreOrdersCubit>().loadOrders();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTabChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().storeTitle,
        trailing: const CartIconButton(),
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
          BarberStoreFeedScreen(),
          BarberStoreOrdersScreen(),
        ],
      ),
    );
  }
}
