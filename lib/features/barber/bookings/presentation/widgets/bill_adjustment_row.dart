import 'package:flutter/widgets.dart';
import '../../domain/entities/booking_adjustment.dart';

class BillAdjustmentRow {
  final TextEditingController labelController;
  final TextEditingController amountController;

  BillAdjustmentRow({
    required this.labelController,
    required this.amountController,
  });

  factory BillAdjustmentRow.empty() {
    return BillAdjustmentRow(
      labelController: TextEditingController(),
      amountController: TextEditingController(),
    );
  }

  factory BillAdjustmentRow.fromEntity(BookingAdjustment adjustment) {
    return BillAdjustmentRow(
      labelController: TextEditingController(text: adjustment.label),
      amountController: TextEditingController(
        text: adjustment.amount.toString(),
      ),
    );
  }

  BookingAdjustment toEntity() {
    return BookingAdjustment(
      label: labelController.text.trim(),
      amount: int.tryParse(amountController.text.trim()) ?? 0,
    );
  }

  void dispose() {
    labelController.dispose();
    amountController.dispose();
  }
}
