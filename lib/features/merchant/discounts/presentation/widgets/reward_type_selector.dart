import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/reward_type.dart';
import 'reward_type_label.dart';
import '../../../../../core/extensions/ext_theme.dart';

class RewardTypeSelector extends StatelessWidget {
  final RewardType value;
  final List<RewardType> options;
  final ValueChanged<RewardType> onChanged;

  const RewardTypeSelector({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      children: [
        for (final type in options) _buildChip(context, type),
      ],
    );
  }

  Widget _buildChip(BuildContext context, RewardType type) {
    final selected = type == value;

    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? context.colorScheme.primary : context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: selected ? context.colorScheme.primary : context.colorScheme.outline,
          ),
        ),
        child: Text(
          type.label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: selected ? context.colorScheme.surfaceContainerLowest : context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
