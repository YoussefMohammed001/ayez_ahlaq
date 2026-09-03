import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/working_day.dart';
import 'day_time_field.dart';

class WorkingDayRow extends StatelessWidget {
  final WorkingDay day;
  final ValueChanged<bool> onToggle;
  final ValueChanged<String> onOpenTimeChanged;
  final ValueChanged<String> onCloseTimeChanged;

  const WorkingDayRow({
    super.key,
    required this.day,
    required this.onToggle,
    required this.onOpenTimeChanged,
    required this.onCloseTimeChanged,
  });

  static const _dayNames = [
    _DayName.monday,
    _DayName.tuesday,
    _DayName.wednesday,
    _DayName.thursday,
    _DayName.friday,
    _DayName.saturday,
    _DayName.sunday,
  ];

  String _label() => _dayNames[day.dayOfWeek % 7].label();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _label(),
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
              ToggleSwitch(value: day.isOpen, onTap: () => onToggle(!day.isOpen)),
            ],
          ),
          if (day.isOpen) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: DayTimeField(
                    label: S().openTimeLabel,
                    time: day.openTime,
                    onChanged: onOpenTimeChanged,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: DayTimeField(
                    label: S().closeTimeLabel,
                    time: day.closeTime,
                    onChanged: onCloseTimeChanged,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

enum _DayName {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String label() => switch (this) {
    _DayName.monday => S().dayMonday,
    _DayName.tuesday => S().dayTuesday,
    _DayName.wednesday => S().dayWednesday,
    _DayName.thursday => S().dayThursday,
    _DayName.friday => S().dayFriday,
    _DayName.saturday => S().daySaturday,
    _DayName.sunday => S().daySunday,
  };
}
