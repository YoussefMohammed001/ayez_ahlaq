import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/create_home_service_request_use_case.dart';
import '../../domain/use_cases/retry_home_service_request_use_case.dart';
import 'home_service_request_form_state.dart';

class HomeServiceRequestFormCubit extends Cubit<HomeServiceRequestFormState> {
  final CreateHomeServiceRequestUseCase _createRequest;
  final RetryHomeServiceRequestUseCase _retryRequest;

  HomeServiceRequestFormCubit(this._createRequest, this._retryRequest)
    : super(const HomeServiceRequestFormState());

  void reset() => emit(const HomeServiceRequestFormState());

  Future<bool> submit({
    int? retryRequestId,
    int? shopId,
    bool anyNearby = false,
    required String address,
    required double lat,
    required double lng,
    String? note,
    required String date,
    required String time,
  }) async {
    emit(state.copyWith(status: HomeServiceRequestFormStatus.submitting));

    final result = retryRequestId == null
        ? await _createRequest(
            shopId: shopId,
            anyNearby: anyNearby,
            address: address,
            lat: lat,
            lng: lng,
            note: note,
            date: date,
            time: time,
          )
        : await _retryRequest(
            id: retryRequestId,
            shopId: shopId,
            anyNearby: anyNearby,
            address: address,
            lat: lat,
            lng: lng,
            note: note,
            date: date,
            time: time,
          );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeServiceRequestFormStatus.failure,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (request) {
        emit(
          state.copyWith(
            status: HomeServiceRequestFormStatus.success,
            createdRequestId: request.id,
          ),
        );
        return true;
      },
    );
  }
}
