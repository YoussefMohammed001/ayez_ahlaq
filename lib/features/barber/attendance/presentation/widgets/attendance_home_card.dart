import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_attendance_cubit.dart';
import '../manager/barber_attendance_state.dart';
import 'attendance_time_label.dart';

class AttendanceHomeCard extends StatelessWidget {
  const AttendanceHomeCard({super.key});

  String _subtitle(BarberAttendanceState state) {
    if (!state.hasLoaded) return S().attendanceHomeCardAction;
    final shift = state.current.shift;
    if (shift == null) return S().attendanceOffShift;
    return '${S().attendanceOnShift} • ${S().attendanceStartedAt(AttendanceTimeLabel.time(shift.checkInAt))}';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BlocProvider(
      create: (_) => sl<BarberAttendanceCubit>()..load(),
      child: BlocBuilder<BarberAttendanceCubit, BarberAttendanceState>(
        builder: (context, state) => AppCard(
          padding: EdgeInsets.all(14.r),
          onTap: () async {
            final cubit = context.read<BarberAttendanceCubit>();
            await context.push(Routes.barberAttendanceScreen);
            cubit.load();
          },
          child: Row(
            children: [
              Icon(
                Icons.fingerprint_rounded,
                color: scheme.primary,
                size: 28.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S().attendanceTitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _subtitle(state),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_left_rounded, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
