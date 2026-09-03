import '../../domain/entities/notification_page.dart';
import 'merchant_notification_model.dart';

class NotificationPageModel extends NotificationPage {
  const NotificationPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
  });

  factory NotificationPageModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List?) ?? const [];
    return NotificationPageModel(
      content: content
          .map(
            (e) => MerchantNotificationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
