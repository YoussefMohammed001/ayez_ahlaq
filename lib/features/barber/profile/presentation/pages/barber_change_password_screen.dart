import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';
import '../../../../../generated/l10n.dart';

class BarberChangePasswordScreen extends StatefulWidget {
  const BarberChangePasswordScreen({super.key});

  @override
  State<BarberChangePasswordScreen> createState() =>
      _BarberChangePasswordScreenState();
}

class _BarberChangePasswordScreenState
    extends State<BarberChangePasswordScreen> {
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

    final cubit = context.read<BarberProfileCubit>();
    final changed = await cubit.changePassword(
      _currentController.text,
      _newController.text,
    );

    if (!mounted) return;

    if (changed) {
      showSuccess(S().passwordChanged);
      context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
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
            AppTextField(
              controller: _currentController,
              hint: '••••••',
              obscure: true,
              validator: (v) =>
                  (v == null || v.isEmpty) ? S().currentPasswordRequired : null,
            ),
            SectionTitle(title: S().newPassword),
            AppTextField(
              controller: _newController,
              hint: S().passwordMinHint,
              obscure: true,
              validator: (v) =>
                  (v == null || v.length < 6) ? S().passwordTooShort : null,
            ),
            SectionTitle(title: S().confirmNewPassword),
            AppTextField(
              controller: _confirmController,
              hint: '••••••',
              obscure: true,
              validator: (v) =>
                  v != _newController.text ? S().passwordNotMatch : null,
            ),
            SizedBox(height: 20.h),
            BlocBuilder<BarberProfileCubit, BarberProfileState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().changePassword,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
