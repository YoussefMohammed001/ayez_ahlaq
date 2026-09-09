import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../shared/widgets/cart_summary_bar.dart';
import '../../../../../generated/l10n.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import '../widgets/store_product_row.dart';

class StoreProductsScreen extends StatefulWidget {
  final int shopId;

  const StoreProductsScreen({super.key, required this.shopId});

  @override
  State<StoreProductsScreen> createState() => _StoreProductsScreenState();
}

class _StoreProductsScreenState extends State<StoreProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StoreCartCubit>().openShop(widget.shopId);
  }

  Future<void> _setQuantity(
    BuildContext context,
    int productId,
    int minOrderQty,
    int quantity,
  ) async {
    final cubit = context.read<StoreCartCubit>();
    final cart = cubit.state.cart;

    if (quantity > 0 && !cart.isEmpty && cart.sellerId != widget.shopId) {
      final confirmed = await showConfirmDialog(
        context,
        title: S().switchShopCartTitle,
        message: S().switchShopCartMessage,
        confirmLabel: S().switchShopCartConfirm,
        icon: Icons.remove_shopping_cart_outlined,
      );

      if (!confirmed) return;
    }

    cubit.setQuantity(productId, minOrderQty, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCartCubit, StoreCartState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null && current.errorMessage != previous.errorMessage,
      listener: (context, state) => showError(state.errorMessage!),
      builder: (context, state) {
        final cubit = context.read<StoreCartCubit>();
        final storefront = state.storefront;

        return Scaffold(
          appBar: AppTopBar(title: storefront?.shopName ?? S().storeTitle),
          body: _buildBody(context, state, cubit),
          bottomNavigationBar: state.isEmpty
              ? null
              : CartSummaryBar(
                  itemCount: state.cart.itemCount,
                  subtotal: state.cart.subtotal,
                  actionLabel: S().viewCart,
                  onPressed: () => context.push(Routes.customerStoreCartScreen),
                ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, StoreCartState state, StoreCartCubit cubit) {
    if (state.status == StoreCartStatus.loading) {
      return const ListSkeleton();
    }

    if (state.status == StoreCartStatus.failure && state.storefront == null) {
      return AppErrorState(
        message: state.errorMessage,
        onRetry: () => cubit.openShop(widget.shopId),
      );
    }

    final products = state.storefront?.products ?? const [];
    if (products.isEmpty) {
      return AppEmptyState(icon: Icons.storefront_outlined, title: S().noProductsYet);
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 12.h),
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];
        final quantity = state.cart.sellerId == widget.shopId
            ? state.quantityFor(product.id)
            : 0;

        return StoreProductRow(
          shopId: widget.shopId,
          product: product,
          quantity: quantity,
          isUpdating: state.isUpdatingCart,
          onQuantityChanged: (q) => _setQuantity(context, product.id, product.minOrderQty, q),
        );
      },
    );
  }
}
