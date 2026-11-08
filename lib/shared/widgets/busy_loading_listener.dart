import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/alerts.dart';

class BusyLoadingListener<C extends BlocBase<S>, S> extends StatelessWidget {
  final bool Function(S state) isBusy;
  final Widget child;
  final VoidCallback? onShow;
  final VoidCallback? onHide;

  const BusyLoadingListener({
    super.key,
    required this.isBusy,
    required this.child,
    this.onShow,
    this.onHide,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listenWhen: (previous, current) => isBusy(previous) != isBusy(current),
      listener: (_, state) =>
          isBusy(state) ? (onShow ?? showLoading)() : (onHide ?? hideLoading)(),
      child: child,
    );
  }
}
