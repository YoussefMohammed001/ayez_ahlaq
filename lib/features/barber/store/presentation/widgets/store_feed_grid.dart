import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/filter_loading_bar.dart';
import '../../../../../core/widgets/grid_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_feed_product.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';
import '../manager/barber_store_feed_cubit.dart';
import '../manager/barber_store_feed_state.dart';
import 'store_feed_product_card.dart';

class StoreFeedGrid extends StatelessWidget {
  final ScrollController scrollController;
  final ValueChanged<StoreFeedProduct> onOpenProduct;
  final ValueChanged<int> onOpenMerchant;
  final void Function(StoreFeedProduct product, int quantity) onQuantityChanged;

  const StoreFeedGrid({
    super.key,
    required this.scrollController,
    required this.onOpenProduct,
    required this.onOpenMerchant,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStoreFeedCubit, BarberStoreFeedState>(
      builder: (context, state) {
        if (state.products.isEmpty) {
          if (state.status == BarberStoreFeedStatus.loading) {
            return const GridSkeleton(childAspectRatio: 0.54);
          }

          if (state.status == BarberStoreFeedStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => context.read<BarberStoreFeedCubit>().load(force: true),
            );
          }

          return AppEmptyState(
            icon: Icons.inventory_2_outlined,
            title: S().noStoreProductsYet,
            message: S().noStoreProductsYetHint,
          );
        }

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () => context.read<BarberStoreFeedCubit>().load(force: true),
              child: GridView.builder(
                controller: scrollController,
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.54,
                ),
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  final product = state.products[index];
                  return BlocBuilder<BarberStoreCartCubit, BarberStoreCartState>(
                    buildWhen: (previous, current) =>
                        previous.cart != current.cart ||
                        previous.isUpdatingCart != current.isUpdatingCart,
                    builder: (context, cartState) {
                      return StoreFeedProductCard(
                        product: product,
                        quantity: cartState.quantityFor(product.id),
                        isUpdating: cartState.isUpdatingCart,
                        onTap: () => onOpenProduct(product),
                        onMerchantTap: () => onOpenMerchant(product.merchantId),
                        onQuantityChanged: (quantity) => onQuantityChanged(product, quantity),
                      );
                    },
                  );
                },
              ),
            ),
            if (state.status == BarberStoreFeedStatus.loading) const FilterLoadingBar(),
            if (state.status == BarberStoreFeedStatus.loadingMore)
              const PositionedDirectional(
                bottom: 12,
                start: 0,
                end: 0,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
          ],
        );
      },
    );
  }
}
