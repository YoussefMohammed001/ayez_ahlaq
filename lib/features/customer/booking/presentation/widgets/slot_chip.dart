import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/app_date_time.dart';

class SlotChip extends StatelessWidget {
  final String time;
  final bool selected;
  final VoidCallback onTap;

  const SlotChip({
    super.key,
    required this.time,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: selected ? scheme.primary : scheme.outline),
        ),
        child: Text(
          AppDateTime.formatHour(time),
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: selected ? scheme.surfaceContainerLowest : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
