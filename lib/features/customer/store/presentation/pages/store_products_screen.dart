import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCartCubit, StoreCartState>(
      builder: (context, state) {
        final cubit = context.read<StoreCartCubit>();
        final storefront = state.storefront;

        return Scaffold(
          appBar: AppTopBar(title: storefront?.shopName ?? S().storeTitle),
          body: _buildBody(context, state, cubit),
          bottomNavigationBar: state.isEmpty
              ? null
              : CartSummaryBar(
                  itemCount: state.itemCount,
                  subtotal: state.subtotal,
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
        return StoreProductRow(
          shopId: widget.shopId,
          product: product,
          quantity: state.quantityFor(product.id),
          onQuantityChanged: (quantity) => cubit.setQuantity(product.id, quantity),
        );
      },
    );
  }
}
