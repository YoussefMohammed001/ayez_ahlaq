import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/info_row.dart';
import '../../../../../../shared/payment_methods/payment_method_model.dart';
import '../../domain/entities/storefront_fulfillment_type.dart';
import '../../domain/entities/storefront_order.dart';
import 'storefront_fulfillment_type_label.dart';
import '../../../../../../generated/l10n.dart';

class StorefrontOrderInfoCard extends StatelessWidget {
  final StorefrontOrder order;

  const StorefrontOrderInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final rows = _rows;

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

  List<(IconData, String, String)> get _rows {
    final rows = <(IconData, String, String)>[
      (
        order.fulfillmentType == StorefrontFulfillmentType.delivery
            ? Icons.delivery_dining_outlined
            : Icons.storefront_outlined,
        S().orderFulfilmentTypeLabel,
        order.fulfillmentType.label,
      ),
      (
        Icons.payments_outlined,
        S().paymentMethodLabel,
        PaymentMethodModel.fromCode(order.paymentMethod).label,
      ),
    ];

    if (order.fulfillmentType == StorefrontFulfillmentType.delivery &&
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

    if (order.rejectionReason != null && order.rejectionReason!.isNotEmpty) {
      rows.add((
        Icons.report_gmailerrorred_outlined,
        S().orderRejectionReasonLabel,
        order.rejectionReason!,
      ));
    }

    return rows;
  }
}
