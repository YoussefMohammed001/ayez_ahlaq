import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/widgets/count_badge.dart';
import '../manager/merchant_notifications_cubit.dart';
import '../manager/merchant_notifications_state.dart';

class UnseenNotificationsBadge extends StatelessWidget {
  const UnseenNotificationsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantNotificationsCubit, MerchantNotificationsState>(
      buildWhen: (previous, current) =>
          previous.unseenCount != current.unseenCount,
      builder: (context, state) => CountBadge(count: state.unseenCount),
    );
  }
}
