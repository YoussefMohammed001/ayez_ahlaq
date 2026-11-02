import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class SlotServiceDurationNote extends StatelessWidget {
  final int minutes;

  const SlotServiceDurationNote({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          S().slotsServiceDurationNote(minutes),
          style: TextStyle(
            fontSize: 12.sp,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
