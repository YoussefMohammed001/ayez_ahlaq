import '../../domain/entities/customer_booking.dart';
import '../../domain/entities/customer_booking_status.dart';
import 'booking_addon_model.dart';

class CustomerBookingModel extends CustomerBooking {
  const CustomerBookingModel({
    required super.id,
    required super.code,
    required super.status,
    required super.shopId,
    required super.shopName,
    required super.barberId,
    required super.barberName,
    required super.serviceLabel,
    required super.totalPrice,
    required super.bookingDate,
    required super.slotTime,
    required super.paymentMethod,
    required super.ratedBarber,
    required super.ratedShop,
    super.styleName,
    super.note,
    super.queuePosition,
    super.peopleAhead,
    super.addons,
  });

  factory CustomerBookingModel.fromJson(Map<String, dynamic> json) {
    return CustomerBookingModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '#${json['id'] ?? ''}',
      status: CustomerBookingStatus.fromApi(json['status'] as String?),
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      serviceLabel: json['serviceLabel'] as String? ?? '',
      styleName: json['styleName'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt() ?? 0,
      bookingDate: json['bookingDate'] as String? ?? '',
      slotTime: json['slotTime'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      note: json['note'] as String?,
      queuePosition: (json['queuePosition'] as num?)?.toInt(),
      peopleAhead: (json['peopleAhead'] as num?)?.toInt(),
      ratedBarber: json['ratedBarber'] as bool? ?? false,
      ratedShop: json['ratedShop'] as bool? ?? false,
      addons: (json['addons'] as List<dynamic>? ?? [])
          .map((e) => BookingAddonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
