import 'package:flutter/material.dart';
import '../../../../../shared/widgets/busy_loading_listener.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';

class StoreCartBusyScope extends StatelessWidget {
  final Widget child;

  const StoreCartBusyScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BusyLoadingListener<StoreCartCubit, StoreCartState>(
      isBusy: (state) => state.isUpdatingCart,
      child: child,
    );
  }
}
