import 'package:equatable/equatable.dart';
import 'customer_notification.dart';

class CustomerNotificationPage extends Equatable {
  final List<CustomerNotification> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  const CustomerNotificationPage({
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
