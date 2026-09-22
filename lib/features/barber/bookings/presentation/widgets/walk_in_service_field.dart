import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/walk_in_option.dart';
import 'walk_in_dropdown_field.dart';

class WalkInServiceField extends StatelessWidget {
  final List<WalkInOption> options;
  final int? value;
  final ValueChanged<int?> onChanged;

  const WalkInServiceField({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final selected =
        options.any((o) => o.serviceTypeId == value) ? value : null;

    return WalkInDropdownField<int>(
      value: selected,
      hint: S().chooseService,
      onChanged: onChanged,
      validator: (v) => Validators.validateDropdown(v, S().chooseServiceRequired),
      items: [
        for (final option in options)
          DropdownMenuItem(
            value: option.serviceTypeId,
            child: Text(
              option.name,
              style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
            ),
          ),
      ],
    );
  }
}
