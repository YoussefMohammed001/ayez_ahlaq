import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/grid_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import 'store_product_card.dart';

class StoreProductsList extends StatelessWidget {
  final int shopId;
  final StoreCartState state;
  final StoreCartCubit cubit;
  final void Function(BuildContext, int productId, int minOrderQty, int quantity) onQuantityChanged;
  final ValueChanged<int> onOpenProduct;

  const StoreProductsList({
    super.key,
    required this.shopId,
    required this.state,
    required this.cubit,
    required this.onQuantityChanged,
    required this.onOpenProduct,
  });

  @override
  Widget build(BuildContext context) {
    if (state.status == StoreCartStatus.loading) {
      return const GridSkeleton(childAspectRatio: 0.66);
    }

    if (state.status == StoreCartStatus.failure && state.storefront == null) {
      return AppErrorState(
        message: state.errorMessage,
        onRetry: () => cubit.openShop(shopId),
      );
    }

    if ((state.storefront?.products ?? const []).isEmpty) {
      return AppEmptyState(icon: Icons.storefront_outlined, title: S().noProductsYet);
    }

    final products = state.filteredProducts;
    if (products.isEmpty) {
      return AppEmptyState(icon: Icons.search_off_rounded, title: S().noStoreProductsYet);
    }

    return RefreshableStateView(
      onRefresh: () => cubit.openShop(shopId),
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.66,
        ),
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          final quantity = state.cart.sellerId == shopId ? state.quantityFor(product.id) : 0;

          return StoreProductCard(
            shopId: shopId,
            product: product,
            quantity: quantity,
            isUpdating: state.isUpdatingCart,
            onQuantityChanged: (q) =>
                onQuantityChanged(context, product.id, product.minOrderQty, q),
            onTap: () => onOpenProduct(product.id),
          );
        },
      ),
    );
  }
}
