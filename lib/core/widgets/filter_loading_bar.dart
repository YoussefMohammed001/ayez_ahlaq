import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/ext_theme.dart';

class FilterLoadingBar extends StatelessWidget {
  const FilterLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 0,
      start: 0,
      end: 0,
      child: LinearProgressIndicator(
        minHeight: 2.5.h,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(context.semantic.accentSoft),
      ),
    );
  }
}
