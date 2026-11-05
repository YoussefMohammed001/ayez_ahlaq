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
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../manager/barber_team_cubit.dart';
import '../manager/barber_team_state.dart';
import '../widgets/add_team_member_sheet.dart';
import '../widgets/team_member_row.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  void _openAddMember(BuildContext context) {
    final cubit = context.read<BarberTeamCubit>();

    AddTeamMemberSheet.show(
      context,
      onSubmit: (name, phone, tagline, tempPassword, permissions) async {
        final result = await cubit.addMember(
          name: name,
          phoneNumber: phone,
          tagline: tagline,
          tempPassword: tempPassword,
          permissions: permissions,
        );

        if (result.member == null) {
          showError(cubit.state.errorMessage ?? S().somethingWentWrong);
        } else if (!result.permissionsSaved) {
          showWarning(S().memberAddedPermissionsFailed);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOwner = context.watch<BarberProfileCubit>().state.profile?.owner ?? false;

    return BusyErrorListener<BarberTeamCubit, BarberTeamState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().teamTitle,
          trailing: isOwner
              ? Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.person_add_alt_1_rounded),
                    onPressed: () => _openAddMember(context),
                  ),
                )
              : null,
        ),
        body: BlocBuilder<BarberTeamCubit, BarberTeamState>(
          builder: (context, state) {
            final cubit = context.read<BarberTeamCubit>();

            if (state.status == BarberTeamStatus.loading && state.members.isEmpty) {
              return const ListSkeleton();
            }

            if (state.status == BarberTeamStatus.failure && state.members.isEmpty) {
              return AppErrorState(
                message: state.errorMessage,
                onRetry: cubit.loadTeam,
              );
            }

            final members = state.members.where((m) => !m.owner).toList();

            if (members.isEmpty) {
              return RefreshableStateView(
                onRefresh: cubit.loadTeam,
                child: AppEmptyState(
                  icon: Icons.groups_2_outlined,
                  title: S().noTeamMembersTitle,
                  message: isOwner
                      ? S().noTeamMembersOwnerHint
                      : S().noTeamMembersYet,
                  actionLabel: isOwner ? S().addMemberTitle : null,
                  onAction: isOwner ? () => _openAddMember(context) : null,
                ),
              );
            }

            return RefreshableStateView(
              onRefresh: cubit.loadTeam,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: members.length,
                itemBuilder: (_, index) {
                  final member = members[index];
                  return TeamMemberRow(
                    member: member,
                    onTap: isOwner
                        ? () => context.push(
                            Routes.barberTeamMemberDetailScreen,
                            extra: member.id,
                          )
                        : null,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
