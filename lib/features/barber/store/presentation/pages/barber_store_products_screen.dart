import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_merchant.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/store_product_row.dart';

class BarberStoreProductsScreen extends StatefulWidget {
  final StoreMerchant merchant;

  const BarberStoreProductsScreen({super.key, required this.merchant});

  @override
  State<BarberStoreProductsScreen> createState() => _BarberStoreProductsScreenState();
}

class _BarberStoreProductsScreenState extends State<BarberStoreProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BarberStoreCartCubit>().openMerchant(widget.merchant);
  }

  int _quantityFor(BarberStoreCartState state, int productId) {
    final match = state.lines.where((line) => line.product.id == productId);
    return match.isEmpty ? 0 : match.first.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: widget.merchant.businessName),
      body: BlocBuilder<BarberStoreCartCubit, BarberStoreCartState>(
        builder: (context, state) {
          final cubit = context.read<BarberStoreCartCubit>();

          if (state.status == BarberStoreCartStatus.loading) {
            return const ListSkeleton();
          }

          if (state.status == BarberStoreCartStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => cubit.openMerchant(widget.merchant),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 12.h),
                  itemCount: state.products.length,
                  itemBuilder: (_, index) {
                    final product = state.products[index];
                    return StoreProductRow(
                      product: product,
                      quantity: _quantityFor(state, product.id),
                      onQuantityChanged: (quantity) {
                        cubit.setQuantity(product, quantity);
                        cubit.refreshQuote();
                      },
                    );
                  },
                ),
              ),
              if (state.lines.isNotEmpty)
                CartSummaryBar(
                  itemCount: state.itemCount,
                  subtotal: state.subtotal,
                  actionLabel: S().viewCart,
                  onPressed: () => context.push(Routes.barberStoreCartScreen),
                ),
            ],
          );
        },
      ),
    );
  }
}
