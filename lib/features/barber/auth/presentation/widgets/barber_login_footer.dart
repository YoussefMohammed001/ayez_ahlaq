import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/auth_footer_prompt.dart';
import 'team_member_account_hint.dart';

class BarberLoginFooter extends StatelessWidget {
  final bool isTeamMember;
  final VoidCallback onForgotPassword;
  final VoidCallback onRegister;

  const BarberLoginFooter({
    super.key,
    required this.isTeamMember,
    required this.onForgotPassword,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthFooterPrompt(label: S().forgotPassword, onTap: onForgotPassword),
        if (isTeamMember)
          const TeamMemberAccountHint()
        else
          AuthFooterPrompt(label: S().noAccountRegisterBarber, onTap: onRegister),
      ],
    );
  }
}
