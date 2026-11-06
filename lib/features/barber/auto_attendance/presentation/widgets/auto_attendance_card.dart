import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../manager/auto_attendance_cubit.dart';
import '../manager/auto_attendance_state.dart';
import 'auto_attendance_result_handler.dart';

class AutoAttendanceCard extends StatelessWidget {
  const AutoAttendanceCard({super.key});

  Future<void> _onChanged(
    BuildContext context,
    AutoAttendanceCubit cubit,
    bool value,
  ) async {
    if (!value) return cubit.turnOff();

    final agreed = await showConfirmDialog(
      context,
      title: S().autoAttendanceDialogTitle,
      message: S().autoAttendanceDialogBody,
      confirmLabel: S().autoAttendanceContinue,
      icon: Icons.location_on_outlined,
      isDestructive: false,
    );
    if (!agreed) return;

    final result = await cubit.turnOn();
    if (context.mounted) {
      await AutoAttendanceResultHandler.handle(context, result, cubit);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BlocProvider(
      create: (_) => sl<AutoAttendanceCubit>()..load(),
      child: BlocBuilder<AutoAttendanceCubit, AutoAttendanceState>(
        builder: (context, state) {
          final cubit = context.read<AutoAttendanceCubit>();

          return AppCard(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.my_location_rounded, color: scheme.primary),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        S().autoAttendanceTitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    Switch(
                      value: state.isEnabled,
                      onChanged: state.isBusy
                          ? null
                          : (value) => _onChanged(context, cubit, value),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  S().autoAttendanceSubtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.6,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (state.isEnabled && Platform.isAndroid) ...[
                  SizedBox(height: 8.h),
                  Text(
                    S().autoAttendanceBatteryHint,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      height: 1.6,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
