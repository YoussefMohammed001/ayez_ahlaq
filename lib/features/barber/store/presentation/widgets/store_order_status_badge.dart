import 'package:flutter/material.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/store_order_status.dart';
import 'store_order_status_label.dart';
import 'store_order_status_tone.dart';

class StoreOrderStatusBadge extends StatelessWidget {
  final StoreOrderStatus status;

  const StoreOrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(label: status.label, tone: status.tone);
  }
}
