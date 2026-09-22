import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/otp_code_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/money_pin_cubit.dart';
import '../manager/money_pin_state.dart';

class ChangeMoneyPinScreen extends StatefulWidget {
  const ChangeMoneyPinScreen({super.key});

  @override
  State<ChangeMoneyPinScreen> createState() => _ChangeMoneyPinScreenState();
}

class _ChangeMoneyPinScreenState extends State<ChangeMoneyPinScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_currentController.text.length != 4 ||
        _newController.text.length != 4) {
      return;
    }

    if (_newController.text != _confirmController.text) {
      showError(S().moneyPinNotMatch);
      return;
    }

    final cubit = context.read<MoneyPinCubit>();
    final changed = await cubit.change(
      currentPin: _currentController.text,
      newPin: _newController.text,
    );

    if (!mounted) return;

    if (changed) {
      showSuccess(S().moneyPinChanged);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyPinCubit, MoneyPinState>(
      isBusy: (state) => state.submitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().changeMoneyPinTitle),
        body: BlocBuilder<MoneyPinCubit, MoneyPinState>(
          builder: (context, state) => ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              SectionTitle(title: S().currentMoneyPinLabel),
              OtpCodeField(controller: _currentController, length: 4),
              SectionTitle(title: S().newMoneyPinLabel),
              OtpCodeField(controller: _newController, length: 4),
              SectionTitle(title: S().confirmMoneyPinLabel),
              OtpCodeField(controller: _confirmController, length: 4),
              SizedBox(height: 20.h),
              PrimaryCtaButton(
                label: S().changeMoneyPinAction,
                isLoading: state.submitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
