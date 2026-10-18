import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: emphasize ? 15.sp : 13.sp,
              fontWeight: FontWeight.w700,
              color: emphasize
                  ? context.semantic.accentStrong
                  : scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
