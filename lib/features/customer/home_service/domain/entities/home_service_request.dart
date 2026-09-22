import 'package:equatable/equatable.dart';
import 'home_service_adjustment.dart';
import 'home_service_request_status.dart';

class HomeServiceRequest extends Equatable {
  final int id;
  final String code;
  final HomeServiceRequestStatus status;
  final int shopId;
  final String shopName;
  final num price;
  final num? finalPrice;
  final bool priceConfirmationPending;
  final List<HomeServiceAdjustment> adjustments;
  final String address;
  final double lat;
  final double lng;
  final String? note;
  final String createdAt;
  final String? acceptedAt;
  final String? onTheWayAt;
  final String? completedAt;
  final String? rejectionReason;
  final String? cancelReason;

  const HomeServiceRequest({
    required this.id,
    required this.code,
    required this.status,
    required this.shopId,
    required this.shopName,
    required this.price,
    this.finalPrice,
    required this.priceConfirmationPending,
    required this.adjustments,
    required this.address,
    required this.lat,
    required this.lng,
    this.note,
    required this.createdAt,
    this.acceptedAt,
    this.onTheWayAt,
    this.completedAt,
    this.rejectionReason,
    this.cancelReason,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    status,
    shopId,
    shopName,
    price,
    finalPrice,
    priceConfirmationPending,
    adjustments,
    address,
    lat,
    lng,
    note,
    createdAt,
    acceptedAt,
    onTheWayAt,
    completedAt,
    rejectionReason,
    cancelReason,
  ];
}
