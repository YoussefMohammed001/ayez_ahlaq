import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/constants/assets_manager.dart';
import 'package:ayez_ahlaq/core/widgets/app_form_field.dart';
import 'package:ayez_ahlaq/core/widgets/app_svg.dart';
import 'package:ayez_ahlaq/core/widgets/bouncing_widgets.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class PasswordFormFiled extends StatefulWidget {
  const PasswordFormFiled({
    super.key,
    required this.passwordController,
    this.title,
    this.isLogin = false,
    this.textInputAction,
  });
  final TextEditingController passwordController;
  final TextInputAction? textInputAction;
  final String? title;
  final bool isLogin;

  @override
  State<PasswordFormFiled> createState() => _PasswordFormFiledState();
}

class _PasswordFormFiledState extends State<PasswordFormFiled> {
  bool obSecure = true;

  bool get hasMinLength => widget.passwordController.text.length >= 8;
  bool get hasUpperCase =>
      widget.passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get hasLowerCase =>
      widget.passwordController.text.contains(RegExp(r'[a-z]'));
  bool get hasNumber =>
      widget.passwordController.text.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      widget.passwordController.text.contains(RegExp(r'[^\w\s]'));

  @override
  void initState() {
    widget.passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      textInputAction: widget.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 1,
      obsecureText: obSecure,
      controller: widget.passwordController,
      hintText: "**********",
      title: widget.title ?? S().password,
      onChanged: (_) => setState(() {}),
      validator: (v) {
        if (v == null || v.isEmpty) return S().enter_password;

        final hasMinLength = v.length >= 8;
        final hasUpperCase = v.contains(RegExp(r'[A-Z]'));
        final hasLowerCase = v.contains(RegExp(r'[a-z]'));
        final hasNumber = v.contains(RegExp(r'[0-9]'));
        final hasSpecialChar = v.contains(RegExp(r'[^\w\s]'));

        if (widget.isLogin == false) {
          if (!hasMinLength ||
              !hasUpperCase ||
              !hasLowerCase ||
              !hasNumber ||
              !hasSpecialChar) {
            return S().weak_password;
          }
        }
        return null;
      },

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
    );
  }
}
