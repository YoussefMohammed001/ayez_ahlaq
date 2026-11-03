import 'package:flutter/material.dart';

enum NotificationKind {
  bookingRequested,
  bookingCancelled,
  subscription,
  wallet,
  broadcast,
  homeServiceBroadcast,
  homeService,
  ratingReceived,
  adminAnnouncement,
  attendanceCheckIn,
  attendanceCheckOut,
  account,
  document,
  general;

  static NotificationKind fromType(String type) {
    final normalized = type.toUpperCase();
    if (normalized.contains('ATTENDANCE_CHECK_OUT')) {
      return NotificationKind.attendanceCheckOut;
    }
    if (normalized.contains('ATTENDANCE_CHECK_IN')) {
      return NotificationKind.attendanceCheckIn;
    }
    if (normalized.contains('HOME_SERVICE') && normalized.contains('BROADCAST')) {
      return NotificationKind.homeServiceBroadcast;
    }
    if (normalized.contains('HOME_SERVICE')) return NotificationKind.homeService;
    if (normalized.contains('RATING')) return NotificationKind.ratingReceived;
    if (normalized.contains('BOOKING') && normalized.contains('CANCEL')) {
      return NotificationKind.bookingCancelled;
    }
    if (normalized.contains('BOOKING')) return NotificationKind.bookingRequested;
    if (normalized.contains('SUBSCRIPTION')) return NotificationKind.subscription;
    if (normalized.contains('WALLET')) return NotificationKind.wallet;
    if (normalized.contains('BROADCAST')) return NotificationKind.broadcast;
    if (normalized.contains('ADMIN') || normalized.contains('ANNOUNCEMENT')) {
      return NotificationKind.adminAnnouncement;
    }
    if (normalized.contains('DOCUMENT')) return NotificationKind.document;
    if (normalized.contains('ACCOUNT')) return NotificationKind.account;
    return NotificationKind.general;
  }

  IconData get icon => switch (this) {
    NotificationKind.bookingRequested => Icons.event_available_rounded,
    NotificationKind.bookingCancelled => Icons.event_busy_rounded,
    NotificationKind.subscription => Icons.workspace_premium_outlined,
    NotificationKind.wallet => Icons.account_balance_wallet_outlined,
    NotificationKind.broadcast => Icons.campaign_outlined,
    NotificationKind.homeServiceBroadcast => Icons.home_repair_service_rounded,
    NotificationKind.homeService => Icons.home_repair_service_outlined,
    NotificationKind.ratingReceived => Icons.star_rounded,
    NotificationKind.adminAnnouncement => Icons.admin_panel_settings_outlined,
    NotificationKind.attendanceCheckIn => Icons.login_rounded,
    NotificationKind.attendanceCheckOut => Icons.logout_rounded,
    NotificationKind.account => Icons.verified_user_outlined,
    NotificationKind.document => Icons.description_outlined,
    NotificationKind.general => Icons.notifications_none_rounded,
  };
}
