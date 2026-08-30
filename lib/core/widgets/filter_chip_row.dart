import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';

class FilterChipRow<T> extends StatelessWidget {
  final List<T> options;
  final T? selected;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onSelected;
  final String allLabel;

  const FilterChipRow({
    super.key,
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onSelected,
    required this.allLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          _buildChip(context, allLabel, selected == null, () => onSelected(null)),
          for (final option in options)
            _buildChip(context, 
              labelBuilder(option),
              selected == option,
              () => onSelected(option),
            ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: isSelected ? context.colorScheme.primary : context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? context.colorScheme.surfaceContainerLowest
                  : context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
