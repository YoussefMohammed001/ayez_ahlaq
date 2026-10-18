import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_search_field.dart';
import '../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../generated/l10n.dart';
import '../manager/customer_store_feed_cubit.dart';
import '../manager/customer_store_feed_state.dart';

class CustomerStoreFiltersBar extends StatelessWidget {
  final TextEditingController searchController;

  const CustomerStoreFiltersBar({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 10.h),
          child: AppSearchField(
            controller: searchController,
            hintText: S().storeFeedSearchHint,
            onChanged: (value) => context.read<CustomerStoreFeedCubit>().search(value),
          ),
        ),
        BlocBuilder<CustomerStoreFeedCubit, CustomerStoreFeedState>(
          buildWhen: (previous, current) =>
              previous.categories != current.categories ||
              previous.categoryName != current.categoryName,
          builder: (context, state) {
            if (state.categories.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: FilterChipRow<String>(
                options: state.categories,
                selected: state.categoryName,
                labelBuilder: (name) => name,
                allLabel: S().filterAll,
                onSelected: (name) =>
                    context.read<CustomerStoreFeedCubit>().filterByCategory(name),
              ),
            );
          },
        ),
      ],
    );
  }
}
