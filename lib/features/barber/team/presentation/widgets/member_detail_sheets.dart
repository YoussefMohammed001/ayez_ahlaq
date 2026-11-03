import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/team_member_detail.dart';
import '../manager/team_member_detail_cubit.dart';
import 'edit_member_sheet.dart';
import 'reset_member_password_sheet.dart';

class MemberDetailSheets {
  const MemberDetailSheets._();

  static void edit(BuildContext context, TeamMemberDetail member) {
    final cubit = context.read<TeamMemberDetailCubit>();

    EditMemberSheet.show(
      context,
      member: member,
      onSubmit: (name, tagline) async {
        final saved = await cubit.updateMember(name, tagline);
        if (saved) showSuccess(S().memberSaved);
        return saved;
      },
    );
  }

  static void resetPassword(BuildContext context) {
    final cubit = context.read<TeamMemberDetailCubit>();

    ResetMemberPasswordSheet.show(
      context,
      onSubmit: (tempPassword) async {
        final done = await cubit.resetPassword(tempPassword);
        if (done) showSuccess(S().memberPasswordResetDone);
        return done;
      },
    );
  }
}
