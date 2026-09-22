import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/create_home_service_request_use_case.dart';
import 'home_service_request_form_state.dart';

class HomeServiceRequestFormCubit extends Cubit<HomeServiceRequestFormState> {
  final CreateHomeServiceRequestUseCase _createRequest;

  HomeServiceRequestFormCubit(this._createRequest)
    : super(const HomeServiceRequestFormState());

  Future<bool> submit({
    required int shopId,
    required String address,
    required double lat,
    required double lng,
    String? note,
  }) async {
    emit(state.copyWith(status: HomeServiceRequestFormStatus.submitting));

    final result = await _createRequest(
      shopId: shopId,
      address: address,
      lat: lat,
      lng: lng,
      note: note,
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
