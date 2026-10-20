import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/store_fulfillment_type.dart';
import '../../domain/entities/store_order.dart';
import '../manager/store_orders_cubit.dart';
import '../manager/store_orders_state.dart';
import '../widgets/store_fulfillment_type_label.dart';
import '../widgets/store_order_items_card.dart';
import '../widgets/store_order_status_label.dart';
import '../widgets/store_order_status_tone.dart';

class StoreOrderDetailsScreen extends StatelessWidget {
  final StoreOrder order;

  const StoreOrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreOrdersCubit, StoreOrdersState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null &&
          current.errorMessage != previous.errorMessage,
      listener: (context, state) => showError(state.errorMessage!),
      child: BlocBuilder<StoreOrdersCubit, StoreOrdersState>(
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
                if (_hasInfoRows(current)) ...[
                  SizedBox(height: 12.h),
                  _buildInfoCard(context, current),
                ],
                SizedBox(height: 12.h),
                SectionTitle(title: S().orderedItems),
                StoreOrderItemsCard(order: current),
                if (current.status.canCancel) ...[
                  SizedBox(height: 20.h),
                  PrimaryCtaButton(
                    label: S().cancelOrder,
                    isLoading: isCancelling,
                    onPressed: () => context
                        .read<StoreOrdersCubit>()
                        .cancelOrder(current.id),
                  ),
                ],
              ],
            ),
          );
        },
      ),
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
                order.shopName,
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
        StatusBadge(label: order.status.label, tone: order.status.tone),
      ],
    );
  }

  bool _hasInfoRows(StoreOrder order) {
    final hasAddress =
        order.fulfillmentType == StoreFulfillmentType.delivery &&
        order.deliveryAddress != null &&
        order.deliveryAddress!.isNotEmpty;
    final hasNote = order.note != null && order.note!.isNotEmpty;
    return hasAddress || hasNote;
  }

  Widget _buildInfoCard(BuildContext context, StoreOrder order) {
    final hasAddress =
        order.fulfillmentType == StoreFulfillmentType.delivery &&
        order.deliveryAddress != null &&
        order.deliveryAddress!.isNotEmpty;
    final hasNote = order.note != null && order.note!.isNotEmpty;

    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          if (hasAddress)
            InfoRow(
              icon: Icons.location_on_outlined,
              label: S().orderDeliveryAddressLabel,
              value: order.deliveryAddress!,
              showDivider: hasNote,
            ),
          if (hasNote)
            InfoRow(
              icon: Icons.notes_outlined,
              label: S().orderNoteLabel,
              value: order.note!,
              showDivider: false,
            ),
        ],
      ),
    );
  }
}
