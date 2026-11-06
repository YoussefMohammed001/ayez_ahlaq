import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../bookings/presentation/manager/bookings_state.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../../../subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../../subscription/presentation/manager/barber_subscription_state.dart';
import '../../../subscription/presentation/widgets/subscription_home_card.dart';
import '../../../profile_setup/presentation/widgets/profile_setup_card.dart';
import '../../../tour/presentation/widgets/barber_tour_targets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../widgets/barber_home_greeting.dart';
import '../widgets/barber_home_refresh.dart';
import '../widgets/earnings_unlock_loader.dart';
import '../widgets/home_alert_cards.dart';
import '../widgets/home_summary_section.dart';
import '../widgets/home_pending_section.dart';
import '../widgets/home_queue_section.dart';

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
                ProfileSetupCard(
                  onStartTour: onStartTour,
                  tourKey: tour.checklist,
                ),
                HomeSummarySection(
                  onGoToTab: onGoToTab,
                  tourKey: tour.summary,
                ),
                SizedBox(height: 14.h),
                BlocBuilder<BarberSubscriptionCubit, BarberSubscriptionState>(
                  builder: (context, state) {
                    final subscription = state.subscription;
                    if (subscription == null) return const SizedBox.shrink();
                    return SubscriptionHomeCard(
                      subscription: subscription,
                      onTap: () => context.push(Routes.barberSubscriptionScreen),
                    );
                  },
                ),
                SizedBox(height: 14.h),
                const HomeAlertCards(),
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TourTarget(
                        tourKey: tour.pending,
                        title: S().tourPendingTitle,
                        description: S().tourPendingBody,
                        child: HomePendingSection(
                          pending: state.pending,
                          onSeeAll: () => onGoToTab(1),
                        ),
                      ),
                      HomeQueueSection(
                        queue: state.queue,
                        onSeeAll: () => onGoToTab(1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
