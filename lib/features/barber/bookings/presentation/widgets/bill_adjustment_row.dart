import 'package:flutter/widgets.dart';
import '../../domain/entities/booking_adjustment.dart';

class BillAdjustmentRow {
  final TextEditingController labelController;
  final TextEditingController amountController;
  final ValueNotifier<bool> isDiscountNotifier;

  BillAdjustmentRow({
    required this.labelController,
    required this.amountController,
    required this.isDiscountNotifier,
  });

  factory BillAdjustmentRow.empty() {
    return BillAdjustmentRow(
      labelController: TextEditingController(),
      amountController: TextEditingController(),
      isDiscountNotifier: ValueNotifier(false),
    );
  }

  factory BillAdjustmentRow.fromEntity(BookingAdjustment adjustment) {
    return BillAdjustmentRow(
      labelController: TextEditingController(text: adjustment.label),
      amountController: TextEditingController(
        text: adjustment.amount.abs().toString(),
      ),
      isDiscountNotifier: ValueNotifier(adjustment.isDiscount),
    );
  }

  BookingAdjustment toEntity() {
    final magnitude = int.tryParse(amountController.text.trim())?.abs() ?? 0;
    return BookingAdjustment(
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
