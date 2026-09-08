import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/app_drop_down_form_filed.dart';
import '../../../../../generated/l10n.dart';
import '../../../team/domain/entities/team_member.dart';

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
    final selected = members.any((m) => m.id == value) ? value : null;

    return AppDropdownField<int>(
      hintText: S().chooseTeamMember,
      value: selected,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => Validators.validateDropdown(v, S().chooseTeamMemberRequired),
      items: [
        for (final member in members)
          DropdownMenuItem(
            value: member.id,
            child: Text(member.name, style: TextStyle(fontSize: 13.5.sp)),
          ),
      ],
    );
  }
}
