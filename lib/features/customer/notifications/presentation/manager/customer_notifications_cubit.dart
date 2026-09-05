import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_customer_notifications_use_case.dart';
import '../../domain/use_cases/get_customer_unseen_notifications_count_use_case.dart';
import '../../domain/use_cases/mark_all_customer_notifications_seen_use_case.dart';
import '../../domain/use_cases/mark_customer_notification_clicked_use_case.dart';
import 'customer_notifications_state.dart';

class CustomerNotificationsCubit extends Cubit<CustomerNotificationsState> {
  static const int pageSize = 20;

  final GetCustomerNotificationsUseCase _getNotifications;
  final GetCustomerUnseenNotificationsCountUseCase _getUnseenCount;
  final MarkAllCustomerNotificationsSeenUseCase _markAllSeen;
  final MarkCustomerNotificationClickedUseCase _markClicked;

  CustomerNotificationsCubit(
    this._getNotifications,
    this._getUnseenCount,
    this._markAllSeen,
    this._markClicked,
  ) : super(const CustomerNotificationsState());

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: CustomerNotificationsStatus.loading));

    final result = await _getNotifications(page: 0, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerNotificationsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: CustomerNotificationsStatus.success,
          notifications: result.content,
          page: result.page,
          hasMore: result.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == CustomerNotificationsStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: CustomerNotificationsStatus.loadingMore));

    final result = await _getNotifications(page: state.page + 1, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerNotificationsStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: CustomerNotificationsStatus.success,
          notifications: [...state.notifications, ...result.content],
          page: result.page,
          hasMore: result.hasMore,
        ),
      ),
    );
  }

  Future<void> refreshUnseenCount() async {
    final result = await _getUnseenCount();
    result.fold((_) {}, (count) => emit(state.copyWith(unseenCount: count)));
  }

  Future<void> markAllRead() async {
    final result = await _markAllSeen();
    result.fold(
      (_) {},
      (_) => emit(
        state.copyWith(
          notifications: state.notifications.map((n) => n.copyWith(seen: true)).toList(),
          unseenCount: 0,
        ),
      ),
    );
  }

  Future<void> markRead(int id) async {
    final wasUnseen = state.notifications.any((n) => n.id == id && !n.seen);

    emit(
      state.copyWith(
        notifications:
            state.notifications.map((n) => n.id == id ? n.copyWith(seen: true) : n).toList(),
        unseenCount: wasUnseen && state.unseenCount > 0
            ? state.unseenCount - 1
            : state.unseenCount,
      ),
    );

    await _markClicked(id);
  }
}
