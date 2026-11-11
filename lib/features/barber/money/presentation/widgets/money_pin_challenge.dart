import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../manager/money_pin_cubit.dart';
import 'money_pin_prompt.dart';

class MoneyPinChallenge extends StatefulWidget {
  final String title;
  final String? enterTitle;
  final String? setupTitle;

  const MoneyPinChallenge({
    super.key,
    required this.title,
    this.enterTitle,
    this.setupTitle,
  });

  @override
  State<MoneyPinChallenge> createState() => _MoneyPinChallengeState();
}

class _MoneyPinChallengeState extends State<MoneyPinChallenge> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<MoneyPinCubit>();
    cubit.checkStatus();
    cubit.checkResetStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: widget.title),
      body: MoneyPinPrompt(
        enterTitle: widget.enterTitle,
        setupTitle: widget.setupTitle,
      ),
    );
  }
}
