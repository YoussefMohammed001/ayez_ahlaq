import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/app_drop_down_form_filed.dart';
import '../../../../../generated/l10n.dart';
import '../../../services/domain/entities/barber_service.dart';

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
    final selected = services.any((s) => s.id == value) ? value : null;

    return AppDropdownField<int>(
      hintText: S().chooseService,
      value: selected,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => Validators.validateDropdown(v, S().chooseServiceRequired),
      items: [
        for (final service in services)
          DropdownMenuItem(
            value: service.id,
            child: Text(service.name, style: TextStyle(fontSize: 13.5.sp)),
          ),
      ],
    );
  }
}
