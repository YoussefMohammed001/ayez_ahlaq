import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_notification.dart';

enum NotificationsStatus { initial, loading, loadingMore, success, failure }

class BarberNotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<BarberNotification> notifications;
  final int page;
  final bool hasMore;
  final int unseenCount;
  final String? errorMessage;
  final bool isMarkingRead;

  const BarberNotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.page = 0,
    this.hasMore = false,
    this.unseenCount = 0,
    this.errorMessage,
    this.isMarkingRead = false,
  });

  BarberNotificationsState copyWith({
    NotificationsStatus? status,
    List<BarberNotification>? notifications,
    int? page,
    bool? hasMore,
    int? unseenCount,
    String? errorMessage,
    bool? isMarkingRead,
  }) {
    return BarberNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      unseenCount: unseenCount ?? this.unseenCount,
      errorMessage: errorMessage,
      isMarkingRead: isMarkingRead ?? this.isMarkingRead,
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
    isMarkingRead,
  ];
}
