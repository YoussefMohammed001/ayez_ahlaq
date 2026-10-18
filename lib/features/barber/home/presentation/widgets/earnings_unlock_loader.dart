import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../money/presentation/manager/money_pin_cubit.dart';
import '../../../money/presentation/manager/money_pin_state.dart';
import '../../../team/presentation/manager/earnings_cubit.dart';

class EarningsUnlockLoader extends StatelessWidget {
  const EarningsUnlockLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoneyPinCubit, MoneyPinState>(
      listenWhen: (previous, current) =>
          previous.stage != MoneyPinStage.unlocked &&
          current.stage == MoneyPinStage.unlocked,
      listener: (context, _) => context.read<EarningsCubit>().loadEarnings(),
      child: const SizedBox.shrink(),
    );
  }
}
