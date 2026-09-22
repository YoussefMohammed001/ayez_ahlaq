import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class AdjustmentTypeToggle extends StatelessWidget {
  final bool isDiscount;
  final ValueChanged<bool> onChanged;

  const AdjustmentTypeToggle({
    super.key,
    required this.isDiscount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        children: [
          _buildOption(context, S().adjustmentTypeAddition, false),
          _buildOption(context, S().adjustmentTypeDiscount, true),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label, bool value) {
    final isSelected = isDiscount == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? (value ? context.semantic.success : context.colorScheme.primary)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
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
