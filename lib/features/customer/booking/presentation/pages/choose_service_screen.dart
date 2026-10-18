import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../shops/domain/entities/shop_barber.dart';
import '../manager/booking_flow_cubit.dart';
import '../widgets/booking_context_pill.dart';
import '../widgets/service_selection_row.dart';

class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({super.key});

  List<ShopBarberService> _dedupedServices(List<ShopBarber> barbers) {
    final byType = <int, ShopBarberService>{};
    for (final barber in barbers) {
      for (final service in barber.services) {
        final existing = byType[service.serviceTypeId];
        if (existing == null || (!existing.popular && service.popular)) {
          byType[service.serviceTypeId] = service;
        }
      }
    }
    return byType.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BookingFlowCubit>();
    final state = cubit.state;
    final services = _dedupedServices(state.shopDetail!.barbers);

    return Scaffold(
      appBar: AppTopBar(title: S().chooseServiceTitle),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: [
          BookingContextPill(
            label: S().bookingWithShopLabel(state.shopDetail!.shop.name),
          ),
          SizedBox(height: 14.h),
          for (final service in services)
            ServiceSelectionRow(
              service: service,
              selected: state.serviceTypeId == service.serviceTypeId,
              onTap: () {
                cubit.selectService(
                  serviceTypeId: service.serviceTypeId,
                  serviceName: service.name,
                  price: service.price,
                );
                final hasStyles = state.shopDetail!.haircutStyles.any(
                  (style) => style.appliesTo(service.serviceTypeId),
                );
                context.push(
                  hasStyles
                      ? Routes.customerChooseStyleScreen
                      : Routes.customerChooseBarberScreen,
                );
              },
            ),
        ],
      ),
    );
  }
}
