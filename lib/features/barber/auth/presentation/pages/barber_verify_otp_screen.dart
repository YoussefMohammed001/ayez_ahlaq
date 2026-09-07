import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/otp_verification_view.dart';
import '../manager/barber_auth_cubit.dart';
import '../manager/barber_auth_state.dart';

class BarberVerifyOtpScreen extends StatelessWidget {
  const BarberVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) context.read<BarberAuthCubit>().resetStatus();
      },
      child: Scaffold(
        appBar: AppTopBar(title: S().verifyPhoneTitle),
        body: BlocConsumer<BarberAuthCubit, BarberAuthState>(
          listener: (context, state) {
            if (state.status == BarberAuthStatus.authenticated) {
              context.read<BarberAuthCubit>().resetStatus();
              context.go(Routes.barberLoginScreen);
            }
            if (state.status == BarberAuthStatus.otpResent &&
                state.infoMessage != null) {
              showSuccess(state.infoMessage!);
            }
            if (state.status == BarberAuthStatus.failure &&
                state.errorMessage != null) {
              showError(state.errorMessage!);
            }
          },
          builder: (context, state) {
            final cubit = context.read<BarberAuthCubit>();
            return OtpVerificationView(
              phone: state.pendingPhone,
              isSubmitting: state.status == BarberAuthStatus.submitting,
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
