import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../../core/widgets/nav_tab_item.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../attendance/presentation/pages/member_attendance_screen.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../orders/presentation/pages/merchant_orders_screen.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../../products/presentation/pages/merchant_products_screen.dart';
import '../../../profile/presentation/manager/merchant_profile_cubit.dart';
import '../../../team/presentation/manager/my_schedule_cubit.dart';
import 'sub_merchant_account_view.dart';

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
  late int _index = widget.initialIndex;

  List<NavTabItem> get _tabs => [
    NavTabItem(Icons.fingerprint_rounded, S().attendanceTitle),
    NavTabItem(Icons.receipt_long_rounded, S().tabOrders),
    NavTabItem(Icons.inventory_2_rounded, S().tabProducts),
    NavTabItem(Icons.person_rounded, S().tabAccount),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const MemberAttendanceScreen(),
          const MerchantOrdersScreen(),
          const MerchantProductsScreen(),
          SubMerchantAccountView(onLogout: widget.onLogout),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        items: _tabs,
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }
}
