import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../domain/entities/fulfilment_type.dart';
import '../../domain/entities/purchase_order.dart';
import 'fulfilment_type_label.dart';
import '../../../../../generated/l10n.dart';

class OrderInfoCard extends StatelessWidget {
  final PurchaseOrder order;

  const OrderInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final rows = _rowsFor(order);

    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++)
            InfoRow(
              icon: rows[i].$1,
              label: rows[i].$2,
              value: rows[i].$3,
              showDivider: i != rows.length - 1,
            ),
        ],
      ),
    );
  }

  static List<(IconData, String, String)> _rowsFor(PurchaseOrder order) {
    final rows = <(IconData, String, String)>[
      (
        order.fulfilmentType == FulfilmentType.delivery
            ? Icons.delivery_dining_outlined
            : Icons.storefront_outlined,
        S().orderFulfilmentTypeLabel,
        order.fulfilmentType.label,
      ),
    ];

    if (order.orderDate != null) {
      rows.add((
        Icons.event_outlined,
        S().orderDateLabel,
        AppDateTime.formatDate(order.orderDate!),
      ));
    }

    if (order.fulfilmentType == FulfilmentType.delivery &&
        order.deliveryAddress != null &&
        order.deliveryAddress!.isNotEmpty) {
      rows.add((
        Icons.location_on_outlined,
        S().orderDeliveryAddressLabel,
        order.deliveryAddress!,
      ));
    }

    if (order.note != null && order.note!.isNotEmpty) {
      rows.add((Icons.notes_outlined, S().orderNoteLabel, order.note!));
    }

    if (order.acceptedAt != null) {
      rows.add((
        Icons.check_circle_outline,
        S().orderAcceptedAtLabel,
        AppDateTime.formatDateTime(order.acceptedAt!),
      ));
    }

    if (order.deliveredAt != null) {
      rows.add((
        Icons.local_shipping_outlined,
        S().orderDeliveredAtLabel,
        AppDateTime.formatDateTime(order.deliveredAt!),
      ));
    }

    if (order.rejectedAt != null) {
      rows.add((
        Icons.cancel_outlined,
        S().orderRejectedAtLabel,
        AppDateTime.formatDateTime(order.rejectedAt!),
      ));
    }

    if (order.rejectionReason != null && order.rejectionReason!.isNotEmpty) {
      rows.add((
        Icons.report_gmailerrorred_outlined,
        S().orderRejectionReasonLabel,
        order.rejectionReason!,
      ));
    }

    if (order.cancelledAt != null) {
      rows.add((
        Icons.block_outlined,
        S().orderCancelledAtLabel,
        AppDateTime.formatDateTime(order.cancelledAt!),
      ));
    }

    if (order.cancellationNote != null && order.cancellationNote!.isNotEmpty) {
      rows.add((
        Icons.info_outline,
        S().orderCancellationNoteLabel,
        order.cancellationNote!,
      ));
    }

    if (order.cancelledByAdminName != null &&
        order.cancelledByAdminName!.isNotEmpty) {
      rows.add((
        Icons.admin_panel_settings_outlined,
        S().orderCancelledByLabel,
        order.cancelledByAdminName!,
      ));
    }

    return rows;
  }
}
