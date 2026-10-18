import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/cart_icon_button.dart';
import '../../../../../core/widgets/network_image_with_app_icon_fallback.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/store_entity_chip.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/guest/guest_guard.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import '../widgets/store_product_price_row.dart';
import 'store_feed_product_details_args.dart';

class StoreFeedProductDetailsScreen extends StatefulWidget {
  final StoreFeedProductDetailsArgs args;

  const StoreFeedProductDetailsScreen({super.key, required this.args});

  @override
  State<StoreFeedProductDetailsScreen> createState() =>
      _StoreFeedProductDetailsScreenState();
}

class _StoreFeedProductDetailsScreenState
    extends State<StoreFeedProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StoreCartCubit>().openShop(widget.args.item.shopId);
  }

  Future<void> _setQuantity(int quantity) async {
    if (!await GuestGuard.ensureLoggedIn(context)) return;
    if (!mounted) return;

    final item = widget.args.item;
    final cubit = context.read<StoreCartCubit>();
    final cart = cubit.state.cart;

    if (quantity > 0 && !cart.isEmpty && cart.sellerId != item.shopId) {
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

    cubit.setQuantity(item.product.id, item.product.minOrderQty, quantity);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final item = widget.args.item;
    final product = item.product;

    return BlocBuilder<StoreCartCubit, StoreCartState>(
      buildWhen: (previous, current) => previous.cart != current.cart,
      builder: (context, cartState) {
        return Scaffold(
          appBar: AppTopBar(
            title: S().productDetails,
            trailing: cartState.isEmpty
                ? null
                : CartIconButton(
                    itemCount: cartState.cart.itemCount,
                    onPressed: () => context.push(Routes.customerStoreCartScreen),
                  ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
            children: [
              NetworkImageWithAppIconFallback(
                endPoint: EndPoints.customerShopStorefrontProductImage(item.shopId, product.id),
                hasImage: product.hasImage,
                width: double.infinity,
                height: 220.h,
                borderRadius: BorderRadius.circular(18.r),
              ),
              SizedBox(height: 14.h),
              StoreEntityChip(
                name: item.shopName,
                onTap: () => context.push(Routes.customerShopDetailScreen, extra: item.shopId),
              ),
              SizedBox(height: 10.h),
              Text(
                product.name,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: scheme.onSurface),
              ),
              if ((product.brand ?? '').isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(product.brand!, style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant)),
              ],
              SizedBox(height: 10.h),
              StoreProductPriceRow(product: product),
              if (product.minOrderQty > 1) ...[
                SizedBox(height: 8.h),
                Text(
                  '${S().minOrderQty}: ${product.minOrderQty}',
                  style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
              if (!product.isOutOfStock) ...[
                SizedBox(height: 24.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: QuantityStepper(
                    quantity: cartState.cart.sellerId == item.shopId
                        ? cartState.quantityFor(product.id)
                        : 0,
                    minQuantity: product.minOrderQty,
                    disabled: cartState.isUpdatingCart,
                    onChanged: _setQuantity,
                  ),
                ),
              ],
              SizedBox(height: 18.h),
              PrimaryCtaButton(
                label: S().viewShopProfile(item.shopName),
                onPressed: () =>
                    context.push(Routes.customerShopDetailScreen, extra: item.shopId),
              ),
            ],
          ),
        );
      },
    );
  }
}
