import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../../barber/team/presentation/widgets/member_hours_section.dart';
import '../manager/merchant_member_detail_cubit.dart';
import '../manager/merchant_member_detail_state.dart';
import '../widgets/merchant_member_actions_menu.dart';
import '../widgets/merchant_member_info_card.dart';
import '../widgets/merchant_member_permissions_section.dart';
import '../widgets/merchant_member_sheets.dart';

class MerchantMemberDetailScreen extends StatelessWidget {
  const MerchantMemberDetailScreen({super.key});

  Future<void> _run(
    BuildContext context,
    Future<bool> Function() action,
    String message,
  ) async {
    final done = await action();
    if (context.mounted && done) showSuccess(message);
  }

  Future<void> _delete(BuildContext context) async {
    final deleted = await context
        .read<MerchantMemberDetailCubit>()
        .deleteMember();
    if (!context.mounted || !deleted) return;

    showSuccess(S().memberDeleted);
    context.pop();
  }

  Widget _buildContent(BuildContext context, MerchantMemberDetailState state) {
    final cubit = context.read<MerchantMemberDetailCubit>();
    final member = state.member;

    if (state.status == MerchantMemberDetailStatus.loading && member == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == MerchantMemberDetailStatus.failure && member == null) {
      return AppErrorState(message: state.errorMessage, onRetry: cubit.reload);
    }

    if (member == null) return const SizedBox.shrink();

    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
      children: [
        Center(
          child: AvatarCircle(
            initials: member.name.isEmpty ? '' : member.name.substring(0, 1),
            size: 72.r,
          ),
        ),
        SizedBox(height: 10.h),
        Center(child: AppText(member.name, style: font16w700)),
        SizedBox(height: 16.h),
        MerchantMemberInfoCard(member: member),
        MerchantMemberPermissionsSection(
          permissions: member.permissions,
          onChanged: cubit.setPermissions,
        ),
        MerchantMemberActionsMenu(
          member: member,
          onEdit: () => MerchantMemberSheets.edit(context, member),
          onSetSalary: () => MerchantMemberSheets.salary(context, member),
          onResetPassword: () =>
              _run(context, cubit.resetPassword, S().memberPasswordResetDone),
          onBlock: () => _run(context, cubit.blockMember, S().memberBlocked),
          onActivate: () =>
              _run(context, cubit.activateMember, S().memberActivated),
          onDelete: () => _delete(context),
        ),
        const MemberHoursSection(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<
      MerchantMemberDetailCubit,
      MerchantMemberDetailState
    >(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().memberDetailTitle),
        body: BlocBuilder<MerchantMemberDetailCubit, MerchantMemberDetailState>(
          builder: _buildContent,
        ),
      ),
    );
  }
}
