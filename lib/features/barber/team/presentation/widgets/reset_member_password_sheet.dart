import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/temp_password_validator.dart';

class ResetMemberPasswordSheet extends StatefulWidget {
  final Future<void> Function(String tempPassword) onSubmit;

  const ResetMemberPasswordSheet({super.key, required this.onSubmit});

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(String tempPassword) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ResetMemberPasswordSheet(onSubmit: onSubmit),
    );
  }

  @override
  State<ResetMemberPasswordSheet> createState() =>
      _ResetMemberPasswordSheetState();
}

class _ResetMemberPasswordSheetState extends State<ResetMemberPasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final tempPassword = _passwordController.text;
    Navigator.of(context).pop();
    widget.onSubmit(tempPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: S().resetMemberPasswordTitle),
                Text(
                  S().resetMemberPasswordNote,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: _passwordController,
                  hint: S().memberTempPasswordLabel,
                  validator: TempPasswordValidator.required,
                ),
                SizedBox(height: 20.h),
                PrimaryCtaButton(label: S().save, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
