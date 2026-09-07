import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/otp_verification_view.dart';
import '../manager/merchant_auth_cubit.dart';
import '../manager/merchant_auth_state.dart';

class MerchantResetPasswordOtpScreen extends StatelessWidget {
  const MerchantResetPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().verifyPhoneTitle),
      body: BlocConsumer<MerchantAuthCubit, MerchantAuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.otpVerified) {
            context.push(Routes.merchantResetPasswordScreen);
          }
          if (state.status == AuthStatus.failure &&
              state.errorMessage != null) {
            showError(state.errorMessage!);
          }
        },
        builder: (context, state) {
          final cubit = context.read<MerchantAuthCubit>();
          return OtpVerificationView(
            phone: state.pendingPhone,
            isSubmitting: state.status == AuthStatus.submitting,
            onVerify: cubit.verifyPasswordOtp,
            onResend: () => cubit.forgotPassword(state.pendingPhone),
          );
        },
      ),
    );
  }
}
