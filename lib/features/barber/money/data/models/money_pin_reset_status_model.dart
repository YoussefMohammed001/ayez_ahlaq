import '../../domain/entities/money_pin_reset_status.dart';

class MoneyPinResetStatusModel extends MoneyPinResetStatus {
  const MoneyPinResetStatusModel({
    required super.pending,
    super.lastStatus,
    super.lastResolution,
    super.lastAdminNote,
    super.lastRequestedAt,
  });

  factory MoneyPinResetStatusModel.fromJson(Map<String, dynamic> json) {
    return MoneyPinResetStatusModel(
      pending: json['pending'] as bool? ?? false,
      lastStatus: json['lastStatus'] as String?,
      lastResolution: json['lastResolution'] as String?,
      lastAdminNote: json['lastAdminNote'] as String?,
      lastRequestedAt: DateTime.tryParse(json['lastRequestedAt'] as String? ?? ''),
    );
  }
}
