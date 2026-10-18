import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import 'auth_brand_header.dart';
import '../../../../core/helpers/clear_fields_after_submit.dart';

class SetNewPasswordView extends StatefulWidget {
  final bool isSubmitting;
  final ValueChanged<String> onSubmit;

  const SetNewPasswordView({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  State<SetNewPasswordView> createState() => _SetNewPasswordViewState();
}

class _SetNewPasswordViewState extends State<SetNewPasswordView>
    with ClearFieldsAfterSubmit<SetNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  List<TextEditingController> get fieldsToClear => [
    _passwordController,
    _confirmController,
  ];

  @override
  GlobalKey<FormState> get clearableFormKey => _formKey;

  @override
  bool isSubmittingOf(SetNewPasswordView widget) => widget.isSubmitting;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: [
          AuthBrandHeader(
            title: S().setNewPasswordTitle,
            subtitle: S().setNewPasswordSubtitle,
          ),
          SizedBox(height: 24.h),
          AppCard(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
            child: Column(
              children: [
                LabeledField(
                  label: S().newPassword,
                  child: AppPasswordField(
                    controller: _passwordController,
                    hint: S().passwordMinHint,
                    validator: (v) => (v == null || v.length < 6)
                        ? S().passwordTooShort
                        : null,
                  ),
                ),
                LabeledField(
                  label: S().confirmNewPassword,
                  child: AppPasswordField(
                    controller: _confirmController,
                    hint: '••••••',
                    onSubmitted: _submit,
                    validator: (v) => v != _passwordController.text
                        ? S().passwordNotMatch
                        : null,
                  ),
                ),
                SizedBox(height: 6.h),
                PrimaryCtaButton(
                  label: S().saveNewPassword,
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
