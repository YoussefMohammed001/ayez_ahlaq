import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../../core/widgets/nav_tab_item.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../attendance/presentation/pages/member_attendance_screen.dart';
import '../../../notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../orders/presentation/pages/merchant_orders_screen.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/pages/merchant_products_screen.dart';
import '../../../profile/presentation/manager/merchant_profile_cubit.dart';
import '../../../sales/presentation/widgets/sales_tab.dart';
import '../../../team/presentation/manager/my_schedule_cubit.dart';
import '../../../team/presentation/widgets/merchant_permission_gate.dart';
import 'sub_merchant_account_view.dart';

enum _Tab { attendance, orders, products, sales, account }

class SubMerchantTabs extends StatefulWidget {
  final Future<void> Function() onLogout;
  final int initialIndex;

  const SubMerchantTabs({
    super.key,
    required this.onLogout,
    this.initialIndex = 0,
  });

  @override
  State<SubMerchantTabs> createState() => _SubMerchantTabsState();
}

class _SubMerchantTabsState extends State<SubMerchantTabs> {
  late _Tab _current = _Tab.values[widget.initialIndex];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MemberAttendanceCubit>().load();
      context.read<MerchantOrdersCubit>().loadOrders();
      context.read<MerchantProductsCubit>().loadProducts();
      context.read<MerchantProfileCubit>().loadProfile();
      context.read<MyScheduleCubit>().load();
      context.read<MerchantNotificationsCubit>().refreshUnseenCount();
    });
  }

  NavTabItem _item(_Tab tab) => switch (tab) {
    _Tab.attendance => NavTabItem(
      Icons.fingerprint_rounded,
      S().attendanceTitle,
    ),
    _Tab.orders => NavTabItem(Icons.receipt_long_rounded, S().tabOrders),
    _Tab.products => NavTabItem(Icons.inventory_2_rounded, S().tabProducts),
    _Tab.sales => NavTabItem(Icons.point_of_sale_rounded, S().salesTitle),
    _Tab.account => NavTabItem(Icons.person_rounded, S().tabAccount),
  };

  Widget _page(_Tab tab) => switch (tab) {
    _Tab.attendance => const MemberAttendanceScreen(),
    _Tab.orders => const MerchantOrdersScreen(),
    _Tab.products => const MerchantProductsScreen(),
    _Tab.sales => const SalesTab(),
    _Tab.account => SubMerchantAccountView(onLogout: widget.onLogout),
  };

  Widget _build(BuildContext context, bool canSell) {
    final tabs = [
      for (final tab in _Tab.values)
        if (tab != _Tab.sales || canSell) tab,
    ];
    final index = tabs.contains(_current) ? tabs.indexOf(_current) : 0;

    return Scaffold(
      body: IndexedStack(index: index, children: tabs.map(_page).toList()),
      bottomNavigationBar: AppBottomNavBar(
        items: tabs.map(_item).toList(),
        currentIndex: index,
        onTap: (i) => setState(() => _current = tabs[i]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MerchantPermissionGate(
      allows: MerchantPermissionGate.canSell,
      builder: _build,
    );
  }
}
