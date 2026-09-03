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

class PendingBookingsView extends StatelessWidget {
  const PendingBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) {
        final cubit = context.read<BookingsCubit>();

        if (state.pendingStatus == BookingsStatus.loading &&
            state.pending.isEmpty) {
          return const ListSkeleton(showLeading: false);
        }

        if (state.pendingStatus == BookingsStatus.failure &&
            state.pending.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadPending,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadPending,
            ),
          );
        }

        if (state.pending.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadPending,
            child: AppEmptyState(
              icon: Icons.hourglass_empty_rounded,
              title: S().noPendingBookings,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.loadPending,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: state.pending.length,
            itemBuilder: (_, index) {
              final booking = state.pending[index];
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
