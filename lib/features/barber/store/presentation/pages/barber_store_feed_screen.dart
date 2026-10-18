import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_feed_product.dart';
import '../../domain/entities/store_merchant.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_feed_cubit.dart';
import '../manager/barber_store_merchants_cubit.dart';
import '../widgets/store_feed_filters_bar.dart';
import '../widgets/store_feed_grid.dart';
import 'store_feed_product_details_args.dart';

class BarberStoreFeedScreen extends StatefulWidget {
  const BarberStoreFeedScreen({super.key});

  @override
  State<BarberStoreFeedScreen> createState() => _BarberStoreFeedScreenState();
}

class _BarberStoreFeedScreenState extends State<BarberStoreFeedScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BarberStoreFeedCubit>().load();
    context.read<BarberStoreMerchantsCubit>().loadMerchants();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      context.read<BarberStoreFeedCubit>().loadMore();
    }
  }

  StoreMerchant? _findMerchant(int merchantId) {
    final merchants = context.read<BarberStoreMerchantsCubit>().state.merchants;
    for (final merchant in merchants) {
      if (merchant.id == merchantId) return merchant;
    }
    return null;
  }

  void _openMerchant(int merchantId) {
    final merchant = _findMerchant(merchantId);
    if (merchant == null) return;
    context.push(Routes.barberStoreProductsScreen, extra: merchant);
  }

  void _openProduct(StoreFeedProduct product) {
    context.push(
      Routes.barberStoreFeedProductDetailsScreen,
      extra: StoreFeedProductDetailsArgs(
        product: product,
        merchant: _findMerchant(product.merchantId),
      ),
    );
  }

  Future<void> _setQuantity(StoreFeedProduct product, int quantity) async {
    final cubit = context.read<BarberStoreCartCubit>();
    final cart = cubit.state.cart;

    if (quantity > 0 && !cart.isEmpty && cart.sellerId != product.merchantId) {
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

    cubit.setQuantity(product.id, product.minOrderQty, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StoreFeedFiltersBar(searchController: _searchController),
          Expanded(
            child: StoreFeedGrid(
              scrollController: _scrollController,
              onOpenProduct: _openProduct,
              onOpenMerchant: _openMerchant,
              onQuantityChanged: _setQuantity,
            ),
          ),
        ],
      ),
    );
  }
}
