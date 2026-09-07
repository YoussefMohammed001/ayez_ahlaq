import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../shops/domain/entities/shop_barber.dart';
import '../manager/booking_flow_cubit.dart';

class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopDetail = context.watch<BookingFlowCubit>().state.shopDetail!;
    final services = <int, ShopBarberService>{};
    for (final barber in shopDetail.barbers) {
      for (final service in barber.services) {
        services[service.serviceTypeId] = service;
      }
    }

    return Scaffold(
      appBar: AppTopBar(title: S().chooseServiceTitle),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: services.values
            .map(
              (service) => AppCard(
                margin: EdgeInsets.only(bottom: 10.h),
                onTap: () {
                  context.read<BookingFlowCubit>().selectService(
                    serviceTypeId: service.serviceTypeId,
                    serviceName: service.name,
                    price: service.price,
                  );
                  context.push(Routes.customerChooseStyleScreen);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${service.durationMinutes} ${S().minutesUnit}',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${service.price}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: context.semantic.accentStrong,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
