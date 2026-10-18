import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class TeamMemberAccountHint extends StatelessWidget {
  const TeamMemberAccountHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        S().teamMemberAccountHint,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.5.sp,
          color: context.colorScheme.onSurfaceVariant,
          height: 1.7,
        ),
      ),
    );
  }
}
