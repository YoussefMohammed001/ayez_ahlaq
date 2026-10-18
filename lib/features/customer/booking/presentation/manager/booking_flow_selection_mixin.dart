import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_booking_slots_use_case.dart';
import 'booking_flow_state.dart';

mixin BookingFlowSelectionMixin on Cubit<BookingFlowState> {
  GetBookingSlotsUseCase get getSlots;

  void selectService({
    required int serviceTypeId,
    required String serviceName,
    required int price,
  }) {
    emit(
      state.copyWith(
        serviceTypeId: serviceTypeId,
        serviceName: serviceName,
        servicePrice: price,
        clearStyle: true,
        clearBarber: true,
      ),
    );
  }

  void selectStyle({
    int? haircutStyleId,
    String? styleName,
    int priceDelta = 0,
  }) {
    if (haircutStyleId == null) {
      emit(state.copyWith(clearStyle: true));
      return;
    }
    emit(
      state.copyWith(
        haircutStyleId: haircutStyleId,
        styleName: styleName,
        styleDelta: priceDelta,
      ),
    );
  }

  void selectBarber({int? barberId, String? barberName}) {
    emit(
      state.copyWith(
        autoSelect: barberId == null,
        barberId: barberId,
        barberName: barberName,
        clearBarber: barberId == null,
      ),
    );
  }

  int _slotsRequestId = 0;

  Future<void> loadSlots(String date) async {
    final serviceTypeId = state.serviceTypeId;
    if (serviceTypeId == null) return;

    final requestId = ++_slotsRequestId;
    emit(
      state.copyWith(
        status: BookingFlowStatus.loadingSlots,
        date: date,
        clearSlots: true,
      ),
    );

    final result = await getSlots(
      shopId: state.shopDetail!.shop.id,
      serviceTypeId: serviceTypeId,
      date: date,
    );
    if (requestId != _slotsRequestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BookingFlowStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (slots) => emit(
        state.copyWith(status: BookingFlowStatus.slotsLoaded, slots: slots),
      ),
    );
  }
}
