import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/responsive/adaptive_body.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../attendance/presentation/manager/barber_attendance_cubit.dart';
import '../../../attendance/presentation/widgets/attendance_home_card.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../bookings/presentation/manager/bookings_state.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../../tour/presentation/widgets/barber_tour_targets.dart';
import '../widgets/barber_home_greeting.dart';
import '../widgets/home_pending_section.dart';
import '../widgets/home_queue_section.dart';

class TeamMemberHomeScreen extends StatelessWidget {
  final ValueChanged<int> onGoToTab;
  final BarberTourTargets tour;

  const TeamMemberHomeScreen({
    super.key,
    required this.onGoToTab,
    required this.tour,
  });

  Future<void> _refresh(BuildContext context) {
    return Future.wait([
      context.read<BarberProfileCubit>().loadProfile(),
      context.read<BookingsCubit>().loadPending(),
      context.read<BookingsCubit>().loadQueue(),
      context.read<BarberAttendanceCubit>().load(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BarberAttendanceCubit>()..load(),
      child: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: RefreshableStateView(
              onRefresh: () => _refresh(context),
              child: AdaptiveBody(
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
                          notificationsTourKey: tour.notifications,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      AttendanceHomeCard(tourKey: tour.attendance),
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
                            TourTarget(
                              tourKey: tour.queue,
                              title: S().tourQueueTitle,
                              description: S().tourQueueBody,
                              child: HomeQueueSection(
                                queue: state.queue,
                                onSeeAll: () => onGoToTab(1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
