import '../../../../../generated/l10n.dart';
import 'help_entry.dart';

class BarberHelpEntries {
  const BarberHelpEntries._();

  static List<HelpEntry> of({required bool isTeamMember}) => isTeamMember
      ? [
          HelpEntry(S().helpMemberQ1, S().helpMemberA1),
          HelpEntry(S().helpMemberQ2, S().helpMemberA2),
          HelpEntry(S().helpMemberQ3, S().helpMemberA3),
        ]
      : [
          HelpEntry(S().helpOwnerQ1, S().helpOwnerA1),
          HelpEntry(S().helpOwnerQ2, S().helpOwnerA2),
          HelpEntry(S().helpOwnerQ3, S().helpOwnerA3),
          HelpEntry(S().helpOwnerQ4, S().helpOwnerA4),
        ];
}
