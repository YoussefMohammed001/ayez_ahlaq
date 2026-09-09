import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/wallet_request_status.dart';
import '../../domain/entities/wallet_request_type.dart';

class WalletRequestModel extends WalletRequest {
  const WalletRequestModel({
    required super.id,
    required super.code,
    required super.ownerType,
    required super.ownerId,
    required super.ownerName,
    required super.ownerPhone,
    required super.type,
    required super.amount,
    super.note,
    required super.hasAttachment,
    super.attachmentName,
    required super.status,
    super.decisionNote,
    super.decidedByName,
    super.decidedAt,
    super.createdAt,
  });

  factory WalletRequestModel.fromJson(Map<String, dynamic> json) {
    return WalletRequestModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      ownerType: json['ownerType'] as String? ?? '',
      ownerId: (json['ownerId'] as num?)?.toInt() ?? 0,
      ownerName: json['ownerName'] as String? ?? '',
      ownerPhone: json['ownerPhone'] as String? ?? '',
      type: WalletRequestType.fromApi(json['type'] as String?),
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
      hasAttachment: json['hasAttachment'] as bool? ?? false,
      attachmentName: json['attachmentName'] as String?,
      status: WalletRequestStatus.fromApi(json['status'] as String?),
      decisionNote: json['decisionNote'] as String?,
      decidedByName: json['decidedByName'] as String?,
      decidedAt: DateTime.tryParse(json['decidedAt'] as String? ?? ''),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
