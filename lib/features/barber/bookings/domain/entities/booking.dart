import 'package:equatable/equatable.dart';
import 'booking_addon.dart';
import 'booking_status.dart';

class Booking extends Equatable {
  final int id;
  final String code;
  final BookingStatus status;
  final int barberId;
  final String barberName;
  final int customerId;
  final String customerName;
  final String customerPhone;
  final int serviceTypeId;
  final String serviceLabel;
  final int? haircutStyleId;
  final String? styleName;
  final int basePrice;
  final int styleDelta;
  final int addonsTotal;
  final int totalPrice;
  final int durationMinutes;
  final String bookingDate;
  final String slotTime;
  final String paymentMethod;
  final String? note;
  final bool autoSelect;
  final bool walkIn;
  final int? queuePosition;
  final DateTime? decisionDeadline;
  final DateTime? createdAt;
  final DateTime? confirmedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final String? cancelReason;
  final List<BookingStatus> nextStatuses;
  final List<BookingAddon> addons;

  const Booking({
    required this.id,
    required this.code,
    required this.status,
    required this.barberId,
    required this.barberName,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.serviceTypeId,
    required this.serviceLabel,
    required this.basePrice,
    required this.styleDelta,
    required this.addonsTotal,
    required this.totalPrice,
    required this.durationMinutes,
    required this.bookingDate,
    required this.slotTime,
    required this.paymentMethod,
    required this.autoSelect,
    required this.walkIn,
    required this.nextStatuses,
    required this.addons,
    this.haircutStyleId,
    this.styleName,
    this.note,
    this.queuePosition,
    this.decisionDeadline,
    this.createdAt,
    this.confirmedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancelReason,
  });

  bool get canAdvance => nextStatuses.isNotEmpty;

  Booking copyWith({BookingStatus? status, List<BookingStatus>? nextStatuses}) {
    return Booking(
      id: id,
      code: code,
      status: status ?? this.status,
      barberId: barberId,
      barberName: barberName,
      customerId: customerId,
      customerName: customerName,
      customerPhone: customerPhone,
      serviceTypeId: serviceTypeId,
      serviceLabel: serviceLabel,
      haircutStyleId: haircutStyleId,
      styleName: styleName,
      basePrice: basePrice,
      styleDelta: styleDelta,
      addonsTotal: addonsTotal,
      totalPrice: totalPrice,
      durationMinutes: durationMinutes,
      bookingDate: bookingDate,
      slotTime: slotTime,
      paymentMethod: paymentMethod,
      note: note,
      autoSelect: autoSelect,
      walkIn: walkIn,
      queuePosition: queuePosition,
      decisionDeadline: decisionDeadline,
      createdAt: createdAt,
      confirmedAt: confirmedAt,
      completedAt: completedAt,
      cancelledAt: cancelledAt,
      cancelReason: cancelReason,
      nextStatuses: nextStatuses ?? this.nextStatuses,
      addons: addons,
    );
  }

  @override
  List<Object?> get props => [id, code, status, totalPrice, nextStatuses];
}
