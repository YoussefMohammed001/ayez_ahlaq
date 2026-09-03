import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class ResetPasswordSheet extends StatefulWidget {
  final bool isSubmitting;
  final Future<bool> Function(String tempPassword) onSubmit;

  const ResetPasswordSheet({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required bool isSubmitting,
    required Future<bool> Function(String tempPassword) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          ResetPasswordSheet(isSubmitting: isSubmitting, onSubmit: onSubmit),
    );
  }

  @override
  State<ResetPasswordSheet> createState() => _ResetPasswordSheetState();
}

class _ResetPasswordSheetState extends State<ResetPasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final saved = await widget.onSubmit(_passwordController.text.trim());

    if (saved && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                SectionTitle(title: S().resetPasswordTitle),
                AppTextField(
                  controller: _passwordController,
                  hint: S().tempPasswordHint,
                  validator: (v) =>
                      (v ?? '').trim().length < 6 ? S().tempPasswordLabel : null,
                ),
                SizedBox(height: 20.h),
                PrimaryCtaButton(
                  label: S().save,
                  isLoading: widget.isSubmitting,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
