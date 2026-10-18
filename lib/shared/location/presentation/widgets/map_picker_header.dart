import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';

class MapPickerHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const MapPickerHeader({
    super.key,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 1.h, 16.w, 4.h),
      child: Row(
        children: [
          InkWell(
            onTap: onClose,
            customBorder: const CircleBorder(),
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.surfaceContainer,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 20.r,
                color: scheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          SizedBox(width: 40.r),
        ],
      ),
    );
  }
}
