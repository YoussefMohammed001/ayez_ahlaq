import '../../domain/entities/money_entry_page.dart';
import 'money_entry_model.dart';

class MoneyEntryPageModel extends MoneyEntryPage {
  const MoneyEntryPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
  });

  factory MoneyEntryPageModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List?) ?? const [];
    return MoneyEntryPageModel(
      content: content
          .map((e) => MoneyEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
