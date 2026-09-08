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
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          InfoRow(
            icon: order.fulfillmentType == StorefrontFulfillmentType.delivery
                ? Icons.delivery_dining_outlined
                : Icons.storefront_outlined,
            label: S().orderFulfilmentTypeLabel,
            value: order.fulfillmentType.label,
          ),
          InfoRow(
            icon: Icons.payments_outlined,
            label: S().paymentMethodLabel,
            value: PaymentMethodModel.fromCode(order.paymentMethod).label,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
