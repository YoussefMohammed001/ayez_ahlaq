import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/attendance_team_cubit.dart';
import '../manager/attendance_team_state.dart';
import '../widgets/team_attendance_row.dart';

class AttendanceTeamScreen extends StatelessWidget {
  const AttendanceTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().attendanceTeamNowTitle),
      body: BlocBuilder<AttendanceTeamCubit, AttendanceTeamState>(
        builder: (context, state) {
          final cubit = context.read<AttendanceTeamCubit>();

          if (state.fetchedAt == null) {
            return state.status == AttendanceTeamStatus.failure
                ? AppErrorState(
                    message: state.errorMessage,
                    onRetry: cubit.load,
                  )
                : const ListSkeleton();
          }

          if (state.members.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.load,
              child: AppEmptyState(message: S().attendanceTeamEmpty),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.load,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.members.length,
              itemBuilder: (_, index) =>
                  TeamAttendanceRow(member: state.members[index]),
            ),
          );
        },
      ),
    );
  }
}
