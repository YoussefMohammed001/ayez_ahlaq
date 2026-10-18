import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_request_status.dart';
import 'home_service_adjustment_model.dart';

class HomeServiceRequestModel extends HomeServiceRequest {
  const HomeServiceRequestModel({
    required super.id,
    required super.code,
    required super.status,
    super.anyNearby,
    super.shopId,
    super.shopName,
    super.price,
    super.finalPrice,
    required super.priceConfirmationPending,
    required super.adjustments,
    required super.address,
    required super.lat,
    required super.lng,
    super.note,
    super.date,
    super.time,
    required super.createdAt,
    super.broadcastExpiresAt,
    super.acceptedAt,
    super.onTheWayAt,
    super.completedAt,
    super.rejectionReason,
    super.cancelReason,
    super.ratedBarber,
    super.ratedShop,
  });

  factory HomeServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceRequestModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      status: HomeServiceRequestStatus.fromApi(json['status'] as String?),
      anyNearby: json['broadcast'] as bool? ?? false,
      shopId: (json['shopId'] as num?)?.toInt(),
      shopName: json['shopName'] as String?,
      price: json['price'] as num?,
      finalPrice: json['finalPrice'] as num?,
      priceConfirmationPending:
          json['priceConfirmationPending'] as bool? ?? false,
      adjustments: (json['adjustments'] as List<dynamic>? ?? [])
          .map(
            (e) =>
                HomeServiceAdjustmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      address: json['address'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      note: json['note'] as String?,
      date: json['scheduledDate'] as String?,
      time: json['scheduledTime'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      broadcastExpiresAt: json['broadcastExpiresAt'] as String?,
      acceptedAt: json['acceptedAt'] as String?,
      onTheWayAt: json['onTheWayAt'] as String?,
      completedAt: json['completedAt'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      cancelReason: json['cancelReason'] as String?,
      ratedBarber: json['ratedBarber'] as bool? ?? false,
      ratedShop: json['ratedShop'] as bool? ?? false,
    );
  }
}
