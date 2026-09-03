import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/helpers/relative_date_label.dart';
import '../../../../../../core/routes/route_paths.dart';
import '../../../../../../core/widgets/app_empty_state.dart';
import '../../../../../../core/widgets/app_error_state.dart';
import '../../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../../core/widgets/filter_chip_row.dart';
import '../../../../../../core/widgets/list_skeleton.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order_status.dart';
import '../manager/barber_storefront_orders_cubit.dart';
import '../manager/barber_storefront_orders_state.dart';
import '../widgets/storefront_order_card.dart';
import '../widgets/storefront_order_status_label.dart';

class BarberStorefrontOrdersScreen extends StatelessWidget {
  const BarberStorefrontOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: Text(
              S().storefrontOrdersSubtitle,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          _buildFilters(),
          SizedBox(height: 12.h),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return BlocBuilder<BarberStorefrontOrdersCubit, BarberStorefrontOrdersState>(
      builder: (context, state) => FilterChipRow<StorefrontOrderStatus>(
        options: StorefrontOrderStatus.values,
        selected: state.filter,
        allLabel: S().filterAll,
        labelBuilder: (status) => status.label,
        onSelected: context.read<BarberStorefrontOrdersCubit>().applyFilter,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<BarberStorefrontOrdersCubit, BarberStorefrontOrdersState>(
      builder: (context, state) {
        if (state.status == StorefrontOrdersStatus.loading &&
            state.orders.isEmpty) {
          return const ListSkeleton(showLeading: false);
        }

        if (state.status == StorefrontOrdersStatus.failure &&
            state.orders.isEmpty) {
          return RefreshableStateView(
            onRefresh: context.read<BarberStorefrontOrdersCubit>().loadOrders,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<BarberStorefrontOrdersCubit>().loadOrders,
            ),
          );
        }

        if (state.visibleOrders.isEmpty) {
          return RefreshableStateView(
            onRefresh: context.read<BarberStorefrontOrdersCubit>().loadOrders,
            child: AppEmptyState(
              icon: Icons.receipt_long_outlined,
              title: S().noOrdersYet,
              message: S().storefrontOrdersSubtitle,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: context.read<BarberStorefrontOrdersCubit>().loadOrders,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
            itemCount: state.visibleOrders.length,
            itemBuilder: (_, index) {
              final order = state.visibleOrders[index];
              return StorefrontOrderCard(
                order: order,
                dateLabel: RelativeDateLabel.format(order.createdAt),
                onTap: () => context.push(
                  Routes.barberStorefrontOrderDetailsScreen,
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
