import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../domain/entities/attendance_shift.dart';
import '../manager/attendance_history_cubit.dart';
import '../manager/attendance_history_state.dart';
import '../widgets/attendance_shift_row.dart';
import '../widgets/correct_attendance_sheet.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  void _correct(BuildContext context, AttendanceShift shift) {
    final cubit = context.read<AttendanceHistoryCubit>();

    CorrectAttendanceSheet.show(
      context,
      shift: shift,
      onSubmit: (checkInAt, checkOutAt, note) async {
        final done = await cubit.correct(
          id: shift.id,
          checkInAt: checkInAt,
          checkOutAt: checkOutAt,
          note: note,
        );
        if (done) showSuccess(S().attendanceCorrectSaved);
        return done;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOwner =
        context.watch<BarberProfileCubit>().state.profile?.owner ?? false;

    return BusyErrorListener<AttendanceHistoryCubit, AttendanceHistoryState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().attendanceHistoryTitle),
        body: BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
          builder: (context, state) {
            final cubit = context.read<AttendanceHistoryCubit>();

            if (state.status == AttendanceHistoryStatus.loading ||
                state.status == AttendanceHistoryStatus.initial) {
              return const ListSkeleton();
            }

            if (state.status == AttendanceHistoryStatus.failure) {
              return AppErrorState(
                message: state.errorMessage,
                onRetry: cubit.load,
              );
            }

            if (state.shifts.isEmpty) {
              return AppEmptyState(
                icon: Icons.event_busy_rounded,
                title: S().attendanceHistoryEmpty,
                message: S().attendanceHistoryEmptyHint,
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.extentAfter < 200) cubit.loadMore();
                return false;
              },
              child: RefreshIndicator(
                onRefresh: cubit.load,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  itemCount:
                      state.shifts.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (_, index) => index == state.shifts.length
                      ? const Center(child: CircularProgressIndicator())
                      : AttendanceShiftRow(
                          shift: state.shifts[index],
                          onCorrect: isOwner
                              ? () => _correct(context, state.shifts[index])
                              : null,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
