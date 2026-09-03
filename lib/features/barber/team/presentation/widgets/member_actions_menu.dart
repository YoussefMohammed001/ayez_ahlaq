import 'package:flutter/material.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_member_detail.dart';

class MemberActionsMenu extends StatelessWidget {
  final TeamMemberDetail member;
  final VoidCallback onEdit;
  final VoidCallback onResetPassword;
  final VoidCallback onBlock;
  final VoidCallback onActivate;

  const MemberActionsMenu({
    super.key,
    required this.member,
    required this.onEdit,
    required this.onResetPassword,
    required this.onBlock,
    required this.onActivate,
  });

  Future<void> _confirmBlock(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().blockMemberTitle,
      message: S().blockMemberConfirm,
      confirmLabel: S().blockMemberTitle,
      icon: Icons.block_rounded,
    );

    if (confirmed) onBlock();
  }

  Future<void> _confirmActivate(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().activateMemberTitle,
      message: S().activateMemberConfirm,
      confirmLabel: S().activateMemberTitle,
      icon: Icons.check_circle_outline_rounded,
      isDestructive: false,
    );

    if (confirmed) onActivate();
  }

  @override
  Widget build(BuildContext context) {
    return MenuSection(
      title: S().memberDetailTitle,
      children: [
        MenuRow(
          icon: Icons.edit_outlined,
          label: S().editMemberTitle,
          onTap: onEdit,
        ),
        MenuRow(
          icon: Icons.password_rounded,
          label: S().resetPasswordTitle,
          onTap: onResetPassword,
        ),
        if (member.active)
          MenuRow(
            icon: Icons.block_rounded,
            label: S().blockMemberTitle,
            danger: true,
            onTap: () => _confirmBlock(context),
          )
        else
          MenuRow(
            icon: Icons.check_circle_outline_rounded,
            label: S().activateMemberTitle,
            onTap: () => _confirmActivate(context),
          ),
      ],
    );
  }
}
