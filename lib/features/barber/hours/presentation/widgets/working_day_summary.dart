import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/working_day.dart';
import 'day_period_label.dart';

class WorkingDaySummary extends StatelessWidget {
  final WorkingDay day;

  const WorkingDaySummary({super.key, required this.day});

  String _spoken(String time) =>
      '${AppDateTime.formatHour(time)} ${DayPeriodLabel.of(time)}';

  String _duration() {
    final hours = day.durationMinutes ~/ Duration.minutesPerHour;
    final minutes = day.durationMinutes % Duration.minutesPerHour;
    if (minutes == 0) return S().hoursDuration(hours);
    return S().hoursDurationWithMinutes(hours, minutes);
  }

  String _text() {
    final open = _spoken(day.openTime);
    final close = _spoken(day.closeTime);
    final summary = day.closesNextDay
        ? S().hoursSummaryNextDay(open, close)
        : S().hoursSummary(open, close);
    return '$summary • ${_duration()}';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final hasError = day.hasSameOpenAndClose;

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        hasError ? S().hoursSameTimeError : _text(),
        style: TextStyle(
          fontSize: 11.5.sp,
          color: hasError ? scheme.error : scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
