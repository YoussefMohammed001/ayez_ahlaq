import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../manager/customer_notifications_cubit.dart';
import '../manager/customer_notifications_state.dart';
import '../services/customer_notification_tap_router.dart';
import '../widgets/customer_notification_row.dart';
import '../../../../../core/extensions/ext_theme.dart';

class CustomerNotificationsScreen extends StatefulWidget {
  const CustomerNotificationsScreen({super.key});

  @override
  State<CustomerNotificationsScreen> createState() => _CustomerNotificationsScreenState();
}

class _CustomerNotificationsScreenState extends State<CustomerNotificationsScreen> {
  final _scrollController = ScrollController();
  final _tapRouter = const CustomerNotificationTapRouter();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<CustomerNotificationsCubit>().loadNotifications();
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
    context.read<CustomerNotificationsCubit>().loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().notifications,
        trailing: BlocBuilder<CustomerNotificationsCubit, CustomerNotificationsState>(
          builder: (context, state) {
            if (state.unseenCount == 0) return const SizedBox.shrink();

            return TextButton(
              onPressed: context.read<CustomerNotificationsCubit>().markAllRead,
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
      body: BlocConsumer<CustomerNotificationsCubit, CustomerNotificationsState>(
        listenWhen: (previous, current) =>
            current.status == CustomerNotificationsStatus.success &&
            current.errorMessage != null &&
            current.errorMessage != previous.errorMessage,
        listener: (context, state) => showError(state.errorMessage!),
        builder: (context, state) {
          if (state.status == CustomerNotificationsStatus.loading) {
            return const ListSkeleton();
          }

          if (state.status == CustomerNotificationsStatus.failure) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => context.read<CustomerNotificationsCubit>().loadNotifications(),
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
            onRefresh: () => context.read<CustomerNotificationsCubit>().loadNotifications(),
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              itemCount: state.notifications.length +
                  (state.status == CustomerNotificationsStatus.loadingMore ? 1 : 0),
              itemBuilder: (_, index) {
                if (index >= state.notifications.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }

                final notification = state.notifications[index];
                return CustomerNotificationRow(
                  notification: notification,
                  onTap: () {
                    context.read<CustomerNotificationsCubit>().markRead(notification.id);
                    _tapRouter.handle(context, notification);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
