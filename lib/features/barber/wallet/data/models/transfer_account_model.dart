import '../../domain/entities/transfer_account.dart';

class TransferAccountModel extends TransferAccount {
  const TransferAccountModel({
    required super.id,
    required super.label,
    required super.accountNumber,
    super.holderName,
  });

  factory TransferAccountModel.fromJson(Map<String, dynamic> json) {
    return TransferAccountModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      holderName: json['holderName'] as String?,
    );
  }
}
