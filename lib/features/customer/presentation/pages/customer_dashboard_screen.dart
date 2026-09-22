import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/refreshable_state_view.dart';
import '../../booking/presentation/manager/my_bookings_cubit.dart';
import '../../profile/presentation/manager/customer_profile_cubit.dart';
import '../../profile/presentation/manager/customer_profile_state.dart';
import '../../shops/presentation/manager/customer_shops_cubit.dart';
import '../../store/presentation/manager/store_orders_cubit.dart';
import '../widgets/customer_home_greeting.dart';
import '../widgets/dashboard_orders_section.dart';
import '../widgets/nearest_shops_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/upcoming_bookings_section.dart';

class CustomerDashboardScreen extends StatelessWidget {
  final ValueChanged<int> onGoToTab;

  const CustomerDashboardScreen({super.key, required this.onGoToTab});

  Future<void> _refresh(BuildContext context) async {
    await Future.wait([
      context.read<CustomerProfileCubit>().loadProfile(),
      context.read<MyBookingsCubit>().loadBookings(),
      context.read<CustomerShopsCubit>().loadShops(),
      context.read<StoreOrdersCubit>().loadOrders(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshableStateView(
          onRefresh: () => _refresh(context),
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              BlocBuilder<CustomerProfileCubit, CustomerProfileState>(
                builder: (context, state) => CustomerHomeGreeting(
                  name: state.profile?.name ?? '',
                  onAvatarTap: () => onGoToTab(3),
                  onNotificationsTap: () =>
                      context.push(Routes.customerNotificationsScreen),
                ),
              ),
              SizedBox(height: 18.h),
              const QuickActionsSection(),
              const UpcomingBookingsSection(),
              const NearestShopsSection(),
              const DashboardOrdersSection(),
            ],
          ),
        ),
      ),
    );
  }
}
