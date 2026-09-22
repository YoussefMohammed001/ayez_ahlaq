import '../../domain/entities/money_summary.dart';

class MoneySummaryModel extends MoneySummary {
  const MoneySummaryModel({
    required super.totalAdded,
    required super.totalSubtracted,
    required super.net,
  });

  factory MoneySummaryModel.fromJson(Map<String, dynamic> json) {
    return MoneySummaryModel(
      totalAdded: (json['totalAdded'] as num?)?.toInt() ?? 0,
      totalSubtracted: (json['totalSubtracted'] as num?)?.toInt() ?? 0,
      net: (json['net'] as num?)?.toInt() ?? 0,
    );
  }
}
