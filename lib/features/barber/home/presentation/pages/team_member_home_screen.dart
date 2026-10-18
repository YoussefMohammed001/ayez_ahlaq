import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../bookings/presentation/manager/bookings_state.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../widgets/barber_home_greeting.dart';
import '../widgets/home_pending_section.dart';
import '../widgets/home_queue_section.dart';

class TeamMemberHomeScreen extends StatelessWidget {
  final ValueChanged<int> onGoToTab;

  const TeamMemberHomeScreen({super.key, required this.onGoToTab});

  Future<void> _refresh(BuildContext context) {
    return Future.wait([
      context.read<BarberProfileCubit>().loadProfile(),
      context.read<BookingsCubit>().loadPending(),
      context.read<BookingsCubit>().loadQueue(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshableStateView(
          onRefresh: () => _refresh(context),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<BarberProfileCubit, BarberProfileState>(
                  builder: (context, state) => BarberHomeGreeting(
                    shopName: state.profile?.shopName ?? '',
                    onAvatarTap: () => onGoToTab(2),
                    onNotificationsTap: () =>
                        context.push(Routes.barberNotificationsScreen),
                  ),
                ),
                SizedBox(height: 18.h),
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePendingSection(
                        pending: state.pending,
                        onSeeAll: () => onGoToTab(1),
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
