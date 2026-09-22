import 'package:flutter/widgets.dart';
import '../../domain/entities/home_service_request_adjustment.dart';

class HomeServiceAdjustmentRow {
  final TextEditingController labelController;
  final TextEditingController amountController;

  HomeServiceAdjustmentRow({
    required this.labelController,
    required this.amountController,
  });

  factory HomeServiceAdjustmentRow.empty() {
    return HomeServiceAdjustmentRow(
      labelController: TextEditingController(),
      amountController: TextEditingController(),
    );
  }

  factory HomeServiceAdjustmentRow.fromEntity(
    HomeServiceRequestAdjustment adjustment,
  ) {
    return HomeServiceAdjustmentRow(
      labelController: TextEditingController(text: adjustment.label),
      amountController: TextEditingController(
        text: adjustment.amount.toString(),
      ),
    );
  }

  HomeServiceRequestAdjustment toEntity() {
    return HomeServiceRequestAdjustment(
      label: labelController.text.trim(),
      amount: int.tryParse(amountController.text.trim()) ?? 0,
    );
  }

  void dispose() {
    labelController.dispose();
    amountController.dispose();
  }
}
