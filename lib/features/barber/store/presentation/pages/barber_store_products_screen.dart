import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/cart_icon_button.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_merchant.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';
import '../widgets/store_merchant_detail_card.dart';
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

  Future<void> _setQuantity(
    BuildContext context,
    int productId,
    int minOrderQty,
    int quantity,
  ) async {
    final cubit = context.read<BarberStoreCartCubit>();
    final cart = cubit.state.cart;

    if (quantity > 0 && !cart.isEmpty && cart.sellerId != widget.merchant.id) {
      final confirmed = await showConfirmDialog(
        context,
        title: S().switchShopCartTitle,
        message: S().switchShopCartMessage,
        confirmLabel: S().switchShopCartConfirm,
        icon: Icons.remove_shopping_cart_outlined,
      );

      if (!confirmed) return;
      await cubit.clearCart();
    }

    cubit.setQuantity(productId, minOrderQty, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BarberStoreCartCubit, BarberStoreCartState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null && current.errorMessage != previous.errorMessage,
      listener: (context, state) => showError(state.errorMessage!),
      builder: (context, state) {
        final cubit = context.read<BarberStoreCartCubit>();

        return Scaffold(
          appBar: AppTopBar(
            title: widget.merchant.businessName,
            trailing: state.cart.isEmpty
                ? null
                : CartIconButton(
                    itemCount: state.cart.itemCount,
                    onPressed: () => context.push(Routes.barberStoreCartScreen),
                  ),
          ),
          body: _buildBody(context, state, cubit),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    BarberStoreCartState state,
    BarberStoreCartCubit cubit,
  ) {
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
        StoreMerchantDetailCard(merchant: widget.merchant),
        Expanded(
          child: RefreshableStateView(
            onRefresh: () => cubit.openMerchant(widget.merchant),
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 12.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.products.length,
              itemBuilder: (_, index) {
                final product = state.products[index];
                return StoreProductRow(
                  merchantId: widget.merchant.id,
                  product: product,
                  quantity: state.quantityFor(product.id),
                  isUpdating: state.isUpdatingCart,
                  onQuantityChanged: (quantity) => _setQuantity(
                    context,
                    product.id,
                    product.minOrderQty,
                    quantity,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
