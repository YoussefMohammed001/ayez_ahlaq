import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/stat_tile.dart';
import '../../../../../generated/l10n.dart';

class MoneyLockedGrid extends StatelessWidget {
  final int pendingBookingsCount;
  final int homeServiceRequestsCount;
  final int queueCount;
  final VoidCallback onPendingBookingsTap;
  final VoidCallback onHomeServiceTap;
  final VoidCallback onQueueTap;

  const MoneyLockedGrid({
    super.key,
    required this.pendingBookingsCount,
    required this.homeServiceRequestsCount,
    required this.queueCount,
    required this.onPendingBookingsTap,
    required this.onHomeServiceTap,
    required this.onQueueTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatTile(
            value: '$pendingBookingsCount',
            label: S().bookingsPendingTab,
            onTap: onPendingBookingsTap,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: '$homeServiceRequestsCount',
            label: S().homeServiceRequestsTab,
            onTap: onHomeServiceTap,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatTile(
            value: '$queueCount',
            label: S().bookingsQueueTab,
            onTap: onQueueTap,
          ),
        ),
      ],
    );
  }
}
