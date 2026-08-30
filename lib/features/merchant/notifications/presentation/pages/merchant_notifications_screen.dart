import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_notifications_cubit.dart';
import '../manager/merchant_notifications_state.dart';
import '../widgets/notification_row.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantNotificationsScreen extends StatelessWidget {
  const MerchantNotificationsScreen({super.key});

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

              if (state.notifications.isEmpty) {
                return AppEmptyState(
                  icon: Icons.notifications_none_rounded,
                  title: S().notificationsEmpty,
                  message: S().notificationsEmptyHint,
                );
              }

              return ListView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                itemCount: state.notifications.length,
                itemBuilder: (_, index) {
                  final notification = state.notifications[index];
                  return NotificationRow(
                    notification: notification,
                    onTap: () => context
                        .read<MerchantNotificationsCubit>()
                        .markRead(notification.id),
                  );
                },
              );
            },
          ),
    );
  }
}
