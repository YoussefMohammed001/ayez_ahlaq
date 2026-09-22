import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/purchase_order.dart';
import '../manager/merchant_orders_cubit.dart';
import '../manager/merchant_orders_state.dart';
import '../widgets/order_actions.dart';
import '../widgets/order_info_card.dart';
import '../widgets/order_items_card.dart';
import '../widgets/order_status_tone.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/order_status_label.dart';
import '../../../../../core/extensions/ext_theme.dart';

class OrderDetailsScreen extends StatefulWidget {
  final PurchaseOrder order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MerchantOrdersCubit>().refreshOrder(widget.order.id);
  }

  Future<void> _refresh() =>
      context.read<MerchantOrdersCubit>().refreshOrder(widget.order.id);

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MerchantOrdersCubit, MerchantOrdersState>(
      isBusy: (state) => state.updatingOrderId != null,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
        builder: (context, state) {
          final current = state.orders.firstWhere(
            (o) => o.id == widget.order.id,
            orElse: () => widget.order,
          );

          return Scaffold(
            appBar: AppTopBar(title: current.code),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                children: [
                  _buildHeader(context, current),
                  SectionTitle(title: S().orderedItems),
                  OrderItemsCard(order: current),
                  SizedBox(height: 16.h),
                  SectionTitle(title: S().orderInfoTitle),
                  OrderInfoCard(order: current),
                  SizedBox(height: 20.h),
                  OrderActions(order: current),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PurchaseOrder order) {
    return Row(
      children: [
        AvatarCircle(
          initials: order.shopName.isEmpty
              ? S().avatarFallback
              : order.shopName.substring(0, 1),
          size: 52.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.shopName,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                S().responsibleBarber(order.barberName),
                style: TextStyle(
                  fontSize: 11.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        StatusBadge(
          label: order.status.labelFor(order.fulfilmentType),
          tone: order.status.tone,
        ),
      ],
    );
  }
}
