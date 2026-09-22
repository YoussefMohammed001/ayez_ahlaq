import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_occurrence.dart';

class MoneyOccurrenceModel extends MoneyOccurrence {
  const MoneyOccurrenceModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.direction,
    super.occurrenceDate,
  });

  factory MoneyOccurrenceModel.fromJson(Map<String, dynamic> json) {
    return MoneyOccurrenceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      direction: MoneyDirection.fromApi(json['direction'] as String?),
      occurrenceDate: DateTime.tryParse(json['occurrenceDate'] as String? ?? ''),
    );
  }
}
