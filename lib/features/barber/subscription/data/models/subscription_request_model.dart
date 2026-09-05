import '../../domain/entities/subscription_request.dart';

class SubscriptionRequestModel extends SubscriptionRequest {
  const SubscriptionRequestModel({
    required super.id,
    required super.code,
    required super.ownerType,
    required super.ownerId,
    required super.ownerName,
    required super.planId,
    required super.planName,
    required super.price,
    required super.type,
    required super.status,
    super.decisionNote,
    super.decidedByName,
    super.decidedAt,
    required super.createdAt,
  });

  factory SubscriptionRequestModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionRequestModel(
      id: json['id'] as int,
      code: json['code'] as String? ?? '',
      ownerType: json['ownerType'] as String? ?? '',
      ownerId: json['ownerId'] as int? ?? 0,
      ownerName: json['ownerName'] as String? ?? '',
      planId: json['planId'] as int? ?? 0,
      planName: json['planName'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      decisionNote: json['decisionNote'] as String?,
      decidedByName: json['decidedByName'] as String?,
      decidedAt: DateTime.tryParse(json['decidedAt'] as String? ?? ''),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
