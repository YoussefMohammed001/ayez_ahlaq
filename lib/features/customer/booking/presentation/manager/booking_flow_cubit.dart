import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shops/domain/entities/shop_addon.dart';
import '../../../shops/domain/entities/shop_drink.dart';
import '../../../shops/domain/entities/shop_detail.dart';
import '../../domain/use_cases/create_booking_use_case.dart';
import '../../domain/use_cases/get_booking_slots_use_case.dart';
import '../../domain/use_cases/get_bookings_use_case.dart';
import 'booking_flow_extras.dart';
import 'booking_flow_selection_mixin.dart';
import 'booking_flow_state.dart';
import 'same_day_booking_checker.dart';

class BookingFlowCubit extends Cubit<BookingFlowState> with BookingFlowSelectionMixin {
  @override
  final GetBookingSlotsUseCase getSlots;
  final CreateBookingUseCase _createBooking;
  final GetBookingsUseCase _getBookings;

  BookingFlowCubit(this.getSlots, this._createBooking, this._getBookings)
    : super(const BookingFlowState());

  void startFlow(ShopDetail shopDetail) {
    emit(BookingFlowState(shopDetail: shopDetail));
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

  void setAddonQuantity(ShopAddon addon, int quantity) {
    emit(
      state.copyWith(
        addons: BookingFlowExtras.withAddon(state.addons, addon, quantity),
      ),
    );
  }

  void setDrinkQuantity(ShopDrink drink, int quantity) {
    emit(
      state.copyWith(
        drinks: BookingFlowExtras.withDrink(state.drinks, drink, quantity),
      ),
    );
  }

  Future<bool> hasSameDayBooking() async {
    final date = state.date;
    if (date == null) return false;

    final result = await _getBookings();
    return result.fold(
      (_) => false,
      (bookings) => SameDayBookingChecker.hasConflict(bookings, date),
    );
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
      addons: state.addons,
      drinks: state.drinks,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: BookingFlowStatus.failure, errorMessage: failure.message),
      ),
      (result) => emit(
        state.copyWith(
          status: BookingFlowStatus.success,
          createdBooking: result.$1,
          successMessage: result.$2,
        ),
      ),
    );
  }
}
