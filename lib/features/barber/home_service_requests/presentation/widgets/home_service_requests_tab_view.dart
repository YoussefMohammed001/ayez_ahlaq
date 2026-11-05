import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_requests_cubit.dart';
import '../manager/home_service_requests_state.dart';
import 'home_service_request_row.dart';

class HomeServiceRequestsTabView extends StatelessWidget {
  const HomeServiceRequestsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeServiceRequestsCubit, HomeServiceRequestsState>(
      builder: (context, state) {
        final cubit = context.read<HomeServiceRequestsCubit>();

        if (state.status == HomeServiceRequestsStatus.loading &&
            state.requests.isEmpty) {
          return const ListSkeleton();
        }

        if (state.status == HomeServiceRequestsStatus.failure &&
            state.requests.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadPending,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadPending,
            ),
          );
        }

        if (state.requests.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadPending,
            child: AppEmptyState(
              icon: Icons.home_repair_service_outlined,
              title: S().noPendingHomeServiceRequests,
              message: S().noHomeServiceRequestsHint,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.loadPending,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: state.requests.length,
            itemBuilder: (_, index) {
              final request = state.requests[index];
              return HomeServiceRequestRow(
                request: request,
                onTap: () => context.push(
                  Routes.barberHomeServiceRequestDetailScreen,
                  extra: request.id,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
