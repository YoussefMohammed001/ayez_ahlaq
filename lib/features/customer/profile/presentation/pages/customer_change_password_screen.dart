import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_password_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/labeled_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/customer_profile_cubit.dart';
import '../manager/customer_profile_state.dart';

class CustomerChangePasswordScreen extends StatefulWidget {
  const CustomerChangePasswordScreen({super.key});

  @override
  State<CustomerChangePasswordScreen> createState() =>
      _CustomerChangePasswordScreenState();
}

class _CustomerChangePasswordScreenState
    extends State<CustomerChangePasswordScreen> {
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

    final cubit = context.read<CustomerProfileCubit>();
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
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          children: [
            AppCard(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
              child: Column(children: _buildFormFields()),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      LabeledField(
        label: S().currentPassword,
        child: AppPasswordField(
          controller: _currentController,
          hint: '••••••',
          validator: (v) =>
              (v == null || v.isEmpty) ? S().currentPasswordRequired : null,
        ),
      ),
      LabeledField(
        label: S().newPassword,
        child: AppPasswordField(
          controller: _newController,
          hint: S().passwordMinHint,
          validator: (v) =>
              (v == null || v.length < 6) ? S().passwordTooShort : null,
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
      BlocBuilder<CustomerProfileCubit, CustomerProfileState>(
        builder: (context, state) => PrimaryCtaButton(
          label: S().changePassword,
          isLoading: state.isSubmitting,
          onPressed: _submit,
        ),
      ),
    ];
  }
}
