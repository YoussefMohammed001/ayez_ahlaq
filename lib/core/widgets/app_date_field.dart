import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';

class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    required this.label,
    required this.value,
    required this.hint,
    required this.cs,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final String value;
  final String hint;
  final ColorScheme cs;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final hasValue = value.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: font12w500.copyWith(color: cs.tertiary.withValues(alpha: 0.7)),
        ),
        8.hSpace,
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: hasValue
                    ? cs.primary.withValues(alpha: 0.5)
                    : cs.tertiary.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hasValue ? value : hint,
                    style: font14w400.copyWith(
                      color: hasValue
                          ? cs.onSurface
                          : Theme.of(context).hintColor,
                    ),
                  ),
                ),
                if (hasValue && onClear != null)
                  GestureDetector(
                    onTap: onClear,
                    child: Icon(Icons.close, size: 16.r, color: cs.tertiary),
                  )
                else
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16.r,
                    color: hasValue
                        ? cs.primary
                        : cs.tertiary.withValues(alpha: 0.5),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
