import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_top_bar.dart';
import '../../../../../../core/widgets/avatar_circle.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../core/widgets/status_badge.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_order.dart';
import '../manager/barber_storefront_orders_cubit.dart';
import '../manager/barber_storefront_orders_state.dart';
import '../widgets/storefront_order_actions.dart';
import '../widgets/storefront_order_info_card.dart';
import '../widgets/storefront_order_items_card.dart';
import '../widgets/storefront_order_status_label.dart';
import '../widgets/storefront_order_status_tone.dart';

class StorefrontOrderDetailsScreen extends StatefulWidget {
  final StorefrontOrder order;

  const StorefrontOrderDetailsScreen({super.key, required this.order});

  @override
  State<StorefrontOrderDetailsScreen> createState() =>
      _StorefrontOrderDetailsScreenState();
}

class _StorefrontOrderDetailsScreenState
    extends State<StorefrontOrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BarberStorefrontOrdersCubit>().refreshOrder(widget.order.id);
  }

  Future<void> _refresh() =>
      context.read<BarberStorefrontOrdersCubit>().refreshOrder(widget.order.id);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberStorefrontOrdersCubit, BarberStorefrontOrdersState>(
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
                StorefrontOrderItemsCard(order: current),
                SizedBox(height: 16.h),
                SectionTitle(title: S().orderInfoTitle),
                StorefrontOrderInfoCard(order: current),
                SizedBox(height: 20.h),
                StorefrontOrderActions(order: current),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, StorefrontOrder order) {
    return Row(
      children: [
        AvatarCircle(
          initials: order.customerName.isEmpty
              ? S().avatarFallback
              : order.customerName.substring(0, 1),
          size: 52.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.customerName,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                order.customerPhone,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        StatusBadge(
          label: order.status.labelFor(order.fulfillmentType),
          tone: order.status.tone,
        ),
      ],
    );
  }
}
