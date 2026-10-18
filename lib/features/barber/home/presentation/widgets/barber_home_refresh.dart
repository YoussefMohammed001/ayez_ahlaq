import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bookings/presentation/manager/bookings_cubit.dart';
import '../../../documents/presentation/manager/barber_documents_cubit.dart';
import '../../../home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../../home_service_broadcast/presentation/manager/home_service_broadcast_cubit.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_cubit.dart';
import '../../../money/presentation/manager/money_pin_cubit.dart';
import '../../../money/presentation/manager/money_pin_state.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../../subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../../team/presentation/manager/earnings_cubit.dart';

class BarberHomeRefresh {
  const BarberHomeRefresh._();

  static Future<void> run(BuildContext context) {
    final pinUnlocked =
        context.read<MoneyPinCubit>().state.stage == MoneyPinStage.unlocked;
    return Future.wait([
      context.read<BarberProfileCubit>().loadProfile(),
      if (pinUnlocked) context.read<EarningsCubit>().loadEarnings(),
      context.read<BookingsCubit>().loadPending(),
      context.read<BookingsCubit>().loadQueue(),
      context.read<BarberSubscriptionCubit>().load(),
      context.read<BarberStorefrontOrdersCubit>().loadOrders(),
      context.read<HomeServiceSettingsCubit>().loadSettings(),
      context.read<HomeServiceRequestsCubit>().loadPending(),
      context.read<HomeServiceBroadcastCubit>().loadBroadcasts(),
      context.read<BarberDocumentsCubit>().loadDocuments(),
    ]);
  }
}
