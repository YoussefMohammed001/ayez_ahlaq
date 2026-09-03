import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/widgets/count_badge.dart';
import '../manager/barber_notifications_cubit.dart';
import '../manager/barber_notifications_state.dart';

class BarberUnseenNotificationsBadge extends StatelessWidget {
  const BarberUnseenNotificationsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberNotificationsCubit, BarberNotificationsState>(
      buildWhen: (previous, current) =>
          previous.unseenCount != current.unseenCount,
      builder: (context, state) => CountBadge(count: state.unseenCount),
    );
  }
}
