import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';

class FilterChipRow<T> extends StatelessWidget {
  final List<T> options;
  final T? selected;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onSelected;
  final String allLabel;
  final int Function(T)? countBuilder;

  const FilterChipRow({
    super.key,
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onSelected,
    required this.allLabel,
    this.countBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          _buildChip(
            context,
            allLabel,
            null,
            selected == null,
            () => onSelected(null),
          ),
          for (final option in options)
            _buildChip(
              context,
              labelBuilder(option),
              countBuilder?.call(option),
              selected == option,
              () => onSelected(option),
            ),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context,
    String label,
    int? count,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? context.colorScheme.surfaceContainerLowest
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
              if (count != null && count > 0) ...[
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colorScheme.surfaceContainerLowest.withValues(
                            alpha: 0.25,
                          )
                        : context.semantic.warning,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.surfaceContainerLowest,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
