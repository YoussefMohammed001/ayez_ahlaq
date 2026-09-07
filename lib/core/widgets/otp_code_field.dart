import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../extensions/ext_theme.dart';
import '../theme/styles.dart';

class OtpCodeField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final int length;

  const OtpCodeField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    final defaultTheme = PinTheme(
      width: 48.w,
      height: 56.h,
      textStyle: font20w700.copyWith(color: scheme.onSurface),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: scheme.outline),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        length: length,
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        defaultPinTheme: defaultTheme,
        focusedPinTheme: defaultTheme.copyBorderWith(
          border: Border.all(color: scheme.primary, width: 1.5),
        ),
        submittedPinTheme: defaultTheme.copyBorderWith(
          border: Border.all(color: scheme.primary),
        ),
        errorPinTheme: defaultTheme.copyBorderWith(
          border: Border.all(color: scheme.error),
        ),
        onCompleted: onCompleted,
        validator: (value) =>
            (value == null || value.length < length) ? '' : null,
      ),
    );
  }
}
