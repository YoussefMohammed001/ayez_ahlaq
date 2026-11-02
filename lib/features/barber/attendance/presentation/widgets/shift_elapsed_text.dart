import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_shift.dart';
import 'attendance_duration_label.dart';

class ShiftElapsedText extends StatefulWidget {
  final AttendanceShift shift;
  final DateTime fetchedAt;

  const ShiftElapsedText({
    super.key,
    required this.shift,
    required this.fetchedAt,
  });

  @override
  State<ShiftElapsedText> createState() => _ShiftElapsedTextState();
}

class _ShiftElapsedTextState extends State<ShiftElapsedText> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(
      const Duration(seconds: 20),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  int get _minutes =>
      widget.shift.durationMinutes +
      DateTime.now().difference(widget.fetchedAt).inMinutes;

  @override
  Widget build(BuildContext context) {
    return Text(
      S().attendanceShiftDuration(AttendanceDurationLabel.of(_minutes)),
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onSurface,
      ),
    );
  }
}
