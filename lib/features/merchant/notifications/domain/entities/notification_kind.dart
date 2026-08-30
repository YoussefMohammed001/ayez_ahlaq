import 'package:flutter/material.dart';

enum NotificationKind {
  newOrder,
  orderCancelled,
  lowStock,
  discountEnded;

  IconData get icon => switch (this) {
    NotificationKind.newOrder => Icons.receipt_long_rounded,
    NotificationKind.orderCancelled => Icons.cancel_outlined,
    NotificationKind.lowStock => Icons.inventory_2_outlined,
    NotificationKind.discountEnded => Icons.local_offer_outlined,
  };
}
