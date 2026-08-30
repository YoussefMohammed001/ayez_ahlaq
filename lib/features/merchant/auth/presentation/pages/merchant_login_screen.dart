import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../manager/merchant_auth_cubit.dart';
import '../manager/merchant_auth_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

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
              padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 24.h),
              children: [
                Text(S().welcomeBack, style: HeadingStyles.h1),
                SizedBox(height: 6.h),
                Text(
                  S().loginSubtitle,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.8,
                  ),
                ),
                SectionTitle(title: S().phoneNumber),
                AppTextField(
                  controller: _phoneController,
                  hint: '01001234567',
                  isNumber: true,
                  validator: (v) => (v == null || v.trim().length < 10)
                      ? S().please_enter_a_valid_phone_number
                      : null,
                ),
                SectionTitle(title: S().password),
                AppTextField(
                  controller: _passwordController,
                  hint: '••••••',
                  obscure: true,
                  validator: (v) =>
                      (v == null || v.length < 6) ? S().passwordTooShort : null,
                ),
                SizedBox(height: 24.h),
                BlocBuilder<MerchantAuthCubit, MerchantAuthState>(
                  builder: (context, state) => PrimaryCtaButton(
                    label: S().signIn,
                    isLoading: state.status == AuthStatus.submitting,
                    onPressed: _submit,
                  ),
                ),
                SizedBox(height: 14.h),
                Center(
                  child: TextButton(
                    onPressed: () => context.push(Routes.registerScreen),
                    child: Text(
                      S().noAccountRegister,
                      style: TextStyle(
                        color: context.semantic.accentStrong,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
