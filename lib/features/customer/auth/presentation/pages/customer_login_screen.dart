import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/guest/guest_browse_button.dart';
import '../../../../../core/extensions/ext_text_controllers.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_password_field.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/labeled_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../shared/auth/presentation/widgets/auth_brand_header.dart';
import '../../../../../shared/auth/presentation/widgets/auth_footer_prompt.dart';
import '../../../../../shared/auth/presentation/widgets/change_account_type_button.dart';
import '../manager/customer_auth_cubit.dart';
import '../manager/customer_auth_state.dart';
import '../../../../../generated/l10n.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _openAndReset(String route) {
    [_identifierController, _passwordController].clearAll();
    _formKey.currentState?.reset();
    context.push(route);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<CustomerAuthCubit>().login(
      _identifierController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CustomerAuthCubit, CustomerAuthState>(
          listener: (context, state) {
            if (state.status == CustomerAuthStatus.authenticated) {
              context.go(Routes.customerShell);
            }
            if (state.status == CustomerAuthStatus.otpRequested) {
              context.replace(Routes.customerVerifyOtpScreen);
            }
            if (state.status == CustomerAuthStatus.failure &&
                state.errorMessage != null) {
              _passwordController.clear();
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
                  subtitle: S().loginSubtitleCustomer,
                  accountTypeLabel: S().accountTypeBadge(S().customer),
                ),
                SizedBox(height: 26.h),
                AppCard(
                  padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
                  child: Column(children: _buildFormFields()),
                ),
                SizedBox(height: 18.h),
                AuthFooterPrompt(
                  label: S().forgotPassword,
                  onTap: () =>
                      _openAndReset(Routes.customerForgotPasswordScreen),
                ),
                AuthFooterPrompt(
                  label: S().noAccountRegisterCustomer,
                  onTap: () => _openAndReset(Routes.customerRegisterScreen),
                ),
                SizedBox(height: 10.h),
                ChangeAccountTypeButton(
                  label: S().changeAccountType,
                  onTap: () => context.go(Routes.userTypeScreen),
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
          hint: S().enterPhoneNumberHint,
          isNumber: true,
          validator: Validators.validateEgyptianPhoneNumber,
        ),
      ),
      LabeledField(
        label: S().password,
        child: AppPasswordField(
          controller: _passwordController,
          hint: S().enterPasswordHint,
          onSubmitted: _submit,
          validator: (v) =>
              (v == null || v.length < 6) ? S().passwordTooShort : null,
        ),
      ),
      SizedBox(height: 6.h),
      BlocBuilder<CustomerAuthCubit, CustomerAuthState>(
        builder: (context, state) => PrimaryCtaButton(
          label: S().signIn,
          isLoading: state.status == CustomerAuthStatus.submitting,
          onPressed: _submit,
        ),
      ),
      SizedBox(height: 10.h),
      const GuestBrowseButton(),
    ];
  }
}
