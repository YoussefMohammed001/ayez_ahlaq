import 'package:equatable/equatable.dart';
import 'merchant_notification.dart';

class NotificationPage extends Equatable {
  final List<MerchantNotification> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  const NotificationPage({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [content, page, size, totalElements, totalPages];
}
