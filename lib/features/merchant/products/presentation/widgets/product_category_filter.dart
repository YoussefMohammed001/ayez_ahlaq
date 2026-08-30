import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/filter_chip_row.dart';
import '../../../categories/domain/entities/merchant_category.dart';
import '../../../categories/presentation/manager/merchant_categories_cubit.dart';
import '../../../categories/presentation/manager/merchant_categories_state.dart';
import '../manager/merchant_products_cubit.dart';
import '../manager/merchant_products_state.dart';
import '../../../../../generated/l10n.dart';

class ProductCategoryFilter extends StatelessWidget {
  const ProductCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
      builder: (context, productsState) {
        return BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
          builder: (context, categoriesState) {
            final used = productsState.usedCategoryIds;
            final options = categoriesState.assignable
                .where((c) => used.contains(c.id))
                .toList();

            if (options.isEmpty) return const SizedBox.shrink();

            return FilterChipRow<MerchantCategory>(
              options: options,
              selected: _selected(options, productsState.categoryFilter),
              labelBuilder: (category) => category.name,
              allLabel: S().filterAll,
              onSelected: (category) => context
                  .read<MerchantProductsCubit>()
                  .filterByCategory(category?.id),
            );
          },
        );
      },
    );
  }

  MerchantCategory? _selected(List<MerchantCategory> options, int? id) {
    if (id == null) return null;

    for (final category in options) {
      if (category.id == id) return category;
    }

    return null;
  }
}
