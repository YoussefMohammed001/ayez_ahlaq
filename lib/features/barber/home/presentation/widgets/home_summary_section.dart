import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../bookings/presentation/manager/bookings_state.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_cubit.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_state.dart';
import '../../../money/presentation/manager/money_pin_cubit.dart';
import '../../../money/presentation/manager/money_pin_state.dart';
import '../../../money/presentation/widgets/money_locked_grid.dart';
import '../../../team/presentation/manager/earnings_cubit.dart';
import '../../../team/presentation/manager/earnings_state.dart';
import 'home_earnings_grid.dart';

class HomeSummarySection extends StatelessWidget {
  final ValueChanged<int> onGoToTab;
  final GlobalKey tourKey;

  const HomeSummarySection({
    super.key,
    required this.onGoToTab,
    required this.tourKey,
  });

  @override
  Widget build(BuildContext context) {
    return TourTarget(
      tourKey: tourKey,
      title: S().tourSummaryTitle,
      description: S().tourSummaryBody,
      child: BlocBuilder<MoneyPinCubit, MoneyPinState>(
        builder: (context, pinState) {
          if (pinState.stage != MoneyPinStage.unlocked) {
            return BlocBuilder<BookingsCubit, BookingsState>(
              builder: (context, bookingsState) {
                return BlocBuilder<
                  HomeServiceRequestsCubit,
                  HomeServiceRequestsState
                >(
                  builder: (context, homeServiceState) {
                    return MoneyLockedGrid(
                      pendingBookingsCount: bookingsState.pending.length,
                      homeServiceRequestsCount:
                          homeServiceState.requests.length,
                      queueCount: bookingsState.queue.length,
                      onPendingBookingsTap: () => onGoToTab(1),
                      onHomeServiceTap: () =>
                          context.push(Routes.barberHomeServiceRequestsScreen),
                      onQueueTap: () => onGoToTab(1),
                    );
                  },
                );
              },
            );
          }
          return BlocBuilder<EarningsCubit, EarningsState>(
            builder: (context, state) {
              if (state.status == EarningsStatus.failure) {
                return AppErrorState(
                  message: state.errorMessage,
                  onRetry: context.read<EarningsCubit>().loadEarnings,
                  compact: true,
                );
              }
              return HomeEarningsGrid(
                earnings: state.earnings,
                onTap: () => context.push(Routes.barberEarningsScreen),
              );
            },
          );
        },
      ),
    );
  }
}
