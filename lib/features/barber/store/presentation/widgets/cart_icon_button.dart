import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../shared/widgets/count_badge.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStoreCartCubit, BarberStoreCartState>(
      buildWhen: (previous, current) => previous.cart.itemCount != current.cart.itemCount,
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                context.read<BarberStoreCartCubit>().loadCart();
                context.push(Routes.barberStoreCartScreen);
              },
            ),
            if (state.cart.itemCount > 0)
              Positioned(
                top: 4.r,
                right: 4.r,
                child: CountBadge(count: state.cart.itemCount),
              ),
          ],
        );
      },
    );
  }
}
