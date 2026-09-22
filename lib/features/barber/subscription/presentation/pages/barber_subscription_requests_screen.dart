import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_subscription_requests_cubit.dart';
import '../manager/barber_subscription_requests_state.dart';
import '../widgets/subscription_request_row.dart';

class BarberSubscriptionRequestsScreen extends StatelessWidget {
  const BarberSubscriptionRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().subscriptionRequestsTitle),
      body:
          BlocBuilder<
            BarberSubscriptionRequestsCubit,
            BarberSubscriptionRequestsState
          >(
            builder: (context, state) {
              final cubit = context.read<BarberSubscriptionRequestsCubit>();

              if (state.status == BarberSubscriptionRequestsStatus.loading &&
                  state.requests.isEmpty) {
                return const ListSkeleton();
              }

              if (state.status == BarberSubscriptionRequestsStatus.failure &&
                  state.requests.isEmpty) {
                return RefreshableStateView(
                  onRefresh: cubit.loadRequests,
                  child: AppErrorState(
                    message: state.errorMessage,
                    onRetry: cubit.loadRequests,
                  ),
                );
              }

              if (state.requests.isEmpty) {
                return RefreshableStateView(
                  onRefresh: cubit.loadRequests,
                  child: AppEmptyState(
                    icon: Icons.history_rounded,
                    title: S().noSubscriptionRequests,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: cubit.loadRequests,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  children: [
                    for (final request in state.requests)
                      SubscriptionRequestRow(request: request),
                  ],
                ),
              );
            },
          ),
    );
  }
}
