import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_merchant_subscription_plans_use_case.dart';
import '../../domain/use_cases/get_merchant_subscription_use_case.dart';
import '../../domain/use_cases/subscribe_merchant_use_case.dart';
import 'merchant_subscription_state.dart';

class MerchantSubscriptionCubit extends Cubit<MerchantSubscriptionState> {
  final GetMerchantSubscriptionUseCase _getSubscription;
  final GetMerchantSubscriptionPlansUseCase _getPlans;
  final SubscribeMerchantUseCase _subscribe;

  MerchantSubscriptionCubit(this._getSubscription, this._getPlans, this._subscribe)
    : super(const MerchantSubscriptionState());

  Future<void> load() async {
    emit(state.copyWith(status: MerchantSubscriptionStatus.loading));

    final subscriptionResult = await _getSubscription();
    final plansResult = await _getPlans();

    subscriptionResult.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantSubscriptionStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (subscription) => plansResult.fold(
        (failure) => emit(
          state.copyWith(
            status: MerchantSubscriptionStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (plans) => emit(
          state.copyWith(
            status: MerchantSubscriptionStatus.success,
            subscription: subscription,
            plans: plans,
          ),
        ),
      ),
    );
  }

  Future<bool?> subscribe(int planId) async {
    emit(state.copyWith(subscribingPlanId: planId));

    final result = await _subscribe(planId);

    final failure = result.fold((failure) => failure, (_) => null);
    if (failure != null) {
      emit(state.copyWith(clearSubscribingPlanId: true, errorMessage: failure.message));
      return null;
    }

    emit(state.copyWith(clearSubscribingPlanId: true));
    await load();
    return result.fold((_) => null, (subscribeResult) => subscribeResult.activated);
  }
}
