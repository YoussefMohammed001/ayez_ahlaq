import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_request_status.dart';
import 'home_service_adjustment_model.dart';

class HomeServiceRequestModel extends HomeServiceRequest {
  const HomeServiceRequestModel({
    required super.id,
    required super.code,
    required super.status,
    required super.shopId,
    required super.shopName,
    required super.price,
    super.finalPrice,
    required super.priceConfirmationPending,
    required super.adjustments,
    required super.address,
    required super.lat,
    required super.lng,
    super.note,
    required super.createdAt,
    super.acceptedAt,
    super.onTheWayAt,
    super.completedAt,
    super.rejectionReason,
    super.cancelReason,
  });

  factory HomeServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceRequestModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      status: HomeServiceRequestStatus.fromApi(json['status'] as String?),
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      finalPrice: json['finalPrice'] as num?,
      priceConfirmationPending:
          json['priceConfirmationPending'] as bool? ?? false,
      adjustments: (json['adjustments'] as List<dynamic>? ?? [])
          .map(
            (e) => HomeServiceAdjustmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      address: json['address'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      note: json['note'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      acceptedAt: json['acceptedAt'] as String?,
      onTheWayAt: json['onTheWayAt'] as String?,
      completedAt: json['completedAt'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      cancelReason: json['cancelReason'] as String?,
    );
  }
}
