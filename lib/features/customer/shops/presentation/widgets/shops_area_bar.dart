import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';

class ShopsAreaBar extends StatelessWidget {
  final String? label;
  final VoidCallback onChange;
  final VoidCallback onUseMyLocation;

  const ShopsAreaBar({
    super.key,
    required this.label,
    required this.onChange,
    required this.onUseMyLocation,
  });

  bool get _isElsewhere => label != null;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final shown = label == null || label!.isEmpty
        ? S().shopsAreaMyLocation
        : label!;

    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      onTap: onChange,
      child: Row(
        children: [
          Icon(Icons.place_outlined, color: scheme.primary, size: 22.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().shopsAreaTitle,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  shown,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (_isElsewhere)
            IconButton(
              tooltip: S().shopsAreaBack,
              icon: Icon(Icons.my_location_rounded, size: 22.r),
              onPressed: onUseMyLocation,
            ),
          TextButton(onPressed: onChange, child: Text(S().shopsAreaChange)),
        ],
      ),
    );
  }
}
