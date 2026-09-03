import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_status.dart';
import 'booking_addon_model.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.code,
    required super.status,
    required super.barberId,
    required super.barberName,
    required super.customerId,
    required super.customerName,
    required super.customerPhone,
    required super.serviceTypeId,
    required super.serviceLabel,
    required super.basePrice,
    required super.styleDelta,
    required super.addonsTotal,
    required super.totalPrice,
    required super.durationMinutes,
    required super.bookingDate,
    required super.slotTime,
    required super.paymentMethod,
    required super.autoSelect,
    required super.walkIn,
    required super.nextStatuses,
    required super.addons,
    super.haircutStyleId,
    super.styleName,
    super.note,
    super.queuePosition,
    super.decisionDeadline,
    super.createdAt,
    super.confirmedAt,
    super.completedAt,
    super.cancelledAt,
    super.cancelReason,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final addons = (json['addons'] as List?) ?? const [];
    final next = (json['nextStatuses'] as List?) ?? const [];

    return BookingModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '#${json['id'] ?? ''}',
      status: BookingStatus.fromApi(json['status'] as String?),
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      customerId: (json['customerId'] as num?)?.toInt() ?? 0,
      customerName: json['customerName'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      serviceTypeId: (json['serviceTypeId'] as num?)?.toInt() ?? 0,
      serviceLabel: json['serviceLabel'] as String? ?? '',
      haircutStyleId: (json['haircutStyleId'] as num?)?.toInt(),
      styleName: json['styleName'] as String?,
      basePrice: (json['basePrice'] as num?)?.toInt() ?? 0,
      styleDelta: (json['styleDelta'] as num?)?.toInt() ?? 0,
      addonsTotal: (json['addonsTotal'] as num?)?.toInt() ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      bookingDate: json['bookingDate'] as String? ?? '',
      slotTime: json['slotTime'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      note: json['note'] as String?,
      autoSelect: json['autoSelect'] as bool? ?? false,
      walkIn: json['walkIn'] as bool? ?? false,
      queuePosition: (json['queuePosition'] as num?)?.toInt(),
      decisionDeadline: DateTime.tryParse(
        json['decisionDeadline'] as String? ?? '',
      ),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      confirmedAt: DateTime.tryParse(json['confirmedAt'] as String? ?? ''),
      completedAt: DateTime.tryParse(json['completedAt'] as String? ?? ''),
      cancelledAt: DateTime.tryParse(json['cancelledAt'] as String? ?? ''),
      cancelReason: json['cancelReason'] as String?,
      nextStatuses: next
          .map<BookingStatus>((e) => BookingStatus.fromApi(e as String?))
          .toList(),
      addons: addons
          .map<BookingAddonModel>(
            (e) => BookingAddonModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
