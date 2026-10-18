import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';

class MapPickerCenterPin extends StatelessWidget {
  const MapPickerCenterPin({super.key});

  @override
  Widget build(BuildContext context) {
    final pinSize = 46.r;

    return IgnorePointer(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: pinSize),
          child: Icon(
            Icons.location_on_rounded,
            size: pinSize,
            color: context.semantic.accentStrong,
          ),
        ),
      ),
    );
  }
}
