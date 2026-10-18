import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/customer_booking.dart';
import '../manager/my_bookings_state.dart';
import 'customer_booking_row.dart';

class BookingsTabView extends StatelessWidget {
  final MyBookingsState state;
  final List<CustomerBooking> bookings;
  final Future<void> Function() onRefresh;
  final ValueChanged<int> onTapBooking;

  const BookingsTabView({
    super.key,
    required this.state,
    required this.bookings,
    required this.onRefresh,
    required this.onTapBooking,
  });

  @override
  Widget build(BuildContext context) {
    if (state.status == MyBookingsStatus.loading && state.bookings.isEmpty) {
      return const ListSkeleton();
    }

    if (state.status == MyBookingsStatus.failure && state.bookings.isEmpty) {
      return RefreshableStateView(
        onRefresh: onRefresh,
        child: AppErrorState(message: state.errorMessage, onRetry: onRefresh),
      );
    }

    if (bookings.isEmpty) {
      return RefreshableStateView(
        onRefresh: onRefresh,
        child: AppEmptyState(
          icon: Icons.event_note_outlined,
          title: S().noBookingsYet,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        itemCount: bookings.length,
        itemBuilder: (_, index) {
          final booking = bookings[index];
          return CustomerBookingRow(
            booking: booking,
            onTap: () => onTapBooking(booking.id),
          );
        },
      ),
    );
  }
}
