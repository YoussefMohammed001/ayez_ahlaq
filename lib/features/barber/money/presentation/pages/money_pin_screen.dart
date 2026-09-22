import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/otp_code_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/money_pin_cubit.dart';
import '../manager/money_pin_state.dart';
import '../widgets/money_pin_reset_banner.dart';

class MoneyPinScreen extends StatefulWidget {
  final String redirectRoute;
  final String? title;

  const MoneyPinScreen({
    super.key,
    this.redirectRoute = Routes.barberMoneyHomeScreen,
    this.title,
  });

  @override
  State<MoneyPinScreen> createState() => _MoneyPinScreenState();
}

class _MoneyPinScreenState extends State<MoneyPinScreen> {
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<MoneyPinCubit>();
    if (cubit.state.stage == MoneyPinStage.unlocked) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.pushReplacement(widget.redirectRoute),
      );
    } else {
      cubit.checkStatus();
      cubit.checkResetStatus();
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyPinCubit, MoneyPinState>(
      isBusy: (state) => state.submitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: widget.title ?? S().moneyManagerTitle),
        body: BlocConsumer<MoneyPinCubit, MoneyPinState>(
          listener: (context, state) {
            if (state.stage == MoneyPinStage.unlocked) {
              context.pushReplacement(widget.redirectRoute);
            }
          },
          builder: (context, state) {
            if (state.stage == MoneyPinStage.checking) {
              return const Center(child: CircularProgressIndicator());
            }

            final isSetup = state.stage == MoneyPinStage.needsSetup;
            final resetPending = state.resetStatus?.pending ?? false;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 56.r,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    isSetup ? S().moneyPinSetupTitle : S().moneyPinEnterTitle,
                    style: HeadingStyles.h5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  if (resetPending)
                    MoneyPinResetBanner(status: state.resetStatus!)
                  else ...[
                    OtpCodeField(controller: _pinController, length: 4),
                    SizedBox(height: 24.h),
                    PrimaryCtaButton(
                      label: isSetup
                          ? S().moneyPinSetupAction
                          : S().moneyPinConfirmAction,
                      isLoading: state.submitting,
                      onPressed: () => _submit(context, isSetup),
                    ),
                    if (!isSetup) ...[
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () => _forgotPin(context),
                        child: Text(S().moneyPinForgotAction),
                      ),
                    ],
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context, bool isSetup) async {
    final pin = _pinController.text;
    if (pin.length != 4) return;

    final cubit = context.read<MoneyPinCubit>();
    final success = isSetup ? await cubit.setup(pin) : await cubit.verify(pin);

    if (!success) _pinController.clear();
  }

  Future<void> _forgotPin(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().moneyPinResetConfirmTitle,
      message: S().moneyPinResetConfirmMessage,
      confirmLabel: S().moneyPinResetConfirmAction,
      icon: Icons.lock_reset_rounded,
      isDestructive: false,
    );

    if (confirmed) await context.read<MoneyPinCubit>().requestReset();
  }
}
