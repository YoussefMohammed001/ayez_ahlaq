import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/forgot_password_view.dart';
import '../manager/customer_auth_cubit.dart';
import '../manager/customer_auth_state.dart';

class CustomerForgotPasswordScreen extends StatelessWidget {
  const CustomerForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().forgotPasswordTitle),
      body: BlocConsumer<CustomerAuthCubit, CustomerAuthState>(
        listener: (context, state) {
          if (state.status == CustomerAuthStatus.otpRequested) {
            context.replace(Routes.customerResetPasswordOtpScreen);
          }
          if (state.status == CustomerAuthStatus.failure &&
              state.errorMessage != null) {
            showError(state.errorMessage!);
          }
        },
        builder: (context, state) => ForgotPasswordView(
          isSubmitting: state.status == CustomerAuthStatus.submitting,
          onSubmit: context.read<CustomerAuthCubit>().forgotPassword,
        ),
      ),
    );
  }
}
