import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_search_field.dart';
import '../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_category.dart';
import '../manager/store_cart_cubit.dart';
import '../manager/store_cart_state.dart';

class StoreFiltersBar extends StatelessWidget {
  final TextEditingController searchController;

  const StoreFiltersBar({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
          child: AppSearchField(
            controller: searchController,
            hintText: S().storeFeedSearchHint,
            onChanged: (value) => context.read<StoreCartCubit>().search(value),
          ),
        ),
        BlocBuilder<StoreCartCubit, StoreCartState>(
          buildWhen: (previous, current) =>
              previous.storefront?.categories != current.storefront?.categories ||
              previous.categoryId != current.categoryId,
          builder: (context, state) {
            final categories = state.storefront?.categories ?? const [];
            if (categories.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: FilterChipRow<StoreCategory>(
                options: categories,
                selected: _selectedCategory(categories, state.categoryId),
                labelBuilder: (category) => category.name,
                allLabel: S().filterAll,
                onSelected: (category) =>
                    context.read<StoreCartCubit>().filterByCategory(category?.id),
              ),
            );
          },
        ),
      ],
    );
  }

  StoreCategory? _selectedCategory(List<StoreCategory> categories, int? id) {
    if (id == null) return null;
    for (final category in categories) {
      if (category.id == id) return category;
    }
    return null;
  }
}
