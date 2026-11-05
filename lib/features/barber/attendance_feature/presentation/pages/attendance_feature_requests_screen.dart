import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../manager/attendance_feature_requests_cubit.dart';
import '../manager/attendance_feature_requests_state.dart';
import '../widgets/attendance_feature_request_row.dart';

class AttendanceFeatureRequestsScreen extends StatelessWidget {
  const AttendanceFeatureRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().attendanceFeatureRequestsTitle),
      body:
          BlocBuilder<
            AttendanceFeatureRequestsCubit,
            AttendanceFeatureRequestsState
          >(
            builder: (context, state) {
              final cubit = context.read<AttendanceFeatureRequestsCubit>();

              if (state.status == AttendanceFeatureRequestsStatus.initial ||
                  state.status == AttendanceFeatureRequestsStatus.loading) {
                return const ListSkeleton();
              }

              if (state.status == AttendanceFeatureRequestsStatus.failure) {
                return AppErrorState(
                  message: state.errorMessage,
                  onRetry: cubit.load,
                );
              }

              if (state.requests.isEmpty) {
                return AppEmptyState(
                  icon: Icons.inbox_outlined,
                  title: S().attendanceFeatureRequestsEmpty,
                  message: S().attendanceFeatureRequestsEmptyHint,
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
                        state.requests.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (_, index) => index == state.requests.length
                        ? const Center(child: CircularProgressIndicator())
                        : AttendanceFeatureRequestRow(
                            request: state.requests[index],
                          ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
