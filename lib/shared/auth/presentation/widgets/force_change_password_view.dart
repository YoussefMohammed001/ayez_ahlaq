import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/theme/styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/helpers/clear_fields_after_submit.dart';

class ForceChangePasswordView extends StatefulWidget {
  final bool isSubmitting;
  final Future<bool> Function(String current, String updated) onSubmit;

  const ForceChangePasswordView({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  State<ForceChangePasswordView> createState() =>
      _ForceChangePasswordViewState();
}

class _ForceChangePasswordViewState extends State<ForceChangePasswordView>
    with ClearFieldsAfterSubmit<ForceChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  List<TextEditingController> get fieldsToClear => [
    _currentController,
    _newController,
    _confirmController,
  ];

  @override
  GlobalKey<FormState> get clearableFormKey => _formKey;

  @override
  bool isSubmittingOf(ForceChangePasswordView widget) => widget.isSubmitting;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.onSubmit(_currentController.text, _newController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          AppCard(
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().forceChangePasswordMessage,
                  style: font13w400.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
                ),
                SizedBox(height: 18.h),
                LabeledField(
                  label: S().currentPassword,
                  child: AppPasswordField(
                    controller: _currentController,
                    hint: '••••••',
                    validator: (v) => (v == null || v.isEmpty)
                        ? S().currentPasswordRequired
                        : null,
                  ),
                ),
                LabeledField(
                  label: S().newPassword,
                  child: AppPasswordField(
                    controller: _newController,
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
                    validator: (v) =>
                        v != _newController.text ? S().passwordNotMatch : null,
                  ),
                ),
                SizedBox(height: 6.h),
                PrimaryCtaButton(
                  label: S().changePassword,
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
