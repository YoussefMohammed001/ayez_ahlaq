import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/helpers/number_convertor.dart';

import 'package:ayez_ahlaq/core/constants/assets_manager.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import 'package:ayez_ahlaq/core/widgets/app_form_field.dart';
import 'package:ayez_ahlaq/core/widgets/app_svg.dart';
import 'package:ayez_ahlaq/core/widgets/bouncing_widgets.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class ConfirmPasswordFormFiled extends StatefulWidget {
  const ConfirmPasswordFormFiled({
    super.key,
    required this.controller,
    required this.passwordController,
    this.title,
  });

  final TextEditingController controller;
  final String? title;
  final TextEditingController passwordController;

  @override
  State<ConfirmPasswordFormFiled> createState() =>
      _ConfirmPasswordFormFiledState();
}

class _ConfirmPasswordFormFiledState extends State<ConfirmPasswordFormFiled> {
  bool obSecure = true;

  bool get hasMinLength => widget.passwordController.text.length >= 8;
  bool get hasUpperCase =>
      widget.passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get hasNumber =>
      widget.passwordController.text.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      widget.passwordController.text.contains(RegExp(r'[^\w\s]'));
  bool get passwordMatches =>
      widget.passwordController.text == widget.controller.text &&
      widget.passwordController.text.isNotEmpty;

  @override
  void initState() {
    widget.passwordController.addListener(() => setState(() {}));
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormField(
          autovalidateMode: AutovalidateMode.disabled,
          maxLines: 1,
          obsecureText: obSecure,
          validator: (v) {
            if (v!.isEmpty) {
              return s.confirm_password.substring(
                0,
                s.confirm_password.length - 1,
              );
            } else if (widget.passwordController.text != v) {
              safePrint(
                "confirm pass-- ${widget.passwordController.text} - $v",
              );
              return s.passwordNotMatch;
            }

            return null;
          },
          controller: widget.controller,
          hintText: "**********",
          title: widget.title ?? s.confirm_password,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: BounceIt(
              onPressed: () {
                setState(() {
                  obSecure = !obSecure;
                });
              },
              child: AppSVG(
                assetName: obSecure
                    ? AssetsManager.notVisible
                    : AssetsManager.visible,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ),
        ),

        12.verticalSpace,

        /// Requirements Rows
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildRequirement(
                    s.contain_number_and_special,
                    hasNumber && hasSpecialChar,
                  ),
                ),
                Expanded(
                  child: _buildRequirement(
                    NumberConverter.convert(s.min_8_char),
                    hasMinLength,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildRequirement(s.contain_uppercase, hasUpperCase),
                ),
                Expanded(
                  child: _buildRequirement(s.passwordMatches, passwordMatches),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequirement(String text, bool fulfilled) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Row(
        children: [
          Icon(
            fulfilled ? Icons.check_circle : Icons.radio_button_unchecked,
            color: fulfilled ? Colors.green : Colors.grey,
            size: 18.sp,
          ),
          6.horizontalSpace,
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                color: fulfilled ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
