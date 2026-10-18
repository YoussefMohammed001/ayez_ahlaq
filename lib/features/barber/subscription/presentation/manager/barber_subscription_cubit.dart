import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_barber_subscription_plans_use_case.dart';
import '../../domain/use_cases/get_barber_subscription_use_case.dart';
import '../../domain/use_cases/subscribe_barber_use_case.dart';
import 'barber_subscription_state.dart';

class BarberSubscriptionCubit extends Cubit<BarberSubscriptionState> {
  final GetBarberSubscriptionUseCase _getSubscription;
  final GetBarberSubscriptionPlansUseCase _getPlans;
  final SubscribeBarberUseCase _subscribe;

  BarberSubscriptionCubit(
    this._getSubscription,
    this._getPlans,
    this._subscribe,
  ) : super(const BarberSubscriptionState());

  Future<void> load({bool force = false}) async {
    if (!force && state.status == BarberSubscriptionStatus.success) return;

    emit(state.copyWith(status: BarberSubscriptionStatus.loading));

    final subscriptionResult = await _getSubscription();
    final plansResult = await _getPlans();

    subscriptionResult.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberSubscriptionStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (subscription) => plansResult.fold(
        (failure) => emit(
          state.copyWith(
            status: BarberSubscriptionStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (plans) => emit(
          state.copyWith(
            status: BarberSubscriptionStatus.success,
            subscription: subscription,
            plans: plans,
          ),
        ),
      ),
    );
  }

  Future<bool> subscribe(int planId) async {
    emit(state.copyWith(subscribingPlanId: planId));

    final result = await _subscribe(planId);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            clearSubscribingPlanId: true,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (subscribeResult) {
        emit(
          state.copyWith(
            clearSubscribingPlanId: true,
            subscription: subscribeResult.subscription ?? state.subscription,
          ),
        );
        return true;
      },
    );
  }
}
