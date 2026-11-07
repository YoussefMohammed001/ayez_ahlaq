import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../profile_setup/presentation/widgets/profile_setup_card.dart';
import '../../../subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../../subscription/presentation/manager/barber_subscription_state.dart';
import '../../../subscription/presentation/widgets/subscription_home_card.dart';
import '../../../tour/presentation/widgets/barber_tour_targets.dart';
import 'home_alert_cards.dart';
import 'home_summary_section.dart';

class HomeLeadingSection extends StatelessWidget {
  final ValueChanged<int> onGoToTab;
  final BarberTourTargets tour;
  final VoidCallback onStartTour;

  const HomeLeadingSection({
    super.key,
    required this.onGoToTab,
    required this.tour,
    required this.onStartTour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileSetupCard(onStartTour: onStartTour, tourKey: tour.checklist),
        HomeSummarySection(onGoToTab: onGoToTab, tourKey: tour.summary),
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
      ],
    );
  }
}
