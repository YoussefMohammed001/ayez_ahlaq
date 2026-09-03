import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_password_field.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/labeled_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../shared/auth/presentation/widgets/auth_brand_header.dart';
import '../manager/barber_auth_cubit.dart';
import '../manager/barber_auth_state.dart';
import '../../../../../generated/l10n.dart';

class BarberLoginScreen extends StatefulWidget {
  const BarberLoginScreen({super.key});

  @override
  State<BarberLoginScreen> createState() => _BarberLoginScreenState();
}

class _BarberLoginScreenState extends State<BarberLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<BarberAuthCubit>().login(
      _identifierController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<BarberAuthCubit, BarberAuthState>(
          listener: (context, state) {
            if (state.status == BarberAuthStatus.authenticated) {
              context.go(Routes.barberShell);
            }
            if (state.status == BarberAuthStatus.failure &&
                state.errorMessage != null) {
              showError(state.errorMessage!);
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 36.h, 20.w, 24.h),
              children: [
                AuthBrandHeader(
                  title: S().welcomeBack,
                  subtitle: S().loginSubtitle,
                ),
                SizedBox(height: 26.h),
                AppCard(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
                  child: Column(children: _buildFormFields()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      LabeledField(
        label: S().phoneNumber,
        child: AppTextField(
          controller: _identifierController,
          hint: '01001234567',
          isNumber: true,
        ),
      ),
      LabeledField(
        label: S().password,
        child: AppPasswordField(
          controller: _passwordController,
          hint: '••••••',
          onSubmitted: _submit,
          validator: (v) =>
              (v == null || v.length < 6) ? S().passwordTooShort : null,
        ),
      ),
      SizedBox(height: 6.h),
      BlocBuilder<BarberAuthCubit, BarberAuthState>(
        builder: (context, state) => PrimaryCtaButton(
          label: S().signIn,
          isLoading: state.status == BarberAuthStatus.submitting,
          onPressed: _submit,
        ),
      ),
    ];
  }
}
