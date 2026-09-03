import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/get_unseen_notifications_count_use_case.dart';
import '../../domain/use_cases/mark_all_notifications_seen_use_case.dart';
import '../../domain/use_cases/mark_notification_clicked_use_case.dart';
import 'merchant_notifications_state.dart';

class MerchantNotificationsCubit extends Cubit<MerchantNotificationsState> {
  static const int pageSize = 20;

  final GetNotificationsUseCase _getNotifications;
  final GetUnseenNotificationsCountUseCase _getUnseenCount;
  final MarkAllNotificationsSeenUseCase _markAllSeen;
  final MarkNotificationClickedUseCase _markClicked;

  MerchantNotificationsCubit(
    this._getNotifications,
    this._getUnseenCount,
    this._markAllSeen,
    this._markClicked,
  ) : super(const MerchantNotificationsState());

  Future<void> loadNotifications() async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    final result = await _getNotifications(page: 0, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotificationsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: NotificationsStatus.success,
          notifications: result.content,
          page: result.page,
          hasMore: result.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == NotificationsStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: NotificationsStatus.loadingMore));

    final result = await _getNotifications(
      page: state.page + 1,
      size: pageSize,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotificationsStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: NotificationsStatus.success,
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
          notifications:
              state.notifications.map((n) => n.copyWith(seen: true)).toList(),
          unseenCount: 0,
        ),
      ),
    );
  }

  Future<void> markRead(int id) async {
    final wasUnseen =
        state.notifications.any((n) => n.id == id && !n.seen);

    emit(
      state.copyWith(
        notifications: state.notifications
            .map((n) => n.id == id ? n.copyWith(seen: true) : n)
            .toList(),
        unseenCount: wasUnseen && state.unseenCount > 0
            ? state.unseenCount - 1
            : state.unseenCount,
      ),
    );

    await _markClicked(id);
  }
}
