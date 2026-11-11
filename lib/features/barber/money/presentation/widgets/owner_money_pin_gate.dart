import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../manager/money_pin_cubit.dart';
import '../manager/money_pin_state.dart';
import 'money_pin_challenge.dart';

class OwnerMoneyPinGate extends StatefulWidget {
  final String title;
  final String? enterTitle;
  final String? setupTitle;
  final Widget child;

  const OwnerMoneyPinGate({
    super.key,
    required this.title,
    required this.child,
    this.enterTitle,
    this.setupTitle,
  });

  @override
  State<OwnerMoneyPinGate> createState() => _OwnerMoneyPinGateState();
}

class _OwnerMoneyPinGateState extends State<OwnerMoneyPinGate> {
  late final MoneyPinCubit _pinCubit;

  @override
  void initState() {
    super.initState();
    _pinCubit = context.read<MoneyPinCubit>()..protectedScreenOpened();
  }

  @override
  void dispose() {
    Future.microtask(_pinCubit.protectedScreenClosed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberProfileCubit, BarberProfileState>(
      buildWhen: (previous, current) =>
          previous.profile?.owner != current.profile?.owner,
      builder: (context, profileState) {
        if (profileState.profile?.isTeamMember ?? false) return widget.child;

        return BlocBuilder<MoneyPinCubit, MoneyPinState>(
          buildWhen: (previous, current) =>
              (previous.stage == MoneyPinStage.unlocked) !=
              (current.stage == MoneyPinStage.unlocked),
          builder: (context, pinState) =>
              pinState.stage == MoneyPinStage.unlocked
              ? widget.child
              : MoneyPinChallenge(
                  title: widget.title,
                  enterTitle: widget.enterTitle,
                  setupTitle: widget.setupTitle,
                ),
        );
      },
    );
  }
}
