import 'package:flutter/material.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/menu_section.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/merchant_member.dart';

class MerchantMemberActionsMenu extends StatelessWidget {
  final MerchantMember member;
  final VoidCallback onEdit;
  final VoidCallback onSetSalary;
  final VoidCallback onResetPassword;
  final VoidCallback onBlock;
  final VoidCallback onActivate;
  final VoidCallback onDelete;
  final VoidCallback? onOpenAttendance;

  const MerchantMemberActionsMenu({
    super.key,
    required this.member,
    required this.onEdit,
    required this.onSetSalary,
    required this.onResetPassword,
    required this.onBlock,
    required this.onActivate,
    required this.onDelete,
    this.onOpenAttendance,
  });

  Future<void> _confirm(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
    required VoidCallback onConfirmed,
    bool isDestructive = true,
  }) async {
    final confirmed = await showConfirmDialog(
      context,
      title: title,
      message: message,
      confirmLabel: title,
      icon: icon,
      isDestructive: isDestructive,
    );

    if (confirmed) onConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    return MenuSection(
      title: S().memberDetailTitle,
      children: [
        if (onOpenAttendance != null)
          MenuRow(
            icon: Icons.fingerprint_rounded,
            label: S().attendanceHistoryTitle,
            onTap: onOpenAttendance,
          ),
        MenuRow(
          icon: Icons.edit_outlined,
          label: S().editMemberTitle,
          onTap: onEdit,
        ),
        MenuRow(
          icon: Icons.payments_outlined,
          label: member.salary == null
              ? S().salarySetAction
              : S().salaryEditAction,
          onTap: onSetSalary,
        ),
        MenuRow(
          icon: Icons.lock_reset_rounded,
          label: S().resetMemberPasswordTitle,
          onTap: () => _confirm(
            context,
            title: S().resetMemberPasswordTitle,
            message: S().resetMemberPasswordDefaultNote,
            icon: Icons.lock_reset_rounded,
            isDestructive: false,
            onConfirmed: onResetPassword,
          ),
        ),
        if (member.active)
          MenuRow(
            icon: Icons.block_rounded,
            label: S().blockMemberTitle,
            danger: true,
            onTap: () => _confirm(
              context,
              title: S().blockMemberTitle,
              message: S().blockMemberConfirm,
              icon: Icons.block_rounded,
              onConfirmed: onBlock,
            ),
          )
        else
          MenuRow(
            icon: Icons.check_circle_outline_rounded,
            label: S().activateMemberTitle,
            onTap: () => _confirm(
              context,
              title: S().activateMemberTitle,
              message: S().activateMemberConfirm,
              icon: Icons.check_circle_outline_rounded,
              isDestructive: false,
              onConfirmed: onActivate,
            ),
          ),
        MenuRow(
          icon: Icons.delete_forever_rounded,
          label: S().deleteMemberTitle,
          danger: true,
          onTap: () => _confirm(
            context,
            title: S().deleteMemberTitle,
            message: S().deleteMemberConfirm,
            icon: Icons.delete_forever_rounded,
            onConfirmed: onDelete,
          ),
        ),
      ],
    );
  }
}
