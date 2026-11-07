import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../documents/presentation/manager/barber_documents_cubit.dart';
import '../../../documents/presentation/manager/barber_documents_state.dart';
import '../../../home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../../home_service/presentation/manager/home_service_settings_state.dart';
import '../../../home_service_broadcast/presentation/manager/home_service_broadcast_cubit.dart';
import '../../../home_service_broadcast/presentation/manager/home_service_broadcast_state.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_cubit.dart';
import '../../../home_service_requests/presentation/manager/home_service_requests_state.dart';
import '../../../storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../../../storefront/orders/presentation/manager/barber_storefront_orders_state.dart';
import 'home_documents_card.dart';
import 'home_service_broadcast_card.dart';
import 'home_service_card.dart';
import 'home_storefront_orders_card.dart';

class HomeAlertCards extends StatelessWidget {
  const HomeAlertCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<BarberStorefrontOrdersCubit, BarberStorefrontOrdersState>(
          builder: (context, state) {
            final pendingCount = state.orders
                .where((o) => o.status.needsDecision)
                .length;
            if (pendingCount == 0) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: HomeStorefrontOrdersCard(
                pendingCount: pendingCount,
                onTap: () =>
                    context.push(Routes.barberStorefrontHomeScreen, extra: 3),
              ),
            );
          },
        ),
        BlocBuilder<BarberDocumentsCubit, BarberDocumentsState>(
          builder: (context, state) {
            if (state.missingRequiredCount == 0) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: HomeDocumentsCard(
                missingCount: state.missingRequiredCount,
                onTap: () => context.push(Routes.barberDocumentsScreen),
              ),
            );
          },
        ),
        BlocBuilder<HomeServiceBroadcastCubit, HomeServiceBroadcastState>(
          builder: (context, state) {
            final pendingCount = state.broadcasts.length;
            if (pendingCount == 0) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: HomeServiceBroadcastCard(
                pendingCount: pendingCount,
                onTap: () =>
                    context.push(Routes.barberHomeServiceBroadcastScreen),
              ),
            );
          },
        ),
        BlocBuilder<HomeServiceSettingsCubit, HomeServiceSettingsState>(
          builder: (context, settingsState) =>
              BlocBuilder<HomeServiceRequestsCubit, HomeServiceRequestsState>(
                builder: (context, requestsState) {
                  final pendingCount = requestsState.requests.length;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: HomeServiceCard(
                      enabled: settingsState.settings.enabled,
                      pendingCount: pendingCount,
                      onTap: () => context.push(
                        pendingCount > 0
                            ? Routes.barberHomeServiceRequestsScreen
                            : Routes.barberHomeServiceSettingsScreen,
                      ),
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}
