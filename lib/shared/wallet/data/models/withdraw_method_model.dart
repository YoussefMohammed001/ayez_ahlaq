import '../../domain/entities/withdraw_method.dart';

class WithdrawMethodModel extends WithdrawMethod {
  const WithdrawMethodModel({required super.id, required super.name});

  factory WithdrawMethodModel.fromJson(Map<String, dynamic> json) {
    return WithdrawMethodModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
