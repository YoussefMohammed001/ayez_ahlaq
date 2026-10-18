import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../home_service/presentation/manager/home_service_requests_cubit.dart';
import '../../../home_service/presentation/widgets/home_service_requests_tab_view.dart';
import '../manager/my_bookings_cubit.dart';
import '../manager/my_bookings_state.dart';
import '../widgets/bookings_tab_view.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    context.read<MyBookingsCubit>().loadBookings();
    context.read<HomeServiceRequestsCubit>().loadRequests();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.colorScheme.onSurface,
          ),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: Text(S().bookingsTitle, style: HeadingStyles.h4),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(text: S().bookingsUpcomingTab),
            Tab(text: S().bookingsPastTab),
            Tab(text: S().homeServiceRequestsTab),
          ],
        ),
      ),
      body: BlocBuilder<MyBookingsCubit, MyBookingsState>(
        builder: (context, state) {
          final cubit = context.read<MyBookingsCubit>();

          return TabBarView(
            controller: _controller,
            children: [
              BookingsTabView(
                state: state,
                bookings: state.upcoming,
                onRefresh: cubit.loadBookings,
                onTapBooking: (id) =>
                    context.push(Routes.customerBookingDetailScreen, extra: id),
              ),
              BookingsTabView(
                state: state,
                bookings: state.past,
                onRefresh: cubit.loadBookings,
                onTapBooking: (id) =>
                    context.push(Routes.customerBookingDetailScreen, extra: id),
              ),
              const HomeServiceRequestsTabView(),
            ],
          );
        },
      ),
    );
  }
}
