import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import '../widgets/booking_row.dart';

class QueueBookingsView extends StatelessWidget {
  const QueueBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) {
        final cubit = context.read<BookingsCubit>();

        if (state.queueStatus == BookingsStatus.loading && state.queue.isEmpty) {
          return const ListSkeleton(showLeading: false);
        }

        if (state.queueStatus == BookingsStatus.failure && state.queue.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadQueue,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadQueue,
            ),
          );
        }

        if (state.queue.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadQueue,
            child: AppEmptyState(
              icon: Icons.event_available_rounded,
              title: S().queueEmpty,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.loadQueue,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: state.queue.length,
            itemBuilder: (_, index) {
              final booking = state.queue[index];
              return BookingRow(
                booking: booking,
                onTap: () => context.push(
                  Routes.barberBookingDetailsScreen,
                  extra: booking,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
