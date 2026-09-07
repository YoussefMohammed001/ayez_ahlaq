import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/otp_verification_view.dart';
import '../manager/customer_auth_cubit.dart';
import '../manager/customer_auth_state.dart';

class CustomerVerifyOtpScreen extends StatelessWidget {
  const CustomerVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) context.read<CustomerAuthCubit>().resetStatus();
      },
      child: Scaffold(
        appBar: AppTopBar(title: S().verifyPhoneTitle),
        body: BlocConsumer<CustomerAuthCubit, CustomerAuthState>(
          listener: (context, state) {
            if (state.status == CustomerAuthStatus.authenticated) {
              context.read<CustomerAuthCubit>().resetStatus();
              context.go(Routes.customerLoginScreen);
            }
            if (state.status == CustomerAuthStatus.otpResent &&
                state.infoMessage != null) {
              showSuccess(state.infoMessage!);
            }
            if (state.status == CustomerAuthStatus.failure &&
                state.errorMessage != null) {
              showError(state.errorMessage!);
            }
          },
          builder: (context, state) {
            final cubit = context.read<CustomerAuthCubit>();
            return OtpVerificationView(
              phone: state.pendingPhone,
              isSubmitting: state.status == CustomerAuthStatus.submitting,
              onVerify: cubit.verifyRegisterOtp,
              onResend: cubit.canResendRegisterOtp
                  ? cubit.resendRegisterOtp
                  : null,
            );
          },
        ),
      ),
    );
  }
}
