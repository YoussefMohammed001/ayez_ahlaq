import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import 'auth_brand_header.dart';

class ForgotPasswordView extends StatefulWidget {
  final bool isSubmitting;
  final ValueChanged<String> onSubmit;

  const ForgotPasswordView({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(_phoneController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: [
          AuthBrandHeader(
            title: S().forgotPasswordTitle,
            subtitle: S().forgotPasswordSubtitle,
          ),
          SizedBox(height: 24.h),
          AppCard(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
            child: Column(
              children: [
                LabeledField(
                  label: S().phoneNumber,
                  child: AppTextField(
                    controller: _phoneController,
                    hint: '01001234567',
                    isNumber: true,
                    validator: Validators.validateEgyptianPhoneNumber,
                  ),
                ),
                SizedBox(height: 6.h),
                PrimaryCtaButton(
                  label: S().sendCode,
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
