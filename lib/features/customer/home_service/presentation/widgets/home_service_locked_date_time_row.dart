import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import 'home_service_date_time_row.dart';

class HomeServiceLockedDateTimeRow extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;

  const HomeServiceLockedDateTimeRow({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(
            Icons.event_available_rounded,
            size: 20.r,
            color: context.semantic.accentStrong,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              '${DateFormat('yyyy-MM-dd', 'en').format(date)} • ${HomeServiceDateTimeRow.formatTime(time)}',
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
