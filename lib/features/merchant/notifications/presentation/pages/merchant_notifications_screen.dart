import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_notifications_cubit.dart';
import '../manager/merchant_notifications_state.dart';
import '../widgets/notification_row.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantNotificationsScreen extends StatefulWidget {
  const MerchantNotificationsScreen({super.key});

  @override
  State<MerchantNotificationsScreen> createState() =>
      _MerchantNotificationsScreenState();
}

class _MerchantNotificationsScreenState
    extends State<MerchantNotificationsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 200) {
      return;
    }
    context.read<MerchantNotificationsCubit>().loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().notifications,
        trailing: BlocBuilder<
          MerchantNotificationsCubit,
          MerchantNotificationsState
        >(
          builder: (context, state) {
            if (state.unseenCount == 0) return const SizedBox.shrink();

            return TextButton(
              onPressed: context.read<MerchantNotificationsCubit>().markAllRead,
              child: Text(
                S().markAllRead,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.semantic.accentStrong,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
      body:
          BlocBuilder<MerchantNotificationsCubit, MerchantNotificationsState>(
            builder: (context, state) {
              if (state.status == NotificationsStatus.loading) {
                return const ListSkeleton();
              }

              if (state.status == NotificationsStatus.failure) {
                return AppErrorState(
                  message: state.errorMessage,
                  onRetry: () =>
                      context.read<MerchantNotificationsCubit>().loadNotifications(),
                );
              }

              if (state.notifications.isEmpty) {
                return AppEmptyState(
                  icon: Icons.notifications_none_rounded,
                  title: S().notificationsEmpty,
                  message: S().notificationsEmptyHint,
                );
              }

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<MerchantNotificationsCubit>().loadNotifications(),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  itemCount:
                      state.notifications.length +
                      (state.status == NotificationsStatus.loadingMore
                          ? 1
                          : 0),
                  itemBuilder: (_, index) {
                    if (index >= state.notifications.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }

                    final notification = state.notifications[index];
                    return NotificationRow(
                      notification: notification,
                      onTap: () => context
                          .read<MerchantNotificationsCubit>()
                          .markRead(notification.id),
                    );
                  },
                ),
              );
            },
          ),
    );
  }
}
