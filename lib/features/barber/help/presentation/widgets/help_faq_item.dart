import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import 'help_entry.dart';

class HelpFaqItem extends StatelessWidget {
  final HelpEntry entry;

  const HelpFaqItem({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
        childrenPadding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 12.h),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          entry.question,
          style: TextStyle(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        children: [
          Text(
            entry.answer,
            style: TextStyle(
              fontSize: 12.5.sp,
              height: 1.7,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
