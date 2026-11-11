import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../barber/attendance/presentation/widgets/attendance_time_label.dart';
import '../../../../attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../../attendance/presentation/manager/member_attendance_state.dart';
import 'sub_home_card.dart';
import 'sub_home_value_text.dart';

class SubHomeAttendanceCard extends StatelessWidget {
  final VoidCallback onTap;

  const SubHomeAttendanceCard({super.key, required this.onTap});

  String _label(MemberAttendanceState state) {
    if (!state.hasLoaded) return '...';
    if (state.isDisabled) return S().subHomeAttendanceDisabled;

    final shift = state.current.shift;
    if (shift == null) return S().subHomeAttendanceNotStarted;

    final since = S().attendanceStartedAt(
      AttendanceTimeLabel.time(shift.checkInAt),
    );
    return '${S().attendanceOnShift} • $since';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberAttendanceCubit, MemberAttendanceState>(
      builder: (context, state) => SubHomeCard(
        icon: Icons.fingerprint_rounded,
        title: S().subHomeAttendanceTitle,
        onTap: onTap,
        child: SubHomeValueText(
          _label(state),
          muted: !state.hasLoaded || state.isDisabled,
        ),
      ),
    );
  }
}
