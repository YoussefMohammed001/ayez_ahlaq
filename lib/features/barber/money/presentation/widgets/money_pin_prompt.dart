import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/widgets/otp_code_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/money_pin_cubit.dart';
import '../manager/money_pin_state.dart';
import 'money_pin_reset_banner.dart';

class MoneyPinPrompt extends StatefulWidget {
  final String? enterTitle;
  final String? setupTitle;

  const MoneyPinPrompt({super.key, this.enterTitle, this.setupTitle});

  @override
  State<MoneyPinPrompt> createState() => _MoneyPinPromptState();
}

class _MoneyPinPromptState extends State<MoneyPinPrompt> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
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

    if (confirmed && context.mounted) {
      await context.read<MoneyPinCubit>().requestReset();
    }
  }

  Widget _buildBody(BuildContext context, MoneyPinState state) {
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
            isSetup
                ? widget.setupTitle ?? S().moneyPinSetupTitle
                : widget.enterTitle ?? S().moneyPinEnterTitle,
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
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyPinCubit, MoneyPinState>(
      isBusy: (state) => state.submitting,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<MoneyPinCubit, MoneyPinState>(builder: _buildBody),
    );
  }
}
