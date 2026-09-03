import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
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
    final scheme = context.colorScheme;
    final selected = members.any((m) => m.id == value) ? value : null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: scheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          isExpanded: true,
          value: selected,
          hint: Text(
            S().chooseTeamMember,
            style: TextStyle(fontSize: 13.5.sp, color: Theme.of(context).hintColor),
          ),
          items: [
            for (final member in members)
              DropdownMenuItem<int?>(
                value: member.id,
                child: Text(
                  member.name,
                  style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
                ),
              ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
