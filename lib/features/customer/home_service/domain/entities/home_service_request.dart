import 'package:equatable/equatable.dart';
import 'home_service_adjustment.dart';
import 'home_service_request_status.dart';

class HomeServiceRequest extends Equatable {
  final int id;
  final String code;
  final HomeServiceRequestStatus status;
  final bool anyNearby;
  final int? shopId;
  final String? shopName;
  final num? price;
  final num? finalPrice;
  final bool priceConfirmationPending;
  final List<HomeServiceAdjustment> adjustments;
  final String address;
  final double lat;
  final double lng;
  final String? note;
  final String? date;
  final String? time;
  final String createdAt;
  final String? broadcastExpiresAt;
  final String? acceptedAt;
  final String? onTheWayAt;
  final String? completedAt;
  final String? rejectionReason;
  final String? cancelReason;
  final bool ratedBarber;
  final bool ratedShop;

  const HomeServiceRequest({
    required this.id,
    required this.code,
    required this.status,
    this.anyNearby = false,
    this.shopId,
    this.shopName,
    this.price,
    this.finalPrice,
    required this.priceConfirmationPending,
    required this.adjustments,
    required this.address,
    required this.lat,
    required this.lng,
    this.note,
    this.date,
    this.time,
    required this.createdAt,
    this.broadcastExpiresAt,
    this.acceptedAt,
    this.onTheWayAt,
    this.completedAt,
    this.rejectionReason,
    this.cancelReason,
    this.ratedBarber = false,
    this.ratedShop = false,
  });

  HomeServiceRequest copyWith({bool? ratedBarber, bool? ratedShop}) {
    return HomeServiceRequest(
      id: id,
      code: code,
      status: status,
      anyNearby: anyNearby,
      shopId: shopId,
      shopName: shopName,
      price: price,
      finalPrice: finalPrice,
      priceConfirmationPending: priceConfirmationPending,
      adjustments: adjustments,
      address: address,
      lat: lat,
      lng: lng,
      note: note,
      date: date,
      time: time,
      createdAt: createdAt,
      broadcastExpiresAt: broadcastExpiresAt,
      acceptedAt: acceptedAt,
      onTheWayAt: onTheWayAt,
      completedAt: completedAt,
      rejectionReason: rejectionReason,
      cancelReason: cancelReason,
      ratedBarber: ratedBarber ?? this.ratedBarber,
      ratedShop: ratedShop ?? this.ratedShop,
    );
  }

  @override
  List<Object?> get props => [
    id,
    code,
    status,
    anyNearby,
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
    date,
    time,
    createdAt,
    broadcastExpiresAt,
    acceptedAt,
    onTheWayAt,
    completedAt,
    rejectionReason,
    cancelReason,
    ratedBarber,
    ratedShop,
  ];
}
