import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local/notifications_mock.dart';
import 'merchant_notifications_state.dart';

class MerchantNotificationsCubit extends Cubit<MerchantNotificationsState> {
  MerchantNotificationsCubit() : super(const MerchantNotificationsState());

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    await Future.delayed(const Duration(milliseconds: 400));

    emit(
      state.copyWith(
        status: NotificationsStatus.success,
        notifications: NotificationsMock.items(),
      ),
    );
  }

  void markAllRead() {
    emit(
      state.copyWith(
        notifications:
            state.notifications.map((n) => n.copyWith(seen: true)).toList(),
      ),
    );
  }

  void markRead(int id) {
    emit(
      state.copyWith(
        notifications: state.notifications
            .map((n) => n.id == id ? n.copyWith(seen: true) : n)
            .toList(),
      ),
    );
  }
}
