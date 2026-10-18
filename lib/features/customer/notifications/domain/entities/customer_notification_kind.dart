import 'package:flutter/material.dart';

enum CustomerNotificationKind {
  bookingConfirmed,
  bookingRejected,
  bookingCancelled,
  orderStatus,
  favorite,
  homeServiceAccepted,
  homeServiceRejected,
  homeServiceExpired,
  homeServicePriceUpdated,
  homeService,
  general;

  static CustomerNotificationKind fromType(String type) {
    final normalized = type.toUpperCase();
    if (normalized.contains('HOME_SERVICE')) {
      if (normalized.contains('ACCEPT')) {
        return CustomerNotificationKind.homeServiceAccepted;
      }
      if (normalized.contains('REJECT')) {
        return CustomerNotificationKind.homeServiceRejected;
      }
      if (normalized.contains('EXPIRE')) {
        return CustomerNotificationKind.homeServiceExpired;
      }
      if (normalized.contains('PRICE')) {
        return CustomerNotificationKind.homeServicePriceUpdated;
      }
      return CustomerNotificationKind.homeService;
    }
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
    CustomerNotificationKind.homeServiceAccepted =>
      Icons.home_repair_service_rounded,
    CustomerNotificationKind.homeServiceRejected => Icons.event_busy_rounded,
    CustomerNotificationKind.homeServiceExpired => Icons.timer_off_rounded,
    CustomerNotificationKind.homeServicePriceUpdated =>
      Icons.price_change_rounded,
    CustomerNotificationKind.homeService => Icons.home_repair_service_outlined,
    CustomerNotificationKind.general => Icons.notifications_none_rounded,
  };
}
