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
import '../../../../../shared/auth/presentation/widgets/auth_footer_prompt.dart';
import '../manager/merchant_auth_cubit.dart';
import '../manager/merchant_auth_state.dart';
import '../../../../../generated/l10n.dart';

class MerchantLoginScreen extends StatefulWidget {
  const MerchantLoginScreen({super.key});

  @override
  State<MerchantLoginScreen> createState() => _MerchantLoginScreenState();
}

class _MerchantLoginScreenState extends State<MerchantLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<MerchantAuthCubit>().login(
      _phoneController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<MerchantAuthCubit, MerchantAuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              context.go(Routes.merchantShell);
            }
            if (state.status == AuthStatus.failure &&
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
                SizedBox(height: 18.h),
                AuthFooterPrompt(
                  label: S().noAccountRegister,
                  onTap: () => context.push(Routes.registerScreen),
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
          controller: _phoneController,
          hint: '01001234567',
          isNumber: true,
          // validator: (v) => (v == null || v.trim().length < 10)
          //     ? S().please_enter_a_valid_phone_number
          //     : null,
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
      BlocBuilder<MerchantAuthCubit, MerchantAuthState>(
        builder: (context, state) => PrimaryCtaButton(
          label: S().signIn,
          isLoading: state.status == AuthStatus.submitting,
          onPressed: _submit,
        ),
      ),
    ];
  }
}
