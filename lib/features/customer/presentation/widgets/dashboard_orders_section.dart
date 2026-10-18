import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/list_skeleton.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../generated/l10n.dart';
import '../../store/presentation/manager/store_orders_cubit.dart';
import '../../store/presentation/manager/store_orders_state.dart';
import '../../store/presentation/widgets/store_order_row.dart';

class DashboardOrdersSection extends StatelessWidget {
  const DashboardOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreOrdersCubit, StoreOrdersState>(
      builder: (context, state) {
        final recent = state.orders.take(2).toList();
        if (state.status != StoreOrdersStatus.loading && recent.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: S().customerOrdersTitle,
              actionLabel: S().seeAll,
              onAction: () => context.push(Routes.customerStoreOrdersScreen),
            ),
            if (state.status == StoreOrdersStatus.loading &&
                state.orders.isEmpty)
              const ListSkeleton(itemCount: 2)
            else
              ...recent.map(
                (order) => StoreOrderRow(
                  order: order,
                  onTap: () => context.push(
                    Routes.customerStoreOrderDetailScreen,
                    extra: order,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
