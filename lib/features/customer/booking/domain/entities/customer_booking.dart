import 'package:equatable/equatable.dart';
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
  final int totalPrice;
  final String bookingDate;
  final String slotTime;
  final String paymentMethod;
  final String? note;
  final int? queuePosition;
  final int? peopleAhead;
  final bool ratedBarber;
  final bool ratedShop;

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
    this.note,
    this.queuePosition,
    this.peopleAhead,
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
      totalPrice: totalPrice,
      bookingDate: bookingDate,
      slotTime: slotTime,
      paymentMethod: paymentMethod,
      note: note,
      queuePosition: queuePosition,
      peopleAhead: peopleAhead,
      ratedBarber: ratedBarber ?? this.ratedBarber,
      ratedShop: ratedShop ?? this.ratedShop,
    );
  }

  @override
  List<Object?> get props => [id, code, status, totalPrice, queuePosition, peopleAhead, ratedBarber, ratedShop];
}
