import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class WalkInSlotTimeField extends StatelessWidget {
  final String? slotTime;
  final ValueChanged<String?> onChanged;

  const WalkInSlotTimeField({
    super.key,
    required this.slotTime,
    required this.onChanged,
  });

  TimeOfDay _parse(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.elementAtOrNull(0) ?? '') ?? TimeOfDay.now().hour,
      minute: int.tryParse(parts.elementAtOrNull(1) ?? '') ?? TimeOfDay.now().minute,
    );
  }

  String _format(TimeOfDay value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: slotTime != null ? _parse(slotTime!) : TimeOfDay.now(),
    );
    if (picked != null) onChanged(_format(picked));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final isSpecific = slotTime != null;

    return Row(
      children: [
        ChoiceChip(
          label: Text(S().walkInSlotTimeNow),
          selected: !isSpecific,
          onSelected: (_) => onChanged(null),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: GestureDetector(
            onTap: () => _pick(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSpecific ? scheme.primary : scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSpecific ? scheme.primary : scheme.outline,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16.r,
                    color: isSpecific ? scheme.surfaceContainerLowest : scheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    isSpecific ? slotTime! : S().walkInSlotTimeSpecific,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: isSpecific ? scheme.surfaceContainerLowest : scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
