import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../../barber/attendance/presentation/widgets/attendance_range_note.dart';
import '../../../../barber/attendance/presentation/widgets/attendance_status_card.dart';
import '../manager/member_attendance_cubit.dart';
import '../manager/member_attendance_state.dart';

class MemberAttendanceScreen extends StatelessWidget {
  const MemberAttendanceScreen({super.key});

  Future<void> _toggle(BuildContext context) async {
    final cubit = context.read<MemberAttendanceCubit>();
    final wasOnShift = cubit.state.current.onShift;
    final done = wasOnShift ? await cubit.checkOut() : await cubit.checkIn();

    if (!context.mounted || !done) return;

    showSuccess(
      wasOnShift ? S().attendanceCheckedOut : S().attendanceCheckedIn,
    );
  }

  Widget _buildHeader(BuildContext context, MemberAttendanceState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S().attendanceTitle, style: HeadingStyles.h2),
          if (!state.isDisabled)
            IconButton(
              icon: const Icon(Icons.history_rounded),
              tooltip: S().attendanceHistoryTitle,
              onPressed: () =>
                  context.push(Routes.memberAttendanceHistoryScreen),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MemberAttendanceState state) {
    final cubit = context.read<MemberAttendanceCubit>();

    if (!state.hasLoaded) {
      return state.status == MemberAttendanceStatus.failure
          ? AppErrorState(message: state.errorMessage, onRetry: cubit.load)
          : const Center(child: CircularProgressIndicator());
    }

    if (state.isDisabled) {
      return RefreshableStateView(
        onRefresh: cubit.load,
        child: AppEmptyState(
          icon: Icons.lock_clock_outlined,
          title: S().memberAttendanceDisabledTitle,
          message: S().memberAttendanceDisabledHint,
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MemberAttendanceCubit, MemberAttendanceState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<MemberAttendanceCubit, MemberAttendanceState>(
                buildWhen: (previous, current) =>
                    previous.isDisabled != current.isDisabled,
                builder: _buildHeader,
              ),
              Expanded(
                child:
                    BlocBuilder<MemberAttendanceCubit, MemberAttendanceState>(
                      builder: _buildBody,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
