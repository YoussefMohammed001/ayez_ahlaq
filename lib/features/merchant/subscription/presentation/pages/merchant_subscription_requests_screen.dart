import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_subscription_requests_cubit.dart';
import '../manager/merchant_subscription_requests_state.dart';
import '../widgets/subscription_request_row.dart';

class MerchantSubscriptionRequestsScreen extends StatelessWidget {
  const MerchantSubscriptionRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().subscriptionRequestsTitle),
      body: BlocBuilder<MerchantSubscriptionRequestsCubit, MerchantSubscriptionRequestsState>(
        builder: (context, state) {
          final cubit = context.read<MerchantSubscriptionRequestsCubit>();

          if (state.status == MerchantSubscriptionRequestsStatus.loading &&
              state.requests.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == MerchantSubscriptionRequestsStatus.failure &&
              state.requests.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadRequests,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadRequests),
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
