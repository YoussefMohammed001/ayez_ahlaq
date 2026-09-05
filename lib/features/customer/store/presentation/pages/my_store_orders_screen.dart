import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/store_orders_cubit.dart';
import '../manager/store_orders_state.dart';
import '../widgets/store_order_row.dart';

class MyStoreOrdersScreen extends StatefulWidget {
  const MyStoreOrdersScreen({super.key});

  @override
  State<MyStoreOrdersScreen> createState() => _MyStoreOrdersScreenState();
}

class _MyStoreOrdersScreenState extends State<MyStoreOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StoreOrdersCubit>().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(viewLeading: false, title: S().customerOrdersTitle),
      body: BlocBuilder<StoreOrdersCubit, StoreOrdersState>(
        builder: (context, state) {
          final cubit = context.read<StoreOrdersCubit>();

          if (state.status == StoreOrdersStatus.loading && state.orders.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == StoreOrdersStatus.failure && state.orders.isEmpty) {
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
                  onTap: () => context.push(Routes.customerStoreOrderDetailScreen, extra: order),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
