import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_request_status.dart';
import 'home_service_request_adjustment_model.dart';

class HomeServiceRequestModel extends HomeServiceRequest {
  const HomeServiceRequestModel({
    required super.id,
    required super.code,
    required super.status,
    required super.customerName,
    required super.customerPhone,
    required super.price,
    super.finalPrice,
    required super.priceConfirmationPending,
    required super.address,
    required super.lat,
    required super.lng,
    super.distanceKm,
    super.note,
    required super.createdAt,
    super.acceptedAt,
    super.onTheWayAt,
    super.completedAt,
    super.rejectedAt,
    super.rejectionReason,
    super.cancelledAt,
    super.cancelReason,
    required super.adjustments,
    required super.nextStatuses,
  });

  factory HomeServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceRequestModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      status: HomeServiceRequestStatus.fromApi(json['status'] as String?),
      customerName: json['customerName'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      finalPrice: json['finalPrice'] as num?,
      priceConfirmationPending:
          json['priceConfirmationPending'] as bool? ?? false,
      address: json['address'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      note: json['note'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      acceptedAt: json['acceptedAt'] as String?,
      onTheWayAt: json['onTheWayAt'] as String?,
      completedAt: json['completedAt'] as String?,
      rejectedAt: json['rejectedAt'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
      cancelReason: json['cancelReason'] as String?,
      adjustments: (json['adjustments'] as List<dynamic>? ?? [])
          .map(
            (e) => HomeServiceRequestAdjustmentModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      nextStatuses: (json['nextStatuses'] as List<dynamic>? ?? [])
          .map((e) => HomeServiceRequestStatus.fromApi(e as String?))
          .toList(),
    );
  }
}
