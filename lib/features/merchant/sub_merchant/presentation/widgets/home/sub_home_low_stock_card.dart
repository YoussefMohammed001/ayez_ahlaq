import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routes/route_paths.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../products/domain/entities/merchant_product.dart';
import '../../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../../products/presentation/manager/merchant_products_state.dart';
import '../../helpers/sub_home_summary.dart';
import 'sub_home_card.dart';
import 'sub_home_value_text.dart';

class SubHomeLowStockCard extends StatelessWidget {
  static const _shown = 3;

  final VoidCallback onTap;

  const SubHomeLowStockCard({super.key, required this.onTap});

  String _line(MerchantProduct product) => product.isOutOfStock
      ? S().subHomeLowStockOut(product.name)
      : S().subHomeLowStockLine(product.name, '${product.totalStock}');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, state) {
        final low = SubHomeSummary.lowStockOf(state.products);
        if (low.isEmpty) return const SizedBox.shrink();

        return SubHomeCard(
          icon: Icons.inventory_2_outlined,
          title: S().subHomeLowStockTitle,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final product in low.take(_shown))
                InkWell(
                  onTap: () => context.push(
                    Routes.merchantProductDetailsScreen,
                    extra: product.id,
                  ),
                  child: SubHomeValueText(_line(product)),
                ),
            ],
          ),
        );
      },
    );
  }
}
