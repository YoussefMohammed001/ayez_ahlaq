import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../manager/merchant_team_cubit.dart';
import '../manager/merchant_team_state.dart';
import '../widgets/add_merchant_member_sheet.dart';
import '../widgets/merchant_member_row.dart';
import '../widgets/merchant_team_quota_banner.dart';

class MerchantTeamScreen extends StatelessWidget {
  const MerchantTeamScreen({super.key});

  bool _limitReached(BuildContext context) {
    final quota = context
        .read<MerchantSubscriptionCubit>()
        .state
        .subscription
        ?.employees;
    return quota?.remaining == 0;
  }

  void _openAddMember(BuildContext context) {
    if (_limitReached(context)) {
      showError(S().teamLimitReached);
      return;
    }

    final cubit = context.read<MerchantTeamCubit>();

    AddMerchantMemberSheet.show(
      context,
      onSubmit:
          ({
            required name,
            required phone,
            password,
            salary,
            required permissions,
          }) async {
            final added = await cubit.addMember(
              name: name,
              phoneNumber: phone,
              password: password,
              salary: salary,
              permissions: permissions,
            );
            if (added) showSuccess(S().memberAdded);
          },
    );
  }

  Future<void> _openMember(BuildContext context, int id) async {
    final cubit = context.read<MerchantTeamCubit>();

    await context.push(Routes.merchantTeamMemberScreen, extra: id);
    cubit.refresh();
  }

  Widget _buildBody(BuildContext context, MerchantTeamState state) {
    final cubit = context.read<MerchantTeamCubit>();

    if (state.status == MerchantTeamStatus.initial ||
        (state.status == MerchantTeamStatus.loading && state.members.isEmpty)) {
      return const ListSkeleton();
    }

    if (state.status == MerchantTeamStatus.failure && state.members.isEmpty) {
      return AppErrorState(message: state.errorMessage, onRetry: cubit.load);
    }

    if (state.members.isEmpty) {
      return RefreshIndicator(
        onRefresh: cubit.refresh,
        child: AppEmptyState(
          icon: Icons.groups_2_outlined,
          title: S().noTeamMembersTitle,
          message: S().noTeamMembersOwnerHint,
          actionLabel: S().addMemberTitle,
          onAction: () => _openAddMember(context),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 200) cubit.loadMore();
        return false;
      },
      child: RefreshIndicator(
        onRefresh: cubit.refresh,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          itemCount: state.members.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (_, index) => index == state.members.length
              ? const Center(child: CircularProgressIndicator())
              : MerchantMemberRow(
                  member: state.members[index],
                  onTap: () => _openMember(context, state.members[index].id),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MerchantTeamCubit, MerchantTeamState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().teamTitle,
          trailing: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.person_add_alt_1_rounded),
              onPressed: () => _openAddMember(context),
            ),
          ),
        ),
        body: Column(
          children: [
            const MerchantTeamQuotaBanner(),
            Expanded(
              child: BlocBuilder<MerchantTeamCubit, MerchantTeamState>(
                builder: _buildBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
