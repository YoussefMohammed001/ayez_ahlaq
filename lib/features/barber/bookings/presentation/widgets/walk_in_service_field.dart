import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../generated/l10n.dart';
import '../../../services/domain/entities/barber_service.dart';
import 'walk_in_dropdown_field.dart';

class WalkInServiceField extends StatelessWidget {
  final List<BarberService> services;
  final int? value;
  final ValueChanged<int?> onChanged;

  const WalkInServiceField({
    super.key,
    required this.services,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final selected = services.any((s) => s.id == value) ? value : null;

    return WalkInDropdownField<int>(
      value: selected,
      hint: S().chooseService,
      onChanged: onChanged,
      validator: (v) => Validators.validateDropdown(v, S().chooseServiceRequired),
      items: [
        for (final service in services)
          DropdownMenuItem(
            value: service.id,
            child: Text(
              service.name,
              style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
            ),
          ),
      ],
    );
  }
}
