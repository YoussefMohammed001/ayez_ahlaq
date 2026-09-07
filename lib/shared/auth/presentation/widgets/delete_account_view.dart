import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';

class DeleteAccountView extends StatefulWidget {
  final bool isSubmitting;
  final ValueChanged<String> onConfirm;

  const DeleteAccountView({
    super.key,
    required this.isSubmitting,
    required this.onConfirm,
  });

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onConfirm(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          AppCard(
            borderColor: context.colorScheme.error,
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().deleteAccountTitle,
                  style: font15w700.copyWith(color: context.colorScheme.error),
                ),
                SizedBox(height: 10.h),
                Text(
                  S().deleteAccountWarning,
                  style: font13w400.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
                ),
                SizedBox(height: 18.h),
                LabeledField(
                  label: S().password,
                  child: AppPasswordField(
                    controller: _passwordController,
                    hint: '••••••',
                    onSubmitted: _submit,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? S().passwordRequired : null,
                  ),
                ),
                SizedBox(height: 6.h),
                PrimaryCtaButton(
                  label: S().deleteAccountConfirm,
                  isLoading: widget.isSubmitting,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
