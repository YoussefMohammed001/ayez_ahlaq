import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_cubit.dart';
import '../../../home_service_requests/presentation/widgets/home_service_requests_tab_view.dart';
import '../manager/unresolved_bookings_cubit.dart';
import '../widgets/walk_in_sheet_launcher.dart';
import 'history_bookings_view.dart';
import 'pending_bookings_view.dart';
import 'queue_bookings_view.dart';
import 'unresolved_bookings_view.dart';

class BookingsHomeScreen extends StatefulWidget {
  const BookingsHomeScreen({super.key});

  @override
  State<BookingsHomeScreen> createState() => _BookingsHomeScreenState();
}

class _BookingsHomeScreenState extends State<BookingsHomeScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = TabController(length: 5, vsync: this)
    ..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
    context.read<HomeServiceRequestsCubit>().loadPending();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().bookingsTitle,
        viewLeading: false,
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(text: S().bookingsPendingTab),
            Tab(text: S().bookingsQueueTab),
            Tab(text: S().bookingsUnresolvedTab),
            Tab(text: S().bookingsHistoryTab),
            Tab(text: S().homeServiceRequestsTab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const PendingBookingsView(),
          const QueueBookingsView(),
          BlocProvider(
            create: (_) => sl<UnresolvedBookingsCubit>(),
            child: const UnresolvedBookingsView(),
          ),
          const HistoryBookingsView(),
          const HomeServiceRequestsTabView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addWalkInFab',
        onPressed: () => showAddWalkInSheet(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
