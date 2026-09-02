import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';

class MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;
  final bool showChevron;
  final bool showDivider;
  final Widget? trailing;

  const MenuRow({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.danger = false,
    this.showChevron = true,
    this.showDivider = true,
    this.trailing,
  });

  MenuRow withoutDivider() {
    return MenuRow(
      icon: icon,
      label: label,
      onTap: onTap,
      danger: danger,
      showChevron: showChevron,
      showDivider: false,
      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = danger ? context.semantic.warning : context.colorScheme.onSurface;
    final accent = context.semantic.accentStrong;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: showDivider
                  ? context.colorScheme.outline
                  : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32.r,
              height: 32.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (danger ? context.semantic.warning : accent)
                    .withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 18.r,
                color: danger ? context.semantic.warning : accent,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailing != null) ...[
              trailing!,
              SizedBox(width: 8.w),
            ],
            if (showChevron)
              Icon(
                Icons.chevron_right,
                size: 18.r,
                color: context.colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}
