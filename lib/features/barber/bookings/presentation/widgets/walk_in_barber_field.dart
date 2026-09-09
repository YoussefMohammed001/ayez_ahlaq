import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../generated/l10n.dart';
import '../../../team/domain/entities/team_member.dart';
import 'walk_in_dropdown_field.dart';

class WalkInBarberField extends StatelessWidget {
  final List<TeamMember> members;
  final int? value;
  final ValueChanged<int?> onChanged;

  const WalkInBarberField({
    super.key,
    required this.members,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final selected = members.any((m) => m.id == value) ? value : null;

    return WalkInDropdownField<int>(
      value: selected,
      hint: S().chooseTeamMember,
      onChanged: onChanged,
      validator: (v) => Validators.validateDropdown(v, S().chooseTeamMemberRequired),
      items: [
        for (final member in members)
          DropdownMenuItem(
            value: member.id,
            child: Text(
              member.name,
              style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
            ),
          ),
      ],
    );
  }
}
