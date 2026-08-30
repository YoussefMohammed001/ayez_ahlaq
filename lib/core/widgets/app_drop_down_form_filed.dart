import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import '../theme/light_colors.dart';
import '../theme/styles.dart';

class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.enabled = true,
    this.radius = 12,
    this.title,
    this.titleStyle,
    this.fillColor,
    this.contentPadding,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final T? value;
  final void Function(T?)? onChanged;
  final bool enabled;
  final double radius;
  final String? title;
  final TextStyle? titleStyle;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<T>? validator;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: titleStyle ?? font14w600),
          5.hSpace,
        ],
        DropdownButtonFormField<T>(
          autovalidateMode: autovalidateMode,
          validator: validator,
          initialValue: items.any((e) => e.value == value) ? value : null,
          borderRadius: BorderRadius.circular(radius),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? null : Colors.grey.shade300,
            label: Text(
              hintText,
              style: font12w400.copyWith(color: "#999999".toColor()),
            ),
            labelStyle: font12w400.copyWith(color: "#999999".toColor()),
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: AppLightColors.primary),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Color(0xFFE4E4E4)),
            ),
          ),
          items: items,
          onChanged: enabled ? onChanged : null,
          style: enabled ? null : TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
