import 'package:flutter/material.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/sale.dart';

class SaleStatusBadge extends StatelessWidget {
  final Sale sale;

  const SaleStatusBadge({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: sale.isCancelled ? S().saleStatusCancelled : S().saleStatusDone,
      tone: sale.isCancelled ? BadgeTone.danger : BadgeTone.open,
    );
  }
}
