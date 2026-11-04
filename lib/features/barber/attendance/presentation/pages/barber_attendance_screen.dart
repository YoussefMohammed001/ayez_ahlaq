import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../manager/barber_attendance_cubit.dart';
import '../manager/barber_attendance_state.dart';
import '../../../attendance_feature/presentation/widgets/attendance_feature_active_banner.dart';
import '../../../attendance_feature/presentation/widgets/attendance_feature_locked_view.dart';
import '../widgets/attendance_range_note.dart';
import '../widgets/attendance_status_card.dart';
import '../widgets/owner_attendance_links.dart';

class BarberAttendanceScreen extends StatelessWidget {
  const BarberAttendanceScreen({super.key});

  Future<void> _toggle(BuildContext context) async {
    final cubit = context.read<BarberAttendanceCubit>();
    final wasOnShift = cubit.state.current.onShift;
    final done = wasOnShift ? await cubit.checkOut() : await cubit.checkIn();

    if (!context.mounted || !done) return;

    showSuccess(
      wasOnShift ? S().attendanceCheckedOut : S().attendanceCheckedIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberAttendanceCubit, BarberAttendanceState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().attendanceTitle,
          trailing: BlocBuilder<BarberAttendanceCubit, BarberAttendanceState>(
            builder: (context, state) => state.isLocked
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.history_rounded),
                    tooltip: S().attendanceHistoryTitle,
                    onPressed: () =>
                        context.push(Routes.barberAttendanceHistoryScreen),
                  ),
          ),
        ),
        body: BlocBuilder<BarberAttendanceCubit, BarberAttendanceState>(
          builder: (context, state) {
            final cubit = context.read<BarberAttendanceCubit>();
            final isOwner =
                context.watch<BarberProfileCubit>().state.profile?.owner ??
                false;

            if (!state.hasLoaded) {
              return state.status == BarberAttendanceStatus.failure
                  ? AppErrorState(
                      message: state.errorMessage,
                      onRetry: cubit.load,
                    )
                  : const Center(child: CircularProgressIndicator());
            }

            if (state.isLocked) {
              return RefreshableStateView(
                onRefresh: cubit.load,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                  child: AttendanceFeatureLockedView(
                    feature: state.feature,
                    onChanged: cubit.load,
                  ),
                ),
              );
            }

            return RefreshableStateView(
              onRefresh: cubit.load,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AttendanceFeatureActiveBanner(feature: state.feature),
                    AttendanceStatusCard(
                      current: state.current,
                      fetchedAt: state.fetchedAt!,
                    ),
                    SizedBox(height: 14.h),
                    AttendanceRangeNote(config: state.current.config),
                    SizedBox(height: 20.h),
                    PrimaryCtaButton(
                      label: state.current.onShift
                          ? S().attendanceCheckOut
                          : S().attendanceCheckIn,
                      isLoading: state.isSubmitting,
                      onPressed: () => _toggle(context),
                    ),
                    if (isOwner) ...[
                      SizedBox(height: 24.h),
                      const OwnerAttendanceLinks(),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
