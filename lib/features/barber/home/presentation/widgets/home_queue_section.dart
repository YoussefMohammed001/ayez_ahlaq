import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../bookings/domain/entities/booking.dart';
import '../../../bookings/presentation/widgets/booking_row.dart';

class HomeQueueSection extends StatelessWidget {
  final List<Booking> queue;
  final VoidCallback onSeeAll;

  const HomeQueueSection({super.key, required this.queue, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: S().bookingsQueueTab,
          actionLabel: queue.isEmpty ? null : S().allOrders,
          onAction: queue.isEmpty ? null : onSeeAll,
        ),
        if (queue.isEmpty)
          AppEmptyState(
            icon: Icons.event_busy_rounded,
            title: S().homeNoQueueToday,
            compact: true,
          )
        else
          for (final booking in queue.take(3))
            BookingRow(
              booking: booking,
              onTap: () => context.push(
                Routes.barberBookingDetailsScreen,
                extra: booking,
              ),
            ),
      ],
    );
  }
}
