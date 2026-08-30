import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../domain/entities/merchant_product.dart';
import '../manager/merchant_products_cubit.dart';
import '../manager/merchant_products_state.dart';
import '../widgets/product_category_filter.dart';
import '../widgets/product_row.dart';
import '../widgets/products_header.dart';
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
            const ProductsHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 10.h),
              child: Text(
                S().productsNote,
                style: font12w400.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            5.hSpace,
            const ProductCategoryFilter(),
            10.hSpace,
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        final cubit = context.read<MerchantProductsCubit>();

        if (state.status == ProductsStatus.loading) {
          return const ListSkeleton();
        }

        if (state.status == ProductsStatus.failure && state.products.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadProducts,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadProducts,
            ),
          );
        }

        if (state.products.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadProducts,
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
          onRefresh: cubit.loadProducts,
          child: _buildList(context, state.visibleProducts),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<MerchantProduct> products) {
    if (products.isEmpty) {
      return AppEmptyState(
        icon: Icons.filter_alt_off_outlined,
        title: S().noProductsYet,
        message: S().productsNote,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];
        return ProductRow(
          product: product,
          onTap: () => context.push(
            Routes.merchantProductDetailsScreen,
            extra: product.id,
          ),
          onRemove: () => _confirmRemove(context, product.id),
        );
      },
    );
  }
}
