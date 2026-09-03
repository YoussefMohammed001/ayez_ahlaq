import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_notification.dart';

enum NotificationsStatus { initial, loading, loadingMore, success, failure }

class MerchantNotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<MerchantNotification> notifications;
  final int page;
  final bool hasMore;
  final int unseenCount;
  final String? errorMessage;

  const MerchantNotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.page = 0,
    this.hasMore = false,
    this.unseenCount = 0,
    this.errorMessage,
  });

  MerchantNotificationsState copyWith({
    NotificationsStatus? status,
    List<MerchantNotification>? notifications,
    int? page,
    bool? hasMore,
    int? unseenCount,
    String? errorMessage,
  }) {
    return MerchantNotificationsState(
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
