import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardAttentionRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const DashboardAttentionRow({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 18.r, color: color),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: font13w500.copyWith(color: context.colorScheme.onSurface),
            ),
          ),
          Text(value, style: font15w700.copyWith(color: color)),
          if (onTap != null) ...[
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right,
              size: 18.r,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ],
      ),
    );
  }
}
