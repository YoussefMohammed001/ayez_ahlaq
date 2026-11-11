import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/helpers/relative_date_label.dart';
import '../../../../../../core/routes/route_paths.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../../orders/presentation/manager/merchant_orders_state.dart';
import '../../../../orders/presentation/widgets/order_card.dart';
import '../../helpers/sub_home_summary.dart';
import 'sub_home_card.dart';
import 'sub_home_value_text.dart';

class SubHomeLatestOrders extends StatelessWidget {
  static const _shown = 3;

  final VoidCallback onSeeAll;

  const SubHomeLatestOrders({super.key, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
      builder: (context, state) {
        if (state.status == OrdersStatus.initial ||
            (state.status == OrdersStatus.loading && state.orders.isEmpty)) {
          return const SizedBox.shrink();
        }

        final latest = SubHomeSummary.latestOrdersOf(state.orders, _shown);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: S().subHomeLatestOrders,
              actionLabel: latest.isEmpty ? null : S().seeAll,
              onAction: onSeeAll,
            ),
            if (latest.isEmpty)
              SubHomeCard(
                icon: Icons.receipt_long_rounded,
                title: S().subHomeLatestOrders,
                child: SubHomeValueText(S().subHomeNoOrders, muted: true),
              ),
            for (final order in latest)
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
