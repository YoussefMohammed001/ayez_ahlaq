import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/rating_target.dart';
import '../../domain/use_cases/cancel_home_service_request_use_case.dart';
import '../../domain/use_cases/confirm_home_service_price_use_case.dart';
import '../../domain/use_cases/get_home_service_request_use_case.dart';
import '../../domain/use_cases/rate_home_service_request_use_case.dart';
import 'home_service_request_detail_state.dart';

class HomeServiceRequestDetailCubit
    extends Cubit<HomeServiceRequestDetailState> {
  final GetHomeServiceRequestUseCase _getRequest;
  final ConfirmHomeServicePriceUseCase _confirmPrice;
  final CancelHomeServiceRequestUseCase _cancelRequest;
  final RateHomeServiceRequestUseCase _rateRequest;

  HomeServiceRequestDetailCubit(
    this._getRequest,
    this._confirmPrice,
    this._cancelRequest,
    this._rateRequest,
  ) : super(const HomeServiceRequestDetailState());

  int? _requestedRequestId;

  Future<void> loadRequest(int id, {bool isRefresh = false}) async {
    _requestedRequestId = id;
    emit(
      isRefresh
          ? state.copyWith(status: HomeServiceRequestDetailStatus.loading)
          : const HomeServiceRequestDetailState(
              status: HomeServiceRequestDetailStatus.loading,
            ),
    );

    final result = await _getRequest(id);
    if (_requestedRequestId != id) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeServiceRequestDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (request) => emit(
        state.copyWith(
          status: HomeServiceRequestDetailStatus.success,
          request: request,
        ),
      ),
    );
  }

  Future<bool> confirmPrice(int id) async {
    emit(state.copyWith(isConfirmingPrice: true));

    final result = await _confirmPrice(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            isConfirmingPrice: false,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (request) {
        emit(
          state.copyWith(
            isConfirmingPrice: false,
            request: request,
            errorMessage: null,
          ),
        );
        return true;
      },
    );
  }

  Future<bool> cancel(int id) async {
    emit(state.copyWith(isCancelling: true));

    final result = await _cancelRequest(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isCancelling: false, errorMessage: failure.message),
        );
        return false;
      },
      (request) {
        emit(
          state.copyWith(
            isCancelling: false,
            request: request,
            errorMessage: null,
          ),
        );
        return true;
      },
    );
  }

  Future<bool> rate({
    required RatingTarget target,
    required int stars,
    String? note,
  }) async {
    final request = state.request;
    if (request == null) return false;

    emit(state.copyWith(isRating: true));

    final result = await _rateRequest(
      homeServiceRequestId: request.id,
      target: target,
      stars: stars,
      note: note,
    );

    return result.fold(
      (failure) {
        emit(state.copyWith(isRating: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(
          state.copyWith(
            isRating: false,
            request: request.copyWith(
              ratedBarber: target == RatingTarget.barber ? true : null,
              ratedShop: target == RatingTarget.shop ? true : null,
            ),
            errorMessage: null,
          ),
        );
        return true;
      },
    );
  }
}
