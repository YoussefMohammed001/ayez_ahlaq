import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../bookings/domain/entities/booking.dart';
import '../../../bookings/presentation/widgets/booking_row.dart';

class HomePendingSection extends StatelessWidget {
  final List<Booking> pending;
  final VoidCallback onSeeAll;

  const HomePendingSection({super.key, required this.pending, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: S().homeNeedsAttentionTitle,
          actionLabel: pending.isEmpty ? null : S().allOrders,
          onAction: pending.isEmpty ? null : onSeeAll,
        ),
        if (pending.isEmpty)
          AppEmptyState(
            icon: Icons.check_circle_outline_rounded,
            title: S().homeAllClear,
            compact: true,
          )
        else
          for (final booking in pending.take(3))
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
