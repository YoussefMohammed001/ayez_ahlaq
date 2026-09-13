import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/booking_flow_cubit.dart';
import '../widgets/barber_selection_row.dart';
import '../widgets/booking_context_pill.dart';

class ChooseBarberScreen extends StatelessWidget {
  const ChooseBarberScreen({super.key});

  void _proceed(BuildContext context) => context.push(Routes.customerChooseTimeScreen);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingFlowCubit>();
    final state = cubit.state;
    final barbers = state.shopDetail!.barbers
        .where((b) => b.services.any((s) => s.serviceTypeId == state.serviceTypeId))
        .toList();

    return Scaffold(
      appBar: AppTopBar(title: S().chooseBarberTitle),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: [
          BookingContextPill(
            label: S().bookingWithShopLabel(state.shopDetail!.shop.name),
          ),
          SizedBox(height: 14.h),
          AppCard(
            margin: EdgeInsets.only(bottom: 10.h),
            onTap: () {
              cubit.selectBarber();
              _proceed(context);
            },
            child: Row(
              children: [
                Icon(Icons.auto_awesome_rounded, size: 22.r, color: context.semantic.accentStrong),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S().autoSelectBarber,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        S().autoSelectBarberHint,
                        style: TextStyle(fontSize: 11.5.sp, color: context.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (final barber in barbers)
            BarberSelectionRow(
              barber: barber,
              onTap: () {
                cubit.selectBarber(barberId: barber.id, barberName: barber.name);
                _proceed(context);
              },
            ),
        ],
      ),
    );
  }
}
