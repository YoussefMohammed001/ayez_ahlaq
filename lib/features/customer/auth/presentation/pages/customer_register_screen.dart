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
import '../../data/requests/customer_register_request.dart';
import '../manager/customer_auth_cubit.dart';
import '../manager/customer_auth_state.dart';
import '../../../../../generated/l10n.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<CustomerAuthCubit>().register(
      CustomerRegisterRequest(
        userName: _userNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().registerCustomer),
      body: BlocListener<CustomerAuthCubit, CustomerAuthState>(
        listener: (context, state) {
          if (state.status == CustomerAuthStatus.otpRequested) {
            context.replace(Routes.customerVerifyOtpScreen);
          }
          if (state.status == CustomerAuthStatus.failure &&
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
                title: S().createCustomerAccount,
                subtitle: S().registerSubtitleCustomer,
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
        label: S().userName,
        child: AppTextField(
          controller: _userNameController,
          hint: S().userNameHint,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? S().userNameRequired : null,
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
      LabeledField(
        label: S().emailOptional,
        child: AppTextField(
          controller: _emailController,
          hint: 'name@mail.com',
        ),
      ),
      SizedBox(height: 6.h),
      BlocBuilder<CustomerAuthCubit, CustomerAuthState>(
        builder: (context, state) => PrimaryCtaButton(
          label: S().createAccount,
          isLoading: state.status == CustomerAuthStatus.submitting,
          onPressed: _submit,
        ),
      ),
    ];
  }
}
