import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/ext_theme.dart';

class SheetGrabber extends StatelessWidget {
  const SheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(top: 4.h, bottom: 14.h),
        decoration: BoxDecoration(
          color: context.colorScheme.outline,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}
