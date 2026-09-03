import 'package:flutter/material.dart';

enum NotificationKind {
  newOrder,
  orderCancelled,
  lowStock,
  discountEnded,
  general;

  static NotificationKind fromType(String type) {
    final normalized = type.toUpperCase();
    if (normalized.contains('ORDER') && normalized.contains('CANCEL')) {
      return NotificationKind.orderCancelled;
    }
    if (normalized.contains('ORDER')) return NotificationKind.newOrder;
    if (normalized.contains('STOCK')) return NotificationKind.lowStock;
    if (normalized.contains('DISCOUNT')) return NotificationKind.discountEnded;
    return NotificationKind.general;
  }

  IconData get icon => switch (this) {
    NotificationKind.newOrder => Icons.receipt_long_rounded,
    NotificationKind.orderCancelled => Icons.cancel_outlined,
    NotificationKind.lowStock => Icons.inventory_2_outlined,
    NotificationKind.discountEnded => Icons.local_offer_outlined,
    NotificationKind.general => Icons.notifications_none_rounded,
  };
}
