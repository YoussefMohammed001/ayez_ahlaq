import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_input_decoration.dart';
import '../../core/extensions/ext_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isNumber;
  final bool obscure;
  final int maxLines;
  final bool readOnly;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.isNumber = false,
    this.obscure = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: obscure ? 1 : maxLines,
      obscureText: obscure,
      readOnly: readOnly,
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      inputFormatters:
          isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      style: TextStyle(
        color: readOnly
            ? context.colorScheme.onSurfaceVariant
            : context.colorScheme.onSurface,
        fontSize: 13.5.sp,
      ),
      decoration: AppInputDecoration.build(context, hint),
      validator: validator,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
