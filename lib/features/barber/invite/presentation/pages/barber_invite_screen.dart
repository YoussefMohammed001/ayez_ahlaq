import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_invite_cubit.dart';
import '../manager/barber_invite_state.dart';
import '../widgets/invite_link_card.dart';

class BarberInviteScreen extends StatelessWidget {
  const BarberInviteScreen({super.key});

  Future<void> _regenerate(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().regenerateInviteTitle,
      message: S().regenerateInviteConfirm,
      confirmLabel: S().regenerateInviteTitle,
      icon: Icons.refresh_rounded,
    );

    if (!confirmed || !context.mounted) return;

    final cubit = context.read<BarberInviteCubit>();
    final regenerated = await cubit.regenerate();

    if (!context.mounted) return;

    if (regenerated) {
      showSuccess(S().inviteRegenerated);
    } else {
      showError(cubit.state.errorMessage ?? S().somethingWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().inviteTitle),
      body: BlocBuilder<BarberInviteCubit, BarberInviteState>(
        builder: (context, state) {
          final invite = state.invite;

          if (state.status == BarberInviteStatus.loading && invite == null) {
            return const ListSkeleton();
          }

          if (state.status == BarberInviteStatus.failure && invite == null) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<BarberInviteCubit>().loadInvite,
            );
          }

          if (invite == null) return const SizedBox.shrink();

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              Text(
                S().inviteNote,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  height: 1.8,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              InviteLinkCard(url: invite.url),
              SizedBox(height: 4.h),
              SectionTitle(title: S().inviteFavoritesLabel),
              Text(
                '${invite.favoriteCount}',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 26.h),
              PrimaryCtaButton(
                label: S().regenerateInviteTitle,
                isLoading: state.isRegenerating,
                onPressed: () => _regenerate(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
