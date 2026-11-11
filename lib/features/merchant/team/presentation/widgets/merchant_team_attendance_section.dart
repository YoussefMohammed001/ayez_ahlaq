import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../../../../barber/attendance/presentation/widgets/owner_attendance_links.dart';
import '../../../subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../../subscription/presentation/manager/merchant_subscription_state.dart';

class MerchantTeamAttendanceSection extends StatelessWidget {
  const MerchantTeamAttendanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantSubscriptionCubit, MerchantSubscriptionState>(
      buildWhen: (previous, current) =>
          previous.subscription?.attendanceEnabled !=
              current.subscription?.attendanceEnabled ||
          (previous.subscription == null) != (current.subscription == null),
      builder: (context, state) {
        final subscription = state.subscription;
        if (subscription == null) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
          child: subscription.attendanceEnabled
              ? const OwnerAttendanceLinks(
                  teamRoute: Routes.merchantTeamAttendanceScreen,
                  settingsRoute: Routes.merchantAttendanceSettingsScreen,
                )
              : AppCard(
                  padding: EdgeInsets.all(14.r),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_clock_outlined,
                        size: 22.r,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          S().ownerAttendanceLocked,
                          style: font12w500.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
