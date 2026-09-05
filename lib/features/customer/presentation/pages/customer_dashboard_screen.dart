import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../generated/l10n.dart';
import '../widgets/dashboard_orders_section.dart';
import '../widgets/nearest_shops_section.dart';
import '../widgets/upcoming_bookings_section.dart';

class CustomerDashboardScreen extends StatelessWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(viewLeading: false, title: S().dashboardTitle),
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
