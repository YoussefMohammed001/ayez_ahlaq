import 'package:flutter/material.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../../../../generated/l10n.dart';

class BarberTourTargets {
  final notifications = GlobalKey(debugLabel: 'tourNotifications');
  final checklist = GlobalKey(debugLabel: 'tourChecklist');
  final summary = GlobalKey(debugLabel: 'tourSummary');
  final pending = GlobalKey(debugLabel: 'tourPending');
  final queue = GlobalKey(debugLabel: 'tourQueue');
  final attendance = GlobalKey(debugLabel: 'tourAttendance');
  final bookingsTab = GlobalKey(debugLabel: 'tourBookingsTab');
  final storefrontTab = GlobalKey(debugLabel: 'tourStorefrontTab');
  final accountTab = GlobalKey(debugLabel: 'tourAccountTab');

  List<GlobalKey> get ownerSequence => [
    notifications,
    checklist,
    summary,
    pending,
    bookingsTab,
    storefrontTab,
    accountTab,
  ];

  List<GlobalKey> get teamMemberSequence => [
    notifications,
    attendance,
    pending,
    queue,
    bookingsTab,
    accountTab,
  ];

  Widget ownerTab(int index, Widget tab) => switch (index) {
    1 => _tab(bookingsTab, S().tabBookings, S().tourBookingsTabBody, tab),
    2 => _tab(
      storefrontTab,
      S().storefrontTitle,
      S().tourStorefrontTabBody,
      tab,
    ),
    3 => _tab(
      accountTab,
      S().tabAccount,
      S().tourAccountTabBody,
      tab,
      last: true,
    ),
    _ => tab,
  };

  Widget teamMemberTab(int index, Widget tab) => switch (index) {
    1 => _tab(bookingsTab, S().tabBookings, S().tourBookingsTabBody, tab),
    2 => _tab(
      accountTab,
      S().tabAccount,
      S().tourAccountTabBody,
      tab,
      last: true,
    ),
    _ => tab,
  };

  Widget _tab(
    GlobalKey key,
    String title,
    String body,
    Widget tab, {
    bool last = false,
  }) => TourTarget(
    tourKey: key,
    title: title,
    description: body,
    isLast: last,
    borderRadius: BorderRadius.circular(10),
    child: tab,
  );
}
