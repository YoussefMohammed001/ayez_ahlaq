import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';

import '../theme/dimensions.dart';
import '../theme/light_colors.dart';
import '../theme/styles.dart';

class AppFormField extends StatefulWidget {
  const AppFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.focusNode,
    this.textInputAction,
    this.enabled = true,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onSaved,
    this.validator,
    this.validatedText,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.helperText = "",
    this.fillColor,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.radius = 10,
    this.obsecureText = false,
    this.readOnly = false,
    this.autofillHints,
    this.contentPadding,
    this.title,
    this.titleStyle,
    this.hintStyle,
  });

  final TextEditingController controller;
  final String hintText;
  final String helperText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  final TextInputAction? textInputAction;

  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? autofocus;

  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? validatedText;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final AutovalidateMode autovalidateMode;
  final double? radius;
  final bool obsecureText;
  final bool readOnly;
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final String? title;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Text(widget.title!, style: widget.titleStyle ?? font14w600)
              : Container(),
          widget.title != null ? 5.hSpace : Container(),
          TextFormField(
            autofocus: widget.autofocus ?? false,
            enableInteractiveSelection:
                widget.readOnly || widget.enabled == false ? false : true,
            autovalidateMode: widget.autovalidateMode,
            readOnly: widget.readOnly,
            autofillHints: widget.autofillHints,
            obscureText: widget.obsecureText,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            textInputAction: widget.textInputAction,
            validator: widget.validator ?? (value) => null,
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onFieldSubmitted,
            onTap: widget.onTap,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign,
            style: font14w400,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              border: InputBorder.none,
              helperText: widget.helperText,
              fillColor: Theme.of(context).colorScheme.onPrimary,
              filled: true,
              helperStyle: font12w500.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              helperMaxLines: 2,
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  font12w400.copyWith(color: Theme.of(context).hintColor),
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              suffixIcon: widget.suffixIcon,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.readOnly == true
                      ? Colors.transparent
                      : Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(
                  widget.radius ?? AppDimensions.defaultRadius,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? AppDimensions.defaultRadius,
                ),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFFE4E4E4),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? AppDimensions.defaultRadius,
                ),
                borderSide: const BorderSide(color: Color(0xFFE4E4E4)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppLightColors.formfiledErrorColor,
                ),
                borderRadius: BorderRadius.circular(
                  widget.radius ?? AppDimensions.defaultRadius,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppLightColors.formfiledErrorColor,
                ),
                borderRadius: BorderRadius.circular(
                  widget.radius ?? AppDimensions.defaultRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
