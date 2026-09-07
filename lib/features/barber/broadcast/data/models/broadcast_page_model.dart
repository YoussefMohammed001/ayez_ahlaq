import '../../domain/entities/broadcast_page.dart';
import 'broadcast_model.dart';

class BroadcastPageModel extends BroadcastPage {
  const BroadcastPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
  });

  factory BroadcastPageModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List?) ?? const [];
    return BroadcastPageModel(
      content: content
          .map((e) => BroadcastModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
