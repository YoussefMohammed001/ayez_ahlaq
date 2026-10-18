import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/cart_icon_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/guest/guest_guard.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import '../widgets/store_filters_bar.dart';
import '../widgets/store_products_list.dart';
import 'store_product_details_args.dart';

class StoreProductsScreen extends StatefulWidget {
  final int shopId;

  const StoreProductsScreen({super.key, required this.shopId});

  @override
  State<StoreProductsScreen> createState() => _StoreProductsScreenState();
}

class _StoreProductsScreenState extends State<StoreProductsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<StoreCartCubit>().openShop(widget.shopId);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openProductDetails(int productId) {
    context.push(
      Routes.customerStoreProductDetailsScreen,
      extra: StoreProductDetailsArgs(shopId: widget.shopId, productId: productId),
    );
  }

  Future<void> _setQuantity(
    BuildContext context,
    int productId,
    int minOrderQty,
    int quantity,
  ) async {
    if (!await GuestGuard.ensureLoggedIn(context)) return;
    if (!context.mounted) return;

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
      await cubit.clearCart();
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
          appBar: AppTopBar(
            title: storefront?.shopName ?? S().storeTitle,
            trailing: state.isEmpty
                ? null
                : CartIconButton(
                    itemCount: state.cart.itemCount,
                    onPressed: () => context.push(Routes.customerStoreCartScreen),
                  ),
          ),
          body: Column(
            children: [
              if (storefront != null) StoreFiltersBar(searchController: _searchController),
              Expanded(
                child: StoreProductsList(
                  shopId: widget.shopId,
                  state: state,
                  cubit: cubit,
                  onQuantityChanged: _setQuantity,
                  onOpenProduct: _openProductDetails,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
