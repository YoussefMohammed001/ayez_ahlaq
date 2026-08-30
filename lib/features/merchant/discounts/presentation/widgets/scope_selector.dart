import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/discount_scope.dart';
import 'discount_scope_label.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ScopeSelector extends StatelessWidget {
  final DiscountScope value;
  final ValueChanged<DiscountScope> onChanged;

  const ScopeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final scope in DiscountScope.values)
          AppCard(
            onTap: () => onChanged(scope),
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(12.w),
            borderColor: scope == value
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            child: Row(
              children: [
                Icon(
                  scope == value
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 18.r,
                  color: scope == value
                      ? context.semantic.accentStrong
                      : context.colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scope.label,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        scope.hint,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
