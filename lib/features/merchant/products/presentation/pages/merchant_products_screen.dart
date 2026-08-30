import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../manager/merchant_products_cubit.dart';
import '../manager/merchant_products_state.dart';
import '../widgets/product_row.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantProductsScreen extends StatelessWidget {
  const MerchantProductsScreen({super.key});

  Future<void> _confirmRemove(BuildContext context, int id) async {
    final cubit = context.read<MerchantProductsCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteProduct,
      message: S().deleteProductConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await cubit.removeProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 10.h),
              child: Text(
                S().productsNote,
                style: font12w400.copyWith(color: context.colorScheme.onSurfaceVariant),
              ),
            ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S().tabProducts, style: HeadingStyles.h2),
          InkWell(
            onTap: () => context.push(Routes.merchantProductFormScreen),
            child: Container(
              width: 36.r,
              height: 36.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.add,
                color: context.colorScheme.surfaceContainerLowest,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        if (state.status == ProductsStatus.loading) {
          return const ListSkeleton();
        }

        if (state.status == ProductsStatus.failure && state.products.isEmpty) {
          return RefreshableStateView(
            onRefresh: context.read<MerchantProductsCubit>().loadProducts,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<MerchantProductsCubit>().loadProducts,
            ),
          );
        }

        if (state.products.isEmpty) {
          return RefreshableStateView(
            onRefresh: context.read<MerchantProductsCubit>().loadProducts,
            child: AppEmptyState(
              icon: Icons.inventory_2_outlined,
              title: S().noProductsYet,
              message: S().productsNote,
              actionLabel: S().addWholesaleProduct,
              onAction: () => context.push(Routes.merchantProductFormScreen),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: context.read<MerchantProductsCubit>().loadProducts,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            itemCount: state.products.length,
            itemBuilder: (_, index) {
              final product = state.products[index];
              return ProductRow(
                product: product,
                onTap: () => context.push(
                  Routes.merchantProductFormScreen,
                  extra: product,
                ),
                onToggle: () => context
                    .read<MerchantProductsCubit>()
                    .toggleProductActive(product),
                onRemove: () => _confirmRemove(context, product.id),
              );
            },
          ),
        );
      },
    );
  }
}
