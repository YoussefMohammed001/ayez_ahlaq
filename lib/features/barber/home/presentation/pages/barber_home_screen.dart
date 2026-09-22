import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../bookings/presentation/manager/bookings_state.dart';
import '../../../documents/presentation/manager/barber_documents_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../profile/presentation/manager/barber_profile_state.dart';
import '../../../subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../../subscription/presentation/manager/barber_subscription_state.dart';
import '../../../subscription/presentation/widgets/subscription_home_card.dart';
import '../../../storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../../team/presentation/manager/earnings_cubit.dart';
import '../../../team/presentation/manager/earnings_state.dart';
import '../../../money/presentation/manager/money_pin_cubit.dart';
import '../../../money/presentation/manager/money_pin_state.dart';
import '../../../money/presentation/widgets/money_locked_grid.dart';
import '../../../home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_cubit.dart';
import '../widgets/barber_home_greeting.dart';
import '../widgets/home_alert_cards.dart';
import '../widgets/home_earnings_grid.dart';
import '../widgets/home_pending_section.dart';
import '../widgets/home_queue_section.dart';

class BarberHomeScreen extends StatelessWidget {
  final ValueChanged<int> onGoToTab;

  const BarberHomeScreen({super.key, required this.onGoToTab});

  Future<void> _refresh(BuildContext context) {
    return Future.wait([
      context.read<BarberProfileCubit>().loadProfile(),
      context.read<EarningsCubit>().loadEarnings(),
      context.read<BookingsCubit>().loadPending(),
      context.read<BookingsCubit>().loadQueue(),
      context.read<BarberSubscriptionCubit>().load(),
      context.read<BarberStorefrontOrdersCubit>().loadOrders(),
      context.read<HomeServiceSettingsCubit>().loadSettings(),
      context.read<HomeServiceRequestsCubit>().loadPending(),
      context.read<BarberDocumentsCubit>().loadDocuments(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshableStateView(
          onRefresh: () => _refresh(context),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<BarberProfileCubit, BarberProfileState>(
                  builder: (context, state) => BarberHomeGreeting(
                    shopName: state.profile?.shopName ?? '',
                    onAvatarTap: () => onGoToTab(3),
                    onNotificationsTap: () =>
                        context.push(Routes.barberNotificationsScreen),
                  ),
                ),
                SizedBox(height: 18.h),
                BlocBuilder<MoneyPinCubit, MoneyPinState>(
                  builder: (context, pinState) {
                    if (pinState.stage != MoneyPinStage.unlocked) {
                      return MoneyLockedGrid(
                        onTap: () => context.push(Routes.barberEarningsPinScreen),
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
                SizedBox(height: 14.h),
                BlocBuilder<BarberSubscriptionCubit, BarberSubscriptionState>(
                  builder: (context, state) {
                    final subscription = state.subscription;
                    if (subscription == null) return const SizedBox.shrink();
                    return SubscriptionHomeCard(
                      subscription: subscription,
                      onTap: () => context.push(Routes.barberSubscriptionScreen),
                    );
                  },
                ),
                SizedBox(height: 14.h),
                const HomeAlertCards(),
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomePendingSection(
                        pending: state.pending,
                        onSeeAll: () => onGoToTab(1),
                      ),
                      HomeQueueSection(
                        queue: state.queue,
                        onSeeAll: () => onGoToTab(1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
