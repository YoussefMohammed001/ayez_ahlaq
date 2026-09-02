import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../products/domain/entities/product_insights.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_state.dart';
import 'dashboard_attention_row.dart';
import 'dashboard_documents_alert.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DashboardAttentionSection extends StatelessWidget {
  final VoidCallback onGoToOrders;
  final VoidCallback onGoToProducts;

  const DashboardAttentionSection({
    super.key,
    required this.onGoToOrders,
    required this.onGoToProducts,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, productsState) {
        return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
          builder: (context, ordersState) {
            final products = productsState.products;
            final rows = _buildRows(
              context,
              pending: ordersState.pendingOrders.length,
              outOfStock: products.outOfStock.length,
              inactive: products.inactive.length,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: S().needsAttention),
                DashboardDocumentsAlert(showAllClear: rows.isEmpty),
                ...rows,
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildRows(
    BuildContext context, {
    required int pending,
    required int outOfStock,
    required int inactive,
  }) {
    return [
      if (pending > 0)
        DashboardAttentionRow(
          icon: Icons.pending_actions_rounded,
          color: context.semantic.warning,
          label: S().pendingOrders,
          value: '$pending',
          onTap: onGoToOrders,
        ),
      if (outOfStock > 0)
        DashboardAttentionRow(
          icon: Icons.inventory_rounded,
          color: context.colorScheme.error,
          label: S().outOfStockProducts,
          value: '$outOfStock',
          onTap: onGoToProducts,
        ),
      if (inactive > 0)
        DashboardAttentionRow(
          icon: Icons.pause_circle_outline_rounded,
          color: context.colorScheme.onSurfaceVariant,
          label: S().inactiveProducts,
          value: '$inactive',
          onTap: onGoToProducts,
        ),
    ];
  }
}
