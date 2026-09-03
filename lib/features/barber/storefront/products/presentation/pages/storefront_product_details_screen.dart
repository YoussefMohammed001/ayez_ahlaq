import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../../core/routes/route_paths.dart';
import '../../../../../../core/widgets/app_empty_state.dart';
import '../../../../../../core/widgets/app_top_bar.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_product.dart';
import '../manager/barber_storefront_products_cubit.dart';
import '../manager/barber_storefront_products_state.dart';
import '../widgets/storefront_product_detail_info.dart';
import '../widgets/storefront_product_thumbnail.dart';

class StorefrontProductDetailsScreen extends StatelessWidget {
  final int productId;

  const StorefrontProductDetailsScreen({super.key, required this.productId});

  Future<void> _confirmRemove(BuildContext context) async {
    final cubit = context.read<BarberStorefrontProductsCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteProduct,
      message: S().deleteStorefrontProductConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (!confirmed || !context.mounted) return;

    await cubit.removeProduct(productId);

    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStorefrontProductsCubit, BarberStorefrontProductsState>(
      builder: (context, state) {
        final product = _find(state.products);

        if (product == null) {
          return Scaffold(
            appBar: AppTopBar(title: S().productDetails),
            body: AppEmptyState(
              icon: Icons.inventory_2_outlined,
              title: S().noProductsYet,
            ),
          );
        }

        return Scaffold(
          appBar: AppTopBar(
            title: S().productDetails,
            trailing: IconButton(
              icon: Icon(Icons.delete_outline, color: context.semantic.warning),
              onPressed: () => _confirmRemove(context),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
            children: [
              Center(child: StorefrontProductThumbnail(size: 220.h, radius: 18.r)),
              SizedBox(height: 18.h),
              StorefrontProductDetailInfo(product: product),
              SizedBox(height: 24.h),
              PrimaryCtaButton(
                label: S().editProduct,
                onPressed: () => context.push(
                  Routes.barberStorefrontProductFormScreen,
                  extra: product,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  StorefrontProduct? _find(List<StorefrontProduct> products) {
    for (final product in products) {
      if (product.id == productId) return product;
    }

    return null;
  }
}
