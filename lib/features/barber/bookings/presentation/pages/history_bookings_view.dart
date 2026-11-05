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

class HistoryBookingsView extends StatelessWidget {
  const HistoryBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) {
        final cubit = context.read<BookingsCubit>();

        if (state.historyStatus == BookingsStatus.loading &&
            state.history.isEmpty) {
          return const ListSkeleton(showLeading: false);
        }

        if (state.historyStatus == BookingsStatus.failure &&
            state.history.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadHistory,
            child: AppErrorState(
              message: state.errorMessage,
              onRetry: cubit.loadHistory,
            ),
          );
        }

        if (state.history.isEmpty) {
          return RefreshableStateView(
            onRefresh: cubit.loadHistory,
            child: AppEmptyState(
              icon: Icons.history_rounded,
              title: S().noBookingHistory,
              message: S().noBookingHistoryHint,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.loadHistory,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            itemCount: state.history.length,
            itemBuilder: (_, index) {
              final booking = state.history[index];
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
