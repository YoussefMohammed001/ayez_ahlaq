import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../manager/unresolved_bookings_cubit.dart';
import 'history_bookings_view.dart';
import 'pending_bookings_view.dart';
import 'queue_bookings_view.dart';
import 'unresolved_bookings_view.dart';

class TeamMemberBookingsScreen extends StatelessWidget {
  const TeamMemberBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppTopBar(
          title: S().bookingsTitle,
          viewLeading: false,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: S().bookingsPendingTab),
              Tab(text: S().bookingsQueueTab),
              Tab(text: S().bookingsUnresolvedTab),
              Tab(text: S().bookingsHistoryTab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const PendingBookingsView(),
            const QueueBookingsView(),
            BlocProvider(
              create: (_) => sl<UnresolvedBookingsCubit>(),
              child: const UnresolvedBookingsView(),
            ),
            const HistoryBookingsView(),
          ],
        ),
      ),
    );
  }
}
