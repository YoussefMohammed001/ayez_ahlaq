import 'package:equatable/equatable.dart';
import '../../../shops/domain/entities/shop_detail.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';
import '../../domain/entities/booking_slots.dart';
import '../../domain/entities/customer_booking.dart';

enum BookingFlowStatus {
  initial,
  loadingSlots,
  slotsLoaded,
  submitting,
  success,
  failure,
}

class BookingFlowState extends Equatable {
  final BookingFlowStatus status;
  final ShopDetail? shopDetail;
  final int? serviceTypeId;
  final String? serviceName;
  final int servicePrice;
  final int? haircutStyleId;
  final String? styleName;
  final int styleDelta;
  final int? barberId;
  final String? barberName;
  final bool autoSelect;
  final String? date;
  final String? slotTime;
  final String paymentMethod;
  final String? note;
  final BookingSlots? slots;
  final CustomerBooking? createdBooking;
  final String? successMessage;
  final String? errorMessage;
  final List<BookingAddon> addons;
  final List<BookingDrink> drinks;

  const BookingFlowState({
    this.status = BookingFlowStatus.initial,
    this.shopDetail,
    this.serviceTypeId,
    this.serviceName,
    this.servicePrice = 0,
    this.haircutStyleId,
    this.styleName,
    this.styleDelta = 0,
    this.barberId,
    this.barberName,
    this.autoSelect = true,
    this.date,
    this.slotTime,
    this.paymentMethod = 'CASH',
    this.note,
    this.slots,
    this.createdBooking,
    this.successMessage,
    this.errorMessage,
    this.addons = const [],
    this.drinks = const [],
  });

  int get addonsTotal =>
      addons.fold(0, (sum, addon) => sum + (addon.price ?? 0) * addon.quantity);

  int get drinksTotal =>
      drinks.fold(0, (sum, drink) => sum + (drink.price ?? 0) * drink.quantity);

  int get totalPrice => servicePrice + styleDelta + addonsTotal + drinksTotal;

  BookingFlowState copyWith({
    BookingFlowStatus? status,
    int? serviceTypeId,
    String? serviceName,
    int? servicePrice,
    int? haircutStyleId,
    String? styleName,
    int? styleDelta,
    int? barberId,
    String? barberName,
    bool? autoSelect,
    String? date,
    String? slotTime,
    String? paymentMethod,
    String? note,
    BookingSlots? slots,
    CustomerBooking? createdBooking,
    String? successMessage,
    String? errorMessage,
    List<BookingAddon>? addons,
    List<BookingDrink>? drinks,
    bool clearBarber = false,
    bool clearStyle = false,
    bool clearSlots = false,
  }) {
    return BookingFlowState(
      status: status ?? this.status,
      shopDetail: shopDetail,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      serviceName: serviceName ?? this.serviceName,
      servicePrice: servicePrice ?? this.servicePrice,
      haircutStyleId: clearStyle
          ? null
          : (haircutStyleId ?? this.haircutStyleId),
      styleName: clearStyle ? null : (styleName ?? this.styleName),
      styleDelta: clearStyle ? 0 : (styleDelta ?? this.styleDelta),
      barberId: clearBarber ? null : (barberId ?? this.barberId),
      barberName: clearBarber ? null : (barberName ?? this.barberName),
      autoSelect: autoSelect ?? this.autoSelect,
      date: date ?? this.date,
      slotTime: clearSlots ? null : (slotTime ?? this.slotTime),
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      slots: clearSlots ? null : (slots ?? this.slots),
      createdBooking: createdBooking ?? this.createdBooking,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage,
      addons: addons ?? this.addons,
      drinks: drinks ?? this.drinks,
    );
  }

  @override
  List<Object?> get props => [
    status,
    shopDetail,
    serviceTypeId,
    haircutStyleId,
    barberId,
    autoSelect,
    date,
    slotTime,
    paymentMethod,
    note,
    slots,
    createdBooking,
    successMessage,
    errorMessage,
    addons,
    drinks,
  ];
}
