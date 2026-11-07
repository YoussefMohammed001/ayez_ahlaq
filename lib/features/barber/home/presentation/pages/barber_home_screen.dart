import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/responsive/adaptive_body.dart';
import '../../../../../core/responsive/adaptive_two_pane.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../../../tour/presentation/widgets/barber_tour_targets.dart';
import '../widgets/barber_home_greeting.dart';
import '../widgets/barber_home_refresh.dart';
import '../widgets/earnings_unlock_loader.dart';
import '../widgets/home_bookings_section.dart';
import '../widgets/home_leading_section.dart';

class BarberHomeScreen extends StatelessWidget {
  final ValueChanged<int> onGoToTab;
  final BarberTourTargets tour;
  final VoidCallback onStartTour;

  const BarberHomeScreen({
    super.key,
    required this.onGoToTab,
    required this.tour,
    required this.onStartTour,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshableStateView(
          onRefresh: () => BarberHomeRefresh.run(context),
          child: AdaptiveBody(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EarningsUnlockLoader(),
                  BlocBuilder<BarberProfileCubit, BarberProfileState>(
                    builder: (context, state) => BarberHomeGreeting(
                      shopName: state.profile?.shopName ?? '',
                      onAvatarTap: () => onGoToTab(3),
                      onNotificationsTap: () =>
                          context.push(Routes.barberNotificationsScreen),
                      notificationsTourKey: tour.notifications,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  AdaptiveTwoPane(
                    leading: HomeLeadingSection(
                      onGoToTab: onGoToTab,
                      tour: tour,
                      onStartTour: onStartTour,
                    ),
                    trailing: HomeBookingsSection(
                      onGoToTab: onGoToTab,
                      tour: tour,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
