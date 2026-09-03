import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../../generated/l10n.dart';
import '../../../categories/domain/entities/storefront_category.dart';
import '../../../categories/presentation/manager/barber_storefront_categories_cubit.dart';
import '../../../categories/presentation/manager/barber_storefront_categories_state.dart';
import '../manager/barber_storefront_products_cubit.dart';
import '../manager/barber_storefront_products_state.dart';

class StorefrontProductCategoryFilter extends StatelessWidget {
  const StorefrontProductCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStorefrontProductsCubit, BarberStorefrontProductsState>(
      builder: (context, productsState) {
        return BlocBuilder<
          BarberStorefrontCategoriesCubit,
          BarberStorefrontCategoriesState
        >(
          builder: (context, categoriesState) {
            final used = productsState.usedCategoryIds;
            final options = categoriesState.assignable
                .where((c) => used.contains(c.id))
                .toList();

            if (options.isEmpty) return const SizedBox.shrink();

            return FilterChipRow<StorefrontCategory>(
              options: options,
              selected: _selected(options, productsState.categoryFilter),
              labelBuilder: (category) => category.name,
              allLabel: S().filterAll,
              onSelected: (category) => context
                  .read<BarberStorefrontProductsCubit>()
                  .filterByCategory(category?.id),
            );
          },
        );
      },
    );
  }

  StorefrontCategory? _selected(List<StorefrontCategory> options, int? id) {
    if (id == null) return null;

    for (final category in options) {
      if (category.id == id) return category;
    }

    return null;
  }
}
