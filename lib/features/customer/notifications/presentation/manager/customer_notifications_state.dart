import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_notification.dart';

enum CustomerNotificationsStatus { initial, loading, loadingMore, success, failure }

class CustomerNotificationsState extends Equatable {
  final CustomerNotificationsStatus status;
  final List<CustomerNotification> notifications;
  final int page;
  final bool hasMore;
  final int unseenCount;
  final String? errorMessage;

  const CustomerNotificationsState({
    this.status = CustomerNotificationsStatus.initial,
    this.notifications = const [],
    this.page = 0,
    this.hasMore = false,
    this.unseenCount = 0,
    this.errorMessage,
  });

  CustomerNotificationsState copyWith({
    CustomerNotificationsStatus? status,
    List<CustomerNotification>? notifications,
    int? page,
    bool? hasMore,
    int? unseenCount,
    String? errorMessage,
  }) {
    return CustomerNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      unseenCount: unseenCount ?? this.unseenCount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    notifications,
    page,
    hasMore,
    unseenCount,
    errorMessage,
  ];
}
