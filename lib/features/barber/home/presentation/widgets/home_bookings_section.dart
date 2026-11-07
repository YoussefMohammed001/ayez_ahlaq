import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../bookings/presentation/manager/bookings_state.dart';
import '../../../tour/presentation/widgets/barber_tour_targets.dart';
import 'home_pending_section.dart';
import 'home_queue_section.dart';

class HomeBookingsSection extends StatelessWidget {
  final ValueChanged<int> onGoToTab;
  final BarberTourTargets tour;

  const HomeBookingsSection({
    super.key,
    required this.onGoToTab,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TourTarget(
            tourKey: tour.pending,
            title: S().tourPendingTitle,
            description: S().tourPendingBody,
            child: HomePendingSection(
              pending: state.pending,
              onSeeAll: () => onGoToTab(1),
            ),
          ),
          HomeQueueSection(queue: state.queue, onSeeAll: () => onGoToTab(1)),
        ],
      ),
    );
  }
}
