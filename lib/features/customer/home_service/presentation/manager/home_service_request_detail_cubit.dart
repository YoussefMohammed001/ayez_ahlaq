import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/cancel_home_service_request_use_case.dart';
import '../../domain/use_cases/confirm_home_service_price_use_case.dart';
import '../../domain/use_cases/get_home_service_request_use_case.dart';
import 'home_service_request_detail_state.dart';

class HomeServiceRequestDetailCubit extends Cubit<HomeServiceRequestDetailState> {
  final GetHomeServiceRequestUseCase _getRequest;
  final ConfirmHomeServicePriceUseCase _confirmPrice;
  final CancelHomeServiceRequestUseCase _cancelRequest;

  HomeServiceRequestDetailCubit(
    this._getRequest,
    this._confirmPrice,
    this._cancelRequest,
  ) : super(const HomeServiceRequestDetailState());

  Future<void> loadRequest(int id) async {
    emit(state.copyWith(status: HomeServiceRequestDetailStatus.loading));

    final result = await _getRequest(id);

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
          state.copyWith(isConfirmingPrice: false, errorMessage: failure.message),
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
        emit(state.copyWith(isCancelling: false, errorMessage: failure.message));
        return false;
      },
      (request) {
        emit(
          state.copyWith(isCancelling: false, request: request, errorMessage: null),
        );
        return true;
      },
    );
  }
}
