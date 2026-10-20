import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/discount_percent_badge.dart';
import '../../../../../core/widgets/network_image_with_app_icon_fallback.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/store_entity_chip.dart';
import '../manager/barber_store_cart_cubit.dart';
import '../manager/barber_store_cart_state.dart';
import 'store_feed_product_details_args.dart';

class StoreFeedProductDetailsScreen extends StatelessWidget {
  final StoreFeedProductDetailsArgs args;

  const StoreFeedProductDetailsScreen({super.key, required this.args});

  Future<void> _setQuantity(BuildContext context, int quantity) async {
    final product = args.product;
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
    final scheme = context.colorScheme;
    final product = args.product;
    final merchant = args.merchant;

    return Scaffold(
      appBar: AppTopBar(title: S().productDetails),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        children: [
          NetworkImageWithAppIconFallback(
            endPoint: EndPoints.barberStoreProductImage(product.id),
            hasImage: product.hasImage,
            width: double.infinity,
            height: 220.h,
            borderRadius: BorderRadius.circular(18.r),
          ),
          SizedBox(height: 14.h),
          StoreEntityChip(
            name: product.merchantName,
            onTap: merchant == null
                ? null
                : () => context.push(Routes.barberStoreProductsScreen, extra: merchant),
          ),
          SizedBox(height: 10.h),
          Text(
            product.name,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: scheme.onSurface),
          ),
          if (product.brand != null && product.brand!.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              product.brand!,
              style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant),
            ),
          ],
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                S().currencyEgp(product.effectivePrice),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800, color: context.semantic.accentSoft),
              ),
              if (product.isDiscounted) ...[
                SizedBox(width: 8.w),
                Text(
                  S().currencyEgp(product.price),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: scheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 8.w),
                DiscountPercentBadge(percent: product.discountPercent),
              ],
            ],
          ),
          if (product.minOrderQty > 1) ...[
            SizedBox(height: 8.h),
            Text(
              '${S().minOrderQty}: ${product.minOrderQty}',
              style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurfaceVariant),
            ),
          ],
          SizedBox(height: 24.h),
          BlocBuilder<BarberStoreCartCubit, BarberStoreCartState>(
            buildWhen: (previous, current) =>
                previous.cart != current.cart ||
                previous.isUpdatingCart != current.isUpdatingCart,
            builder: (context, cartState) {
              return Align(
                alignment: AlignmentDirectional.centerStart,
                child: QuantityStepper(
                  quantity: cartState.quantityFor(product.id),
                  minQuantity: product.minOrderQty,
                  disabled: cartState.isUpdatingCart,
                  onChanged: (quantity) => _setQuantity(context, quantity),
                ),
              );
            },
          ),
          SizedBox(height: 18.h),
          PrimaryCtaButton(
            label: S().viewMerchantStore(product.merchantName),
            onPressed: merchant == null
                ? null
                : () => context.push(Routes.barberStoreProductsScreen, extra: merchant),
          ),
        ],
      ),
    );
  }
}
