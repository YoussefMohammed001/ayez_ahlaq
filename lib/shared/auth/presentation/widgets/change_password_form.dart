import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/alerts.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../generated/l10n.dart';

class ChangePasswordForm extends StatefulWidget {
  final bool isSubmitting;
  final Future<bool> Function(String current, String updated) onSubmit;
  final String? Function() errorMessage;

  const ChangePasswordForm({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
    required this.errorMessage,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final changed = await widget.onSubmit(
      _currentController.text,
      _newController.text,
    );

    if (!mounted) return;

    if (changed) {
      showSuccess(S().passwordChanged);
      context.pop();
      return;
    }

    final message = widget.errorMessage();
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().changePassword),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            SectionTitle(title: S().currentPassword),
            AppPasswordField(
              controller: _currentController,
              hint: '••••••',
              validator: (v) =>
                  (v == null || v.isEmpty) ? S().currentPasswordRequired : null,
            ),
            SectionTitle(title: S().newPassword),
            AppPasswordField(
              controller: _newController,
              hint: S().passwordMinHint,
              validator: (v) =>
                  (v == null || v.length < 6) ? S().passwordTooShort : null,
            ),
            SectionTitle(title: S().confirmNewPassword),
            AppPasswordField(
              controller: _confirmController,
              hint: '••••••',
              validator: (v) =>
                  v != _newController.text ? S().passwordNotMatch : null,
            ),
            SizedBox(height: 20.h),
            PrimaryCtaButton(
              label: S().changePassword,
              isLoading: widget.isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
