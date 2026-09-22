import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_frequency.dart';
import '../../domain/entities/money_item.dart';

class MoneyItemModel extends MoneyItem {
  const MoneyItemModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.direction,
    required super.frequency,
    super.dayOfWeek,
    super.dayOfMonth,
    required super.active,
  });

  factory MoneyItemModel.fromJson(Map<String, dynamic> json) {
    return MoneyItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      direction: MoneyDirection.fromApi(json['direction'] as String?),
      frequency: MoneyFrequency.fromApi(json['frequency'] as String?),
      dayOfWeek: (json['dayOfWeek'] as num?)?.toInt(),
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
    );
  }
}
