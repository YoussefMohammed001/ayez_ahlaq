import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_notification.dart';

enum NotificationsStatus { initial, loading, success }

class MerchantNotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<MerchantNotification> notifications;

  const MerchantNotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
  });

  int get unseenCount => notifications.where((n) => !n.seen).length;

  MerchantNotificationsState copyWith({
    NotificationsStatus? status,
    List<MerchantNotification>? notifications,
  }) {
    return MerchantNotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [status, notifications];
}
