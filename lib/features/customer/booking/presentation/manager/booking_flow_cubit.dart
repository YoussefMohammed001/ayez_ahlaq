import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shops/domain/entities/shop_detail.dart';
import '../../domain/use_cases/create_booking_use_case.dart';
import '../../domain/use_cases/get_booking_slots_use_case.dart';
import 'booking_flow_state.dart';

class BookingFlowCubit extends Cubit<BookingFlowState> {
  final GetBookingSlotsUseCase _getSlots;
  final CreateBookingUseCase _createBooking;

  BookingFlowCubit(this._getSlots, this._createBooking) : super(const BookingFlowState());

  void startFlow(ShopDetail shopDetail) {
    emit(BookingFlowState(shopDetail: shopDetail));
  }

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

  void selectStyle({int? haircutStyleId, String? styleName, int priceDelta = 0}) {
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

  Future<void> loadSlots(String date) async {
    final serviceTypeId = state.serviceTypeId;
    if (serviceTypeId == null) return;

    emit(state.copyWith(status: BookingFlowStatus.loadingSlots, date: date));

    final result = await _getSlots(
      shopId: state.shopDetail!.shop.id,
      serviceTypeId: serviceTypeId,
      date: date,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: BookingFlowStatus.failure, errorMessage: failure.message),
      ),
      (slots) => emit(state.copyWith(status: BookingFlowStatus.slotsLoaded, slots: slots)),
    );
  }

  void selectSlotTime(String slotTime) {
    emit(state.copyWith(slotTime: slotTime));
  }

  void setPaymentMethod(String paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }

  void setNote(String? note) {
    emit(state.copyWith(note: note));
  }

  Future<void> submit() async {
    final serviceTypeId = state.serviceTypeId;
    final date = state.date;
    final slotTime = state.slotTime;
    if (serviceTypeId == null || date == null || slotTime == null) return;

    emit(state.copyWith(status: BookingFlowStatus.submitting));

    final result = await _createBooking(
      shopId: state.shopDetail!.shop.id,
      autoSelect: state.autoSelect,
      barberId: state.barberId,
      serviceTypeId: serviceTypeId,
      haircutStyleId: state.haircutStyleId,
      date: date,
      slotTime: slotTime,
      paymentMethod: state.paymentMethod,
      note: state.note,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: BookingFlowStatus.failure, errorMessage: failure.message),
      ),
      (booking) => emit(
        state.copyWith(status: BookingFlowStatus.success, createdBooking: booking),
      ),
    );
  }
}
