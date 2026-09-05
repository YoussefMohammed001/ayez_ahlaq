import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';

class EnterInviteCodeScreen extends StatefulWidget {
  const EnterInviteCodeScreen({super.key});

  @override
  State<EnterInviteCodeScreen> createState() => _EnterInviteCodeScreenState();
}

class _EnterInviteCodeScreenState extends State<EnterInviteCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.push(
      Routes.customerInvitePreviewScreen,
      extra: _codeController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().enterInviteCodeTitle),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          children: [
            AppTextField(
              controller: _codeController,
              hint: S().inviteCodeHint,
              validator: (v) => (v == null || v.trim().isEmpty) ? S().inviteCodeRequired : null,
            ),
            SizedBox(height: 16.h),
            PrimaryCtaButton(label: S().continueLabel, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}
