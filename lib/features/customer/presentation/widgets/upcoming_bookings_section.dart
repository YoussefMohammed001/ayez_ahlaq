import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/list_skeleton.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../generated/l10n.dart';
import '../../booking/presentation/manager/my_bookings_cubit.dart';
import '../../booking/presentation/manager/my_bookings_state.dart';
import '../../booking/presentation/widgets/customer_booking_row.dart';
import 'dashboard_empty_hint.dart';

class UpcomingBookingsSection extends StatelessWidget {
  const UpcomingBookingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
      builder: (context, state) {
        final upcoming = state.upcoming.take(2).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: S().upcomingBookingsTitle,
              actionLabel: S().seeAll,
              onAction: () => context.push(Routes.customerBookingsScreen),
            ),
            if (state.status == MyBookingsStatus.loading && state.bookings.isEmpty)
              const ListSkeleton(itemCount: 2)
            else if (upcoming.isEmpty)
              DashboardEmptyHint(message: S().noUpcomingBookingsHint)
            else
              ...upcoming.map(
                (booking) => CustomerBookingRow(
                  booking: booking,
                  onTap: () =>
                      context.push(Routes.customerBookingDetailScreen, extra: booking.id),
                ),
              ),
          ],
        );
      },
    );
  }
}
