import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_search_field.dart';
import '../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_category.dart';
import '../manager/barber_store_feed_cubit.dart';
import '../manager/barber_store_feed_state.dart';

class StoreFeedFiltersBar extends StatelessWidget {
  final TextEditingController searchController;

  const StoreFeedFiltersBar({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
          child: AppSearchField(
            controller: searchController,
            hintText: S().storeFeedSearchHint,
            onChanged: (value) => context.read<BarberStoreFeedCubit>().search(value),
          ),
        ),
        BlocBuilder<BarberStoreFeedCubit, BarberStoreFeedState>(
          buildWhen: (previous, current) =>
              previous.categories != current.categories ||
              previous.categoryId != current.categoryId,
          builder: (context, state) {
            if (state.categories.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: FilterChipRow<StoreCategory>(
                options: state.categories,
                selected: _selectedCategory(state),
                labelBuilder: (category) => category.name,
                allLabel: S().filterAll,
                onSelected: (category) => context
                    .read<BarberStoreFeedCubit>()
                    .filterByCategory(category?.id),
              ),
            );
          },
        ),
      ],
    );
  }

  StoreCategory? _selectedCategory(BarberStoreFeedState state) {
    if (state.categoryId == null) return null;
    for (final category in state.categories) {
      if (category.id == state.categoryId) return category;
    }
    return null;
  }
}
