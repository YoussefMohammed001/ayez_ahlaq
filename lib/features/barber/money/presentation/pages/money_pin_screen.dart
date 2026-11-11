import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../manager/money_pin_cubit.dart';
import '../manager/money_pin_state.dart';
import '../widgets/money_pin_prompt.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: widget.title ?? S().moneyManagerTitle),
      body: BlocListener<MoneyPinCubit, MoneyPinState>(
        listenWhen: (previous, current) =>
            current.stage == MoneyPinStage.unlocked,
        listener: (context, state) =>
            context.pushReplacement(widget.redirectRoute),
        child: const MoneyPinPrompt(),
      ),
    );
  }
}
