import 'package:flutter/widgets.dart';
import '../../domain/entities/home_service_request_adjustment.dart';

class HomeServiceAdjustmentRow {
  final TextEditingController labelController;
  final TextEditingController amountController;
  final ValueNotifier<bool> isDiscountNotifier;

  HomeServiceAdjustmentRow({
    required this.labelController,
    required this.amountController,
    required this.isDiscountNotifier,
  });

  factory HomeServiceAdjustmentRow.empty() {
    return HomeServiceAdjustmentRow(
      labelController: TextEditingController(),
      amountController: TextEditingController(),
      isDiscountNotifier: ValueNotifier(false),
    );
  }

  factory HomeServiceAdjustmentRow.fromEntity(
    HomeServiceRequestAdjustment adjustment,
  ) {
    return HomeServiceAdjustmentRow(
      labelController: TextEditingController(text: adjustment.label),
      amountController: TextEditingController(
        text: adjustment.amount.abs().toString(),
      ),
      isDiscountNotifier: ValueNotifier(adjustment.isDiscount),
    );
  }

  HomeServiceRequestAdjustment toEntity() {
    final magnitude = int.tryParse(amountController.text.trim())?.abs() ?? 0;
    return HomeServiceRequestAdjustment(
      label: labelController.text.trim(),
      amount: isDiscountNotifier.value ? -magnitude : magnitude,
    );
  }

  void dispose() {
    labelController.dispose();
    amountController.dispose();
    isDiscountNotifier.dispose();
  }
}
