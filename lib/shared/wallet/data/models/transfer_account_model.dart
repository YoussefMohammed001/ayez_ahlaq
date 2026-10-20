import '../../domain/entities/transfer_account.dart';

class TransferAccountModel extends TransferAccount {
  const TransferAccountModel({
    required super.id,
    required super.type,
    required super.mobileNumber,
    required super.label,
  });

  factory TransferAccountModel.fromJson(Map<String, dynamic> json) {
    return TransferAccountModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      mobileNumber: json['mobileNumber'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }
}
