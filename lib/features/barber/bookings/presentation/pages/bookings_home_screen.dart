import 'package:flutter/material.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/add_walk_in_sheet.dart';
import 'history_bookings_view.dart';
import 'pending_bookings_view.dart';
import 'queue_bookings_view.dart';

class BookingsHomeScreen extends StatefulWidget {
  const BookingsHomeScreen({super.key});

  @override
  State<BookingsHomeScreen> createState() => _BookingsHomeScreenState();
}

class _BookingsHomeScreenState extends State<BookingsHomeScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = TabController(length: 3, vsync: this)
    ..addListener(() => setState(() {}));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S().bookingsTitle,
            style: HeadingStyles.h4),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(text: S().bookingsPendingTab),
            Tab(text: S().bookingsQueueTab),
            Tab(text: S().bookingsHistoryTab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          PendingBookingsView(),
          QueueBookingsView(),
          HistoryBookingsView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddWalkInSheet.show(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
