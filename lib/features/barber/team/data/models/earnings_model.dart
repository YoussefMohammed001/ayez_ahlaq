import '../../domain/entities/earnings.dart';
import 'daily_earning_model.dart';

class EarningsModel extends Earnings {
  const EarningsModel({
    required super.today,
    required super.last7Days,
    required super.thisMonth,
    required super.clientsToday,
    required super.clientsThisMonth,
    required super.avgTicket,
    required super.supplierSpendThisMonth,
    required super.netThisMonth,
    required super.dailyLast7,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    final daily = json['dailyLast7'] as List? ?? const [];

    return EarningsModel(
      today: (json['today'] as num?) ?? 0,
      last7Days: (json['last7Days'] as num?) ?? 0,
      thisMonth: (json['thisMonth'] as num?) ?? 0,
      clientsToday: (json['clientsToday'] as num?)?.toInt() ?? 0,
      clientsThisMonth: (json['clientsThisMonth'] as num?)?.toInt() ?? 0,
      avgTicket: (json['avgTicket'] as num?) ?? 0,
      supplierSpendThisMonth: (json['supplierSpendThisMonth'] as num?) ?? 0,
      netThisMonth: (json['netThisMonth'] as num?) ?? 0,
      dailyLast7: daily
          .map((e) => DailyEarningModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
