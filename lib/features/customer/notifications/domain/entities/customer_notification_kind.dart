import 'package:flutter/material.dart';

enum CustomerNotificationKind {
  bookingConfirmed,
  bookingRejected,
  bookingCancelled,
  orderStatus,
  favorite,
  general;

  static CustomerNotificationKind fromType(String type) {
    final normalized = type.toUpperCase();
    if (normalized.contains('BOOKING') && normalized.contains('CONFIRM')) {
      return CustomerNotificationKind.bookingConfirmed;
    }
    if (normalized.contains('BOOKING') && normalized.contains('REJECT')) {
      return CustomerNotificationKind.bookingRejected;
    }
    if (normalized.contains('BOOKING') && normalized.contains('CANCEL')) {
      return CustomerNotificationKind.bookingCancelled;
    }
    if (normalized.contains('ORDER')) return CustomerNotificationKind.orderStatus;
    if (normalized.contains('FAVORITE') || normalized.contains('INVITE')) {
      return CustomerNotificationKind.favorite;
    }
    return CustomerNotificationKind.general;
  }

  IconData get icon => switch (this) {
    CustomerNotificationKind.bookingConfirmed => Icons.event_available_rounded,
    CustomerNotificationKind.bookingRejected => Icons.event_busy_rounded,
    CustomerNotificationKind.bookingCancelled => Icons.cancel_outlined,
    CustomerNotificationKind.orderStatus => Icons.receipt_long_rounded,
    CustomerNotificationKind.favorite => Icons.favorite_rounded,
    CustomerNotificationKind.general => Icons.notifications_none_rounded,
  };
}
