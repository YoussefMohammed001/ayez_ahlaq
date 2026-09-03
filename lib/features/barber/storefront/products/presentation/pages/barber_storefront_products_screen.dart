import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routes/route_paths.dart';
import '../../../../../../core/theme/styles.dart';
import '../../../../../../core/widgets/app_empty_state.dart';
import '../../../../../../core/widgets/app_error_state.dart';
import '../../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../../core/widgets/list_skeleton.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_product.dart';
import '../manager/barber_storefront_products_cubit.dart';
import '../manager/barber_storefront_products_state.dart';
import '../widgets/storefront_product_category_filter.dart';
import '../widgets/storefront_product_row.dart';
import '../widgets/storefront_products_header.dart';

class BarberStorefrontProductsScreen extends StatelessWidget {
  const BarberStorefrontProductsScreen({super.key});

  Future<void> _confirmRemove(BuildContext context, int id) async {
    final cubit = context.read<BarberStorefrontProductsCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteProduct,
      message: S().deleteStorefrontProductConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await cubit.removeProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StorefrontProductsHeader(),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 10.h),
            child: Text(
              S().storefrontProductsNote,
              style: font12w400.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          5.hSpace,
          const StorefrontProductCategoryFilter(),
          10.hSpace,
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<BarberStorefrontProductsCubit, BarberStorefrontProductsState>(
      builder: (context, state) {
        final cubit = context.read<BarberStorefrontProductsCubit>();

        if (state.status == StorefrontProductsStatus.loading) {
          return const ListSkeleton();
        }

        if (state.status == StorefrontProductsStatus.failure &&
            state.products.isEmpty) {
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
              message: S().storefrontProductsNote,
              actionLabel: S().addStorefrontProduct,
              onAction: () =>
                  context.push(Routes.barberStorefrontProductFormScreen),
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

  Widget _buildList(BuildContext context, List<StorefrontProduct> products) {
    if (products.isEmpty) {
      return AppEmptyState(
        icon: Icons.filter_alt_off_outlined,
        title: S().noProductsYet,
        message: S().storefrontProductsNote,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];
        return StorefrontProductRow(
          product: product,
          onTap: () => context.push(
            Routes.barberStorefrontProductDetailsScreen,
            extra: product.id,
          ),
          onRemove: () => _confirmRemove(context, product.id),
        );
      },
    );
  }
}
