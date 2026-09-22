import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/walk_in_option_barber.dart';
import 'walk_in_dropdown_field.dart';

class WalkInBarberField extends StatelessWidget {
  final List<WalkInOptionBarber> barbers;
  final int? value;
  final ValueChanged<int?> onChanged;

  const WalkInBarberField({
    super.key,
    required this.barbers,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final selected = barbers.any((b) => b.barberId == value) ? value : null;

    return WalkInDropdownField<int>(
      value: selected,
      hint: S().chooseTeamMember,
      onChanged: onChanged,
      validator: (v) => Validators.validateDropdown(v, S().chooseTeamMemberRequired),
      items: [
        for (final barber in barbers)
          DropdownMenuItem(
            value: barber.barberId,
            child: Text(
              barber.barberName,
              style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
            ),
          ),
      ],
    );
  }
}
