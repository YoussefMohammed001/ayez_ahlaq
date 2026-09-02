import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../orders/presentation/manager/merchant_orders_state.dart';
import '../../../orders/presentation/widgets/order_card.dart';
import '../../../../../generated/l10n.dart';

class DashboardRecentOrders extends StatelessWidget {
  const DashboardRecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) {
        final recent = state.orders.take(3).toList();

        if (recent.isEmpty) {
          return AppEmptyState(
            icon: Icons.receipt_long_outlined,
            title: S().noOrdersYet,
            compact: true,
          );
        }

        return Column(
          children: [
            for (final order in recent)
              OrderCard(
                order: order,
                dateLabel: RelativeDateLabel.format(order.createdAt),
                onTap: () => context.push(
                  Routes.merchantOrderDetailsScreen,
                  extra: order,
                ),
              ),
          ],
        );
      },
    );
  }
}
