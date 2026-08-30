import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../manager/merchant_orders_cubit.dart';
import '../manager/merchant_orders_state.dart';
import '../widgets/order_card.dart';
import '../widgets/order_status_label.dart';
import '../../domain/entities/order_status.dart';
import '../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantOrdersScreen extends StatelessWidget {
  const MerchantOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S().barberOrders, style: HeadingStyles.h2),
                  SizedBox(height: 4.h),
                  Text(
                    S().barberOrdersSubtitle,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            _buildFilters(),
            SizedBox(height: 12.h),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) => FilterChipRow<OrderStatus>(
        options: OrderStatus.values,
        selected: state.filter,
        allLabel: S().filterAll,
        labelBuilder: (status) => status.label,
        onSelected: context.read<MerchantOrdersCubit>().applyFilter,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) {
        if (state.status == OrdersStatus.loading && state.orders.isEmpty) {
          return const ListSkeleton(showLeading: false);
        }

        if (state.status == OrdersStatus.failure && state.orders.isEmpty) {
          return RefreshableStateView(
            onRefresh: context.read<MerchantOrdersCubit>().loadOrders,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<MerchantOrdersCubit>().loadOrders,
            ),
          );
        }

        if (state.orders.isEmpty) {
          return RefreshableStateView(
            onRefresh: context.read<MerchantOrdersCubit>().loadOrders,
            child: AppEmptyState(
              icon: Icons.receipt_long_outlined,
              title: S().noOrdersYet,
              message: S().barberOrdersSubtitle,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: context.read<MerchantOrdersCubit>().loadOrders,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
            itemCount: state.orders.length,
            itemBuilder: (_, index) {
              final order = state.orders[index];
              return OrderCard(
                order: order,
                dateLabel: RelativeDateLabel.format(order.createdAt),
                onTap: () => context.push(
                  Routes.merchantOrderDetailsScreen,
                  extra: order,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
