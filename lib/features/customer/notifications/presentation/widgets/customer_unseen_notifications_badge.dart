import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/widgets/count_badge.dart';
import '../manager/customer_notifications_cubit.dart';
import '../manager/customer_notifications_state.dart';

class CustomerUnseenNotificationsBadge extends StatelessWidget {
  const CustomerUnseenNotificationsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerNotificationsCubit, CustomerNotificationsState>(
      buildWhen: (previous, current) => previous.unseenCount != current.unseenCount,
      builder: (context, state) => CountBadge(count: state.unseenCount),
    );
  }
}
