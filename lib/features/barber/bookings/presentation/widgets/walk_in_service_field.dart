import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
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
    final scheme = context.colorScheme;
    final selected = services.any((s) => s.id == value) ? value : null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: scheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: selected,
          hint: Text(
            S().chooseService,
            style: TextStyle(fontSize: 13.5.sp, color: Theme.of(context).hintColor),
          ),
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
          onChanged: onChanged,
        ),
      ),
    );
  }
}
