import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/presentation/widgets/auth_brand_header.dart';
import '../../../../../shared/auth/presentation/widgets/auth_footer_prompt.dart';
import '../manager/barber_auth_cubit.dart';
import '../manager/barber_auth_state.dart';
import '../widgets/barber_register_form.dart';

class BarberRegisterScreen extends StatelessWidget {
  const BarberRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().registerBarber),
      body: BlocConsumer<BarberAuthCubit, BarberAuthState>(
        listener: (context, state) {
          if (state.status == BarberAuthStatus.authenticated) {
            context.go(Routes.barberShell);
          }
          if (state.status == BarberAuthStatus.otpRequested) {
            context.replace(Routes.barberVerifyOtpScreen);
          }
          if (state.status == BarberAuthStatus.failure &&
              state.errorMessage != null) {
            showError(state.errorMessage!);
          }
        },
        builder: (context, state) => ListView(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
          children: [
            AuthBrandHeader(
              title: S().createBarberAccount,
              subtitle: S().registerSubtitleBarber,
            ),
            SizedBox(height: 24.h),
            AppCard(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
              child: BarberRegisterForm(
                isSubmitting: state.status == BarberAuthStatus.submitting,
                onSubmit: context.read<BarberAuthCubit>().register,
              ),
            ),
            SizedBox(height: 18.h),
            AuthFooterPrompt(
              label: S().alreadyHaveAccountLogin,
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
