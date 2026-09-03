import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DayTimeField extends StatelessWidget {
  final String label;
  final String time;
  final ValueChanged<String> onChanged;

  const DayTimeField({
    super.key,
    required this.label,
    required this.time,
    required this.onChanged,
  });

  TimeOfDay _parse() {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.elementAtOrNull(0) ?? '') ?? 10,
      minute: int.tryParse(parts.elementAtOrNull(1) ?? '') ?? 0,
    );
  }

  String _format(TimeOfDay value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await showTimePicker(context: context, initialTime: _parse());
    if (picked != null) onChanged(_format(picked));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return GestureDetector(
      onTap: () => _pick(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: scheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10.sp, color: scheme.onSurfaceVariant),
            ),
            SizedBox(height: 2.h),
            Text(
              time,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
