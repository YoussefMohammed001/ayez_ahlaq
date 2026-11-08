import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/confirm_switch_cart.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/cart_icon_button.dart';
import '../../../../../core/widgets/discount_percent_badge.dart';
import '../../../../../core/widgets/network_image_with_app_icon_fallback.dart';
import '../../../../../core/widgets/store_entity_chip.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/guest/guest_guard.dart';
import '../../domain/entities/store_product.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';
import 'store_product_details_args.dart';

class StoreProductDetailsScreen extends StatelessWidget {
  final StoreProductDetailsArgs args;

  const StoreProductDetailsScreen({super.key, required this.args});

  StoreProduct? _find(List<StoreProduct> products) {
    for (final product in products) {
      if (product.id == args.productId) return product;
    }
    return null;
  }

  Future<void> _setQuantity(
    BuildContext context,
    StoreProduct product,
    int quantity,
  ) async {
    if (!await GuestGuard.ensureLoggedIn(context)) return;
    if (!context.mounted) return;

    final cubit = context.read<StoreCartCubit>();
    final cart = cubit.state.cart;

    if (quantity > 0 && !cart.isEmpty && cart.sellerId != args.shopId) {
      if (!await confirmSwitchCart(context)) return;
      await cubit.clearCart();
    }

    cubit.setQuantity(product.id, product.minOrderQty, quantity);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BlocBuilder<StoreCartCubit, StoreCartState>(
      builder: (context, state) {
        final product = _find(state.storefront?.products ?? const []);

        if (product == null) {
          return Scaffold(appBar: AppTopBar(title: S().productDetails));
        }

        final quantity =
            state.cart.sellerId == args.shopId ? state.quantityFor(product.id) : 0;

        return Scaffold(
          appBar: AppTopBar(
            title: S().productDetails,
            trailing: state.isEmpty
                ? null
                : CartIconButton(
                    itemCount: state.cart.itemCount,
                    onPressed: () => context.push(Routes.customerStoreCartScreen),
                  ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
            children: [
              NetworkImageWithAppIconFallback(
                endPoint: EndPoints.customerShopStorefrontProductImage(args.shopId, product.id),
                hasImage: product.hasImage,
                width: double.infinity,
                height: 220.h,
                borderRadius: BorderRadius.circular(18.r),
              ),
              SizedBox(height: 14.h),
              StoreEntityChip(name: state.storefront?.shopName ?? ''),
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
              if (product.isOutOfStock)
                Text(
                  S().outOfStock,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: context.semantic.warning),
                )
              else
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
              if (!product.isOutOfStock) ...[
                SizedBox(height: 24.h),
                QuantityStepper(
                  quantity: quantity,
                  minQuantity: product.minOrderQty,
                  disabled: state.isUpdatingCart,
                  onChanged: (q) => _setQuantity(context, product, q),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
