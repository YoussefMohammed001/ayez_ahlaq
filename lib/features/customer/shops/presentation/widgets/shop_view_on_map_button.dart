import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class ShopViewOnMapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShopViewOnMapButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final accent = context.semantic.accentStrong;

    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.map_outlined, size: 20.r, color: accent),
        label: Text(
          S().viewOnMap,
          style: TextStyle(fontSize: 14.sp, color: accent),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(46.h),
          side: BorderSide(color: accent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ),
    );
  }
}
