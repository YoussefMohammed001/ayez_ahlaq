import 'package:flutter/material.dart';
import '../../../../../shared/widgets/busy_loading_listener.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';

class BarberStoreCartBusyScope extends StatelessWidget {
  final Widget child;

  const BarberStoreCartBusyScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BusyLoadingListener<BarberStoreCartCubit, BarberStoreCartState>(
      isBusy: (state) => state.isUpdatingCart,
      child: child,
    );
  }
}
