import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_order.dart';
import '../manager/barber_store_orders_cubit.dart';
import '../manager/barber_store_orders_state.dart';
import '../widgets/fulfillment_type_label.dart';
import '../widgets/store_order_items_card.dart';
import '../widgets/store_order_status_badge.dart';

class BarberStoreOrderDetailsScreen extends StatelessWidget {
  final StoreOrder order;

  const BarberStoreOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStoreOrdersCubit, BarberStoreOrdersState>(
      builder: (context, state) {
        final current = state.orders.firstWhere(
          (o) => o.id == order.id,
          orElse: () => order,
        );
        final isCancelling = state.cancellingId == current.id;

        return Scaffold(
          appBar: AppTopBar(title: current.code),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              _buildHeader(context, current),
              SectionTitle(title: S().orderedItems),
              StoreOrderItemsCard(order: current),
              if (current.status.canCancel) ...[
                SizedBox(height: 20.h),
                PrimaryCtaButton(
                  label: S().cancelOrder,
                  isLoading: isCancelling,
                  onPressed: () =>
                      context.read<BarberStoreOrdersCubit>().cancelOrder(current.id),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, StoreOrder order) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.merchantName,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                order.fulfillmentType.label,
                style: TextStyle(fontSize: 11.sp, color: context.semantic.info),
              ),
            ],
          ),
        ),
        StoreOrderStatusBadge(status: order.status),
      ],
    );
  }
}
