import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../shared/widgets/notifications_icon_button.dart';
import '../../../../generated/l10n.dart';
import '../../notifications/presentation/widgets/customer_unseen_notifications_badge.dart';
import '../widgets/dashboard_orders_section.dart';
import '../widgets/nearest_shops_section.dart';
import '../widgets/upcoming_bookings_section.dart';

class CustomerDashboardScreen extends StatelessWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        viewLeading: false,
        title: S().dashboardTitle,
        trailing: NotificationsIconButton(
          badge: const CustomerUnseenNotificationsBadge(),
          onTap: () => context.push(Routes.customerNotificationsScreen),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: const [
          UpcomingBookingsSection(),
          NearestShopsSection(),
          DashboardOrdersSection(),
        ],
      ),
    );
  }
}
