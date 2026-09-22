import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_entry.dart';

class MoneyEntryModel extends MoneyEntry {
  const MoneyEntryModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.direction,
    super.entryDate,
  });

  factory MoneyEntryModel.fromJson(Map<String, dynamic> json) {
    return MoneyEntryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      direction: MoneyDirection.fromApi(json['direction'] as String?),
      entryDate: DateTime.tryParse(json['entryDate'] as String? ?? ''),
    );
  }
}
