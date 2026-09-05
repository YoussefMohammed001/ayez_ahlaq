import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/extensions/ext_theme.dart';

class DashboardEmptyHint extends StatelessWidget {
  final String message;

  const DashboardEmptyHint({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Text(
        message,
        style: TextStyle(fontSize: 12.5.sp, color: context.colorScheme.onSurfaceVariant),
      ),
    );
  }
}
