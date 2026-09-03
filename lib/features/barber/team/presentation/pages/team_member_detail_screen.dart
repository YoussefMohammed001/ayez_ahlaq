import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_member_detail.dart';
import '../manager/team_member_detail_cubit.dart';
import '../manager/team_member_detail_state.dart';
import '../widgets/edit_member_sheet.dart';
import '../widgets/member_actions_menu.dart';
import '../widgets/member_hours_section.dart';
import '../widgets/member_info_card.dart';
import '../widgets/member_services_section.dart';
import '../widgets/reset_password_sheet.dart';

class TeamMemberDetailScreen extends StatelessWidget {
  const TeamMemberDetailScreen({super.key});

  void _openEdit(BuildContext context, TeamMemberDetail member) {
    final cubit = context.read<TeamMemberDetailCubit>();

    EditMemberSheet.show(
      context,
      member: member,
      isSubmitting: cubit.state.isSubmitting,
      onSubmit: (name, tagline) async {
        final saved = await cubit.updateMember(name, tagline);
        if (saved) showSuccess(S().memberSaved);
        return saved;
      },
    );
  }

  void _openResetPassword(BuildContext context) {
    final cubit = context.read<TeamMemberDetailCubit>();

    ResetPasswordSheet.show(
      context,
      isSubmitting: cubit.state.isSubmitting,
      onSubmit: (tempPassword) async {
        final saved = await cubit.resetPassword(tempPassword);
        if (saved) showSuccess(S().passwordResetSuccess);
        return saved;
      },
    );
  }

  Future<void> _block(BuildContext context) async {
    await context.read<TeamMemberDetailCubit>().blockMember();
    if (context.mounted) showSuccess(S().memberBlocked);
  }

  Future<void> _activate(BuildContext context) async {
    await context.read<TeamMemberDetailCubit>().activateMember();
    if (context.mounted) showSuccess(S().memberActivated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().memberDetailTitle),
      body: BlocBuilder<TeamMemberDetailCubit, TeamMemberDetailState>(
        builder: (context, state) {
          final cubit = context.read<TeamMemberDetailCubit>();
          final member = state.member;

          if (state.status == TeamMemberDetailStatus.loading && member == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TeamMemberDetailStatus.failure && member == null) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => cubit.loadMember(state.member?.id ?? 0),
            );
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
              Center(
                child: Text(
                  member.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              MemberInfoCard(
                member: member,
                onAvailabilityChanged: cubit.setAvailability,
              ),
              MemberActionsMenu(
                member: member,
                onEdit: () => _openEdit(context, member),
                onResetPassword: () => _openResetPassword(context),
                onBlock: () => _block(context),
                onActivate: () => _activate(context),
              ),
              const MemberHoursSection(),
              const MemberServicesSection(),
            ],
          );
        },
      ),
    );
  }
}
