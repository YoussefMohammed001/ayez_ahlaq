import '../../domain/entities/home_service_broadcast.dart';

class HomeServiceBroadcastModel extends HomeServiceBroadcast {
  const HomeServiceBroadcastModel({
    required super.candidateId,
    required super.requestId,
    required super.requestCode,
    required super.candidateStatus,
    required super.requestStatus,
    required super.address,
    super.distanceKm,
    super.note,
    required super.date,
    required super.time,
    super.suggestedPrice,
    super.expiresAt,
  });

  factory HomeServiceBroadcastModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceBroadcastModel(
      candidateId: (json['candidateId'] as num?)?.toInt() ?? 0,
      requestId: (json['requestId'] as num?)?.toInt() ?? 0,
      requestCode: json['code'] as String? ?? '',
      candidateStatus: json['candidateStatus'] as String? ?? 'PENDING',
      requestStatus: json['requestStatus'] as String? ?? 'PENDING',
      address: json['address'] as String? ?? '',
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      note: json['note'] as String?,
      date: json['scheduledDate'] as String? ?? '',
      time: json['scheduledTime'] as String? ?? '',
      suggestedPrice: json['suggestedPrice'] as num?,
      expiresAt: json['expiresAt'] as String?,
    );
  }
}
