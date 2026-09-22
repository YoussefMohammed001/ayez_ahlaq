import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_drop_down_form_filed.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/money_frequency.dart';

class MoneyItemScheduleFields extends StatelessWidget {
  final MoneyFrequency frequency;
  final ValueChanged<MoneyFrequency> onFrequencyChanged;
  final int dayOfWeek;
  final ValueChanged<int> onDayOfWeekChanged;
  final int dayOfMonth;
  final ValueChanged<int> onDayOfMonthChanged;

  const MoneyItemScheduleFields({
    super.key,
    required this.frequency,
    required this.onFrequencyChanged,
    required this.dayOfWeek,
    required this.onDayOfWeekChanged,
    required this.dayOfMonth,
    required this.onDayOfMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().moneyFrequencyLabel),
        AppDropdownField<MoneyFrequency>(
          hintText: S().moneyFrequencyLabel,
          value: frequency,
          items: [
            DropdownMenuItem(value: MoneyFrequency.daily, child: Text(S().moneyFrequencyDaily)),
            DropdownMenuItem(value: MoneyFrequency.weekly, child: Text(S().moneyFrequencyWeekly)),
            DropdownMenuItem(value: MoneyFrequency.monthly, child: Text(S().moneyFrequencyMonthly)),
          ],
          onChanged: (value) => onFrequencyChanged(value ?? MoneyFrequency.daily),
        ),
        if (frequency == MoneyFrequency.weekly) ...[
          SectionTitle(title: S().moneyDayOfWeekLabel),
          AppDropdownField<int>(
            hintText: S().moneyDayOfWeekLabel,
            value: dayOfWeek,
            items: List.generate(
              7,
              (i) => DropdownMenuItem(value: i, child: Text(_weekdayName(i))),
            ),
            onChanged: (value) => onDayOfWeekChanged(value ?? 0),
          ),
        ],
        if (frequency == MoneyFrequency.monthly) ...[
          SectionTitle(title: S().moneyDayOfMonthLabel),
          AppDropdownField<int>(
            hintText: S().moneyDayOfMonthLabel,
            value: dayOfMonth,
            items: List.generate(
              28,
              (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}')),
            ),
            onChanged: (value) => onDayOfMonthChanged(value ?? 1),
          ),
        ],
      ],
    );
  }

  String _weekdayName(int index) => [
    S().weekdaySunday,
    S().weekdayMonday,
    S().weekdayTuesday,
    S().weekdayWednesday,
    S().weekdayThursday,
    S().weekdayFriday,
    S().weekdaySaturday,
  ][index];
}
