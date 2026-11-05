import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/unresolved_bookings_cubit.dart';
import '../manager/unresolved_bookings_state.dart';
import '../widgets/settle_bookings_bar.dart';
import '../widgets/unresolved_booking_row.dart';

class UnresolvedBookingsView extends StatefulWidget {
  const UnresolvedBookingsView({super.key});

  @override
  State<UnresolvedBookingsView> createState() => _UnresolvedBookingsViewState();
}

class _UnresolvedBookingsViewState extends State<UnresolvedBookingsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UnresolvedBookingsCubit>().load();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<UnresolvedBookingsCubit>().loadMore();
    }
  }

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<UnresolvedBookingsCubit>();
    final success = await cubit.submit();

    if (success) {
      showSuccess(S().settleSuccess);
      cubit.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<UnresolvedBookingsCubit, UnresolvedBookingsState>(
      isBusy: (state) => state.submitting,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<UnresolvedBookingsCubit, UnresolvedBookingsState>(
        builder: (context, state) {
          final cubit = context.read<UnresolvedBookingsCubit>();

          if (state.status == UnresolvedBookingsStatus.loading &&
              state.bookings.isEmpty) {
            return const ListSkeleton(showLeading: false);
          }

          if (state.status == UnresolvedBookingsStatus.failure &&
              state.bookings.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.load,
              child: AppErrorState(
                message: state.errorMessage,
                onRetry: cubit.load,
              ),
            );
          }

          if (state.bookings.isEmpty) {
            return RefreshableStateView(
              onRefresh: cubit.load,
              child: AppEmptyState(
                icon: Icons.checklist_rounded,
                title: S().noUnresolvedBookings,
                message: S().noUnresolvedBookingsHint,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: cubit.load,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                    itemCount: state.bookings.length,
                    itemBuilder: (_, index) {
                      final booking = state.bookings[index];
                      return UnresolvedBookingRow(
                        booking: booking,
                        decision: state.decisions[booking.id],
                        onDecisionChanged: (decision) =>
                            cubit.setDecision(booking.id, decision),
                        onReasonChanged: (reason) =>
                            cubit.setReason(booking.id, reason),
                      );
                    },
                  ),
                ),
              ),
              if (state.hasDecisions)
                SettleBookingsBar(
                  selectedCount: state.decisions.length,
                  isSubmitting: state.submitting,
                  onSubmit: () => _submit(context),
                ),
            ],
          );
        },
      ),
    );
  }
}
