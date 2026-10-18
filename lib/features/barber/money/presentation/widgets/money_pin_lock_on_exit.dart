import 'package:flutter/material.dart';
import '../manager/money_pin_cubit.dart';

class MoneyPinLockOnExit extends StatefulWidget {
  final MoneyPinCubit pinCubit;
  final Widget child;

  const MoneyPinLockOnExit({super.key, required this.pinCubit, required this.child});

  @override
  State<MoneyPinLockOnExit> createState() => _MoneyPinLockOnExitState();
}

class _MoneyPinLockOnExitState extends State<MoneyPinLockOnExit> {
  late final MoneyPinCubit _pinCubit = widget.pinCubit;

  @override
  void dispose() {
    Future.microtask(_pinCubit.lock);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
