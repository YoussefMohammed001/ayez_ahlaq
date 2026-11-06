import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../shared/tour/tour_target.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_attendance_cubit.dart';
import '../manager/barber_attendance_state.dart';
import 'attendance_time_label.dart';

class AttendanceHomeCard extends StatelessWidget {
  final GlobalKey? tourKey;

  const AttendanceHomeCard({super.key, this.tourKey});

  String _subtitle(BarberAttendanceState state) {
    final shift = state.current.shift;
    if (shift == null) return S().attendanceOffShift;
    return '${S().attendanceOnShift} • ${S().attendanceStartedAt(AttendanceTimeLabel.time(shift.checkInAt))}';
  }

  Widget _withTour(Widget card) {
    final key = tourKey;
    if (key == null) return card;
    return TourTarget(
      tourKey: key,
      title: S().tourAttendanceTitle,
      description: S().tourAttendanceBody,
      child: card,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BlocBuilder<BarberAttendanceCubit, BarberAttendanceState>(
      builder: (context, state) {
        if (!state.hasLoaded || state.isLocked) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(bottom: 18.h),
          child: _withTour(
            AppCard(
              padding: EdgeInsets.all(14.r),
              onTap: () => context.push(
                Routes.barberAttendanceScreen,
                extra: context.read<BarberAttendanceCubit>(),
              ),
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
                  Icon(
                    Icons.chevron_right,
                    color: scheme.onSurfaceVariant,
                    size: 20.r,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
