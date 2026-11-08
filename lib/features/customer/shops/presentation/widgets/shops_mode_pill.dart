import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ShopsModePill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final bool opensPicker;
  final VoidCallback onTap;

  const ShopsModePill({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.opensPicker = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final accent = context.semantic.accentStrong;
    final foreground = selected
        ? scheme.surfaceContainerLowest
        : scheme.onSurface;

    return Material(
      color: selected ? accent : scheme.surfaceContainer,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? accent : scheme.outline),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18.r, color: foreground),
              SizedBox(width: 6.w),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 120.w),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ),
                ),
              ),
              if (opensPicker) ...[
                SizedBox(width: 2.w),
                Icon(Icons.expand_more_rounded, size: 18.r, color: foreground),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
