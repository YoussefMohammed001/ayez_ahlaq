import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/filter_loading_bar.dart';
import '../../../../../core/widgets/grid_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_feed_product.dart';
import '../manager/customer_store_feed_cubit.dart';
import '../manager/customer_store_feed_state.dart';
import 'customer_store_feed_card.dart';

class CustomerStoreFeedGrid extends StatelessWidget {
  final ValueChanged<StoreFeedProduct> onOpenProduct;

  const CustomerStoreFeedGrid({super.key, required this.onOpenProduct});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerStoreFeedCubit, CustomerStoreFeedState>(
      builder: (context, state) {
        final items = state.filteredItems;

        if (items.isEmpty) {
          if (state.status == CustomerStoreFeedStatus.loading) {
            return const GridSkeleton(childAspectRatio: 0.66);
          }

          if (state.status == CustomerStoreFeedStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => context.read<CustomerStoreFeedCubit>().load(force: true),
            );
          }

          return AppEmptyState(icon: Icons.inventory_2_outlined, title: S().noStoreProductsYet);
        }

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () => context.read<CustomerStoreFeedCubit>().load(force: true),
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.66,
                ),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return CustomerStoreFeedCard(
                    item: item,
                    onTap: () => onOpenProduct(item),
                  );
                },
              ),
            ),
            if (state.status == CustomerStoreFeedStatus.loading) const FilterLoadingBar(),
          ],
        );
      },
    );
  }
}
