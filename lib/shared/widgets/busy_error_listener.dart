import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/alerts.dart';

class BusyErrorListener<C extends BlocBase<S>, S> extends StatelessWidget {
  final bool Function(S state) isBusy;
  final String? Function(S state) errorMessage;
  final Widget child;

  const BusyErrorListener({
    super.key,
    required this.isBusy,
    required this.errorMessage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listenWhen: (previous, current) =>
          isBusy(previous) != isBusy(current) ||
          (errorMessage(current) != null &&
              errorMessage(current) != errorMessage(previous)),
      listener: (context, state) {
        if (isBusy(state)) {
          showLoading();
        } else {
          hideLoading();
        }
        final message = errorMessage(state);
        if (message != null && !isBusy(state)) showError(message);
      },
      child: child,
    );
  }
}
