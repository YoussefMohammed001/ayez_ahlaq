import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../../products/presentation/manager/merchant_products_state.dart';
import '../manager/new_sale_cubit.dart';
import '../manager/new_sale_state.dart';
import 'sale_product_row.dart';

class SaleProductsSection extends StatelessWidget {
  const SaleProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().saleProductsTitle),
        BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
          builder: (context, productsState) {
            final sellable = productsState.products
                .where((p) => p.active && p.totalStock > 0)
                .toList();

            if (sellable.isEmpty) {
              return AppEmptyState(
                compact: true,
                icon: Icons.inventory_2_outlined,
                title: S().saleNoProductsToSell,
              );
            }

            return BlocBuilder<NewSaleCubit, NewSaleState>(
              buildWhen: (previous, current) =>
                  previous.quantities != current.quantities,
              builder: (context, saleState) => Column(
                children: [
                  for (final product in sellable)
                    SaleProductRow(
                      product: product,
                      quantity: saleState.quantityOf(product.id),
                      onChanged: (quantity) => context
                          .read<NewSaleCubit>()
                          .setQuantity(product.id, quantity),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
