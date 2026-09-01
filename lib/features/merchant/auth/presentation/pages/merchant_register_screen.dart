import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_password_field.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/labeled_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../shared/auth/presentation/widgets/auth_brand_header.dart';
import '../../../../../shared/auth/presentation/widgets/auth_footer_prompt.dart';
import '../../data/requests/register_request.dart';
import '../manager/merchant_auth_cubit.dart';
import '../manager/merchant_auth_state.dart';
import '../../../../../generated/l10n.dart';

class MerchantRegisterScreen extends StatefulWidget {
  const MerchantRegisterScreen({super.key});

  @override
  State<MerchantRegisterScreen> createState() => _MerchantRegisterScreenState();
}

class _MerchantRegisterScreenState extends State<MerchantRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessController = TextEditingController();
  final _ownerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _businessController.dispose();
    _ownerController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<MerchantAuthCubit>().register(
      RegisterRequest(
        businessName: _businessController.text.trim(),
        ownerName: _ownerController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().registerMerchant),
      body: BlocListener<MerchantAuthCubit, MerchantAuthState>(
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
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              AuthBrandHeader(
                title: S().createMerchantAccount,
                subtitle: S().registerSubtitle,
              ),
              SizedBox(height: 24.h),
              AppCard(
                padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
                child: Column(children: _buildFormFields()),
              ),
              SizedBox(height: 18.h),
              AuthFooterPrompt(
                label: S().alreadyHaveAccountLogin,
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      LabeledField(
        label: S().businessName,
        child: AppTextField(
          controller: _businessController,
          hint: S().businessNameHint,
          validator: (v) => (v == null || v.trim().isEmpty)
              ? S().businessNameRequired
              : null,
        ),
      ),
      LabeledField(
        label: S().ownerName,
        child: AppTextField(
          controller: _ownerController,
          hint: S().ownerNameHint,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? S().ownerNameRequired : null,
        ),
      ),
      LabeledField(
        label: S().phoneNumber,
        child: AppTextField(
          controller: _phoneController,
          hint: '01001234567',
          isNumber: true,
          validator: (v) => (v == null || v.trim().length < 10)
              ? S().please_enter_a_valid_phone_number
              : null,
        ),
      ),
      LabeledField(
        label: S().password,
        child: AppPasswordField(
          controller: _passwordController,
          hint: S().passwordMinHint,
          onSubmitted: _submit,
          validator: (v) =>
              (v == null || v.length < 6) ? S().passwordTooShort : null,
        ),
      ),
      SizedBox(height: 6.h),
      BlocBuilder<MerchantAuthCubit, MerchantAuthState>(
        builder: (context, state) => PrimaryCtaButton(
          label: S().createAccount,
          isLoading: state.status == AuthStatus.submitting,
          onPressed: _submit,
        ),
      ),
    ];
  }
}
