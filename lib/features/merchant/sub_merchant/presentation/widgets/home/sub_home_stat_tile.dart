import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../core/theme/styles.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/custom_text.dart';

class SubHomeStatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool highlight;
  final VoidCallback onTap;

  const SubHomeStatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final accent = highlight ? scheme.primary : scheme.onSurfaceVariant;

    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(14.r),
      borderColor: highlight ? scheme.primary : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22.r, color: accent),
          SizedBox(height: 10.h),
          AppText(value, style: font24w700.copyWith(color: scheme.onSurface)),
          SizedBox(height: 2.h),
          AppText(
            label,
            style: font12w500.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
