import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/app_date_field.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/time_picker_button.dart';

class HomeServiceDateTimeRow extends StatelessWidget {
  final DateTime? date;
  final TimeOfDay? time;
  final ValueChanged<DateTime> onDatePicked;
  final ValueChanged<TimeOfDay> onTimePicked;

  const HomeServiceDateTimeRow({
    super.key,
    required this.date,
    required this.time,
    required this.onDatePicked,
    required this.onTimePicked,
  });

  static String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final selected = date;
    final initialDate = selected == null || selected.isBefore(firstDate)
        ? firstDate
        : selected;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: firstDate.add(const Duration(days: 60)),
    );
    if (picked != null) onDatePicked(picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
    );
    if (picked != null) onTimePicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppDateField(
            label: S().homeServiceDateLabel,
            value: date == null
                ? ''
                : DateFormat('yyyy-MM-dd', 'en').format(date!),
            hint: S().homeServiceDateLabel,
            cs: context.colorScheme,
            onTap: () => _pickDate(context),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: TimePickerButton(
            label: S().homeServiceTimeLabel,
            time: time == null ? '--:--' : formatTime(time!),
            cs: context.colorScheme,
            onTap: () => _pickTime(context),
          ),
        ),
      ],
    );
  }
}
