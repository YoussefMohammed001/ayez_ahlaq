import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_store_orders_cubit.dart';
import '../manager/barber_store_orders_state.dart';
import '../widgets/store_order_row.dart';

class BarberStoreOrdersScreen extends StatelessWidget {
  const BarberStoreOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().storeOrdersTitle),
      body: BlocBuilder<BarberStoreOrdersCubit, BarberStoreOrdersState>(
        builder: (context, state) {
          final cubit = context.read<BarberStoreOrdersCubit>();

          if (state.status == BarberStoreOrdersStatus.loading && state.orders.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == BarberStoreOrdersStatus.failure && state.orders.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadOrders,
              child: AppErrorState(message: state.errorMessage, onRetry: cubit.loadOrders),
            );
          }

          if (state.orders.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.loadOrders,
              child: AppEmptyState(icon: Icons.receipt_long_outlined, title: S().noOrdersYet),
            );
          }

          return RefreshIndicator(
            onRefresh: cubit.loadOrders,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.orders.length,
              itemBuilder: (_, index) {
                final order = state.orders[index];
                return StoreOrderRow(
                  order: order,
                  dateLabel: RelativeDateLabel.format(order.orderDate),
                  onTap: () => context.push(Routes.barberStoreOrderDetailsScreen, extra: order),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
