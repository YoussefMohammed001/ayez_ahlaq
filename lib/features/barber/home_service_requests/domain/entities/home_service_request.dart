import 'package:equatable/equatable.dart';
import 'home_service_request_adjustment.dart';
import 'home_service_request_status.dart';

class HomeServiceRequest extends Equatable {
  final int id;
  final String code;
  final HomeServiceRequestStatus status;
  final String customerName;
  final String customerPhone;
  final num price;
  final num? finalPrice;
  final bool priceConfirmationPending;
  final String address;
  final double lat;
  final double lng;
  final double? distanceKm;
  final String? note;
  final String createdAt;
  final String? acceptedAt;
  final String? onTheWayAt;
  final String? completedAt;
  final String? rejectedAt;
  final String? rejectionReason;
  final String? cancelledAt;
  final String? cancelReason;
  final List<HomeServiceRequestAdjustment> adjustments;
  final List<HomeServiceRequestStatus> nextStatuses;

  const HomeServiceRequest({
    required this.id,
    required this.code,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.price,
    this.finalPrice,
    required this.priceConfirmationPending,
    required this.address,
    required this.lat,
    required this.lng,
    this.distanceKm,
    this.note,
    required this.createdAt,
    this.acceptedAt,
    this.onTheWayAt,
    this.completedAt,
    this.rejectedAt,
    this.rejectionReason,
    this.cancelledAt,
    this.cancelReason,
    required this.adjustments,
    required this.nextStatuses,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    status,
    customerName,
    customerPhone,
    price,
    finalPrice,
    priceConfirmationPending,
    address,
    lat,
    lng,
    distanceKm,
    note,
    createdAt,
    acceptedAt,
    onTheWayAt,
    completedAt,
    rejectedAt,
    rejectionReason,
    cancelledAt,
    cancelReason,
    adjustments,
    nextStatuses,
  ];
}
