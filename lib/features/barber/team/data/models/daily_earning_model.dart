import '../../domain/entities/daily_earning.dart';

class DailyEarningModel extends DailyEarning {
  const DailyEarningModel({
    required super.date,
    required super.amount,
    required super.clients,
  });

  factory DailyEarningModel.fromJson(Map<String, dynamic> json) {
    return DailyEarningModel(
      date: json['date'] as String? ?? '',
      amount: (json['amount'] as num?) ?? 0,
      clients: (json['clients'] as num?)?.toInt() ?? 0,
    );
  }
}
