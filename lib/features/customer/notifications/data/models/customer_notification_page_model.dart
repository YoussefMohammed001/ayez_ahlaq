import '../../domain/entities/customer_notification_page.dart';
import 'customer_notification_model.dart';

class CustomerNotificationPageModel extends CustomerNotificationPage {
  const CustomerNotificationPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
  });

  factory CustomerNotificationPageModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List?) ?? const [];
    return CustomerNotificationPageModel(
      content: content
          .map((e) => CustomerNotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
