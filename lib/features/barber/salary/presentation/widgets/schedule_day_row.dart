import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../hours/domain/entities/working_day.dart';
import '../../../hours/presentation/widgets/day_name.dart';

class ScheduleDayRow extends StatelessWidget {
  final WorkingDay day;
  final bool isToday;

  const ScheduleDayRow({super.key, required this.day, required this.isToday});

  static String _clock(String time) =>
      time.length >= 5 ? time.substring(0, 5) : time;

  String get _value => day.isOpen
      ? S().scheduleTimeRange(_clock(day.openTime), _clock(day.closeTime))
      : S().scheduleDayOff;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final style = isToday ? font13w700 : font13w400;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: scheme.outline)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              DayName.byDayOfWeek[day.dayOfWeek % 7].label(),
              style: style,
            ),
          ),
          Text(
            _value,
            style: style.copyWith(
              color: day.isOpen ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
