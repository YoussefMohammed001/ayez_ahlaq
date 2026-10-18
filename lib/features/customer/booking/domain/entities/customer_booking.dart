import 'package:equatable/equatable.dart';
import 'booking_addon.dart';
import 'customer_booking_status.dart';

class CustomerBooking extends Equatable {
  final int id;
  final String code;
  final CustomerBookingStatus status;
  final int shopId;
  final String shopName;
  final int barberId;
  final String barberName;
  final String serviceLabel;
  final String? styleName;
  final int basePrice;
  final int styleDelta;
  final int addonsTotal;
  final int addonsDiscount;
  final int totalPrice;
  final String bookingDate;
  final String slotTime;
  final String paymentMethod;
  final String? note;
  final int? queuePosition;
  final int? peopleAhead;
  final bool ratedBarber;
  final bool ratedShop;
  final List<BookingAddon> addons;

  const CustomerBooking({
    required this.id,
    required this.code,
    required this.status,
    required this.shopId,
    required this.shopName,
    required this.barberId,
    required this.barberName,
    required this.serviceLabel,
    required this.totalPrice,
    required this.bookingDate,
    required this.slotTime,
    required this.paymentMethod,
    required this.ratedBarber,
    required this.ratedShop,
    this.styleName,
    this.basePrice = 0,
    this.styleDelta = 0,
    this.addonsTotal = 0,
    this.addonsDiscount = 0,
    this.note,
    this.queuePosition,
    this.peopleAhead,
    this.addons = const [],
  });

  CustomerBooking copyWith({bool? ratedBarber, bool? ratedShop}) {
    return CustomerBooking(
      id: id,
      code: code,
      status: status,
      shopId: shopId,
      shopName: shopName,
      barberId: barberId,
      barberName: barberName,
      serviceLabel: serviceLabel,
      styleName: styleName,
      basePrice: basePrice,
      styleDelta: styleDelta,
      addonsTotal: addonsTotal,
      addonsDiscount: addonsDiscount,
      totalPrice: totalPrice,
      bookingDate: bookingDate,
      slotTime: slotTime,
      paymentMethod: paymentMethod,
      note: note,
      queuePosition: queuePosition,
      peopleAhead: peopleAhead,
      ratedBarber: ratedBarber ?? this.ratedBarber,
      ratedShop: ratedShop ?? this.ratedShop,
      addons: addons,
    );
  }

  DateTime? get startsAt => DateTime.tryParse('${bookingDate}T$slotTime');

  bool get hasStarted {
    final start = startsAt;
    return start != null && !DateTime.now().isBefore(start);
  }

  bool get canCancel => status.isCancellable && !hasStarted;

  bool get isSlotMissed => status.isCancellable && hasStarted;

  @override
  List<Object?> get props => [
    id,
    code,
    status,
    basePrice,
    styleDelta,
    addonsTotal,
    addonsDiscount,
    totalPrice,
    queuePosition,
    peopleAhead,
    ratedBarber,
    ratedShop,
    addons,
  ];
}
