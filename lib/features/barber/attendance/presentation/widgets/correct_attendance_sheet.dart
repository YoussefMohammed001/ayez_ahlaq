import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/sheet_grabber.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_shift.dart';
import 'attendance_date_time_field.dart';

class CorrectAttendanceSheet extends StatefulWidget {
  static const maxNoteLength = 500;

  final AttendanceShift shift;
  final Future<bool> Function(
    DateTime checkInAt,
    DateTime checkOutAt,
    String note,
  )
  onSubmit;

  const CorrectAttendanceSheet({
    super.key,
    required this.shift,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required AttendanceShift shift,
    required Future<bool> Function(DateTime, DateTime, String) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CorrectAttendanceSheet(shift: shift, onSubmit: onSubmit),
    );
  }

  @override
  State<CorrectAttendanceSheet> createState() => _CorrectAttendanceSheetState();
}

class _CorrectAttendanceSheetState extends State<CorrectAttendanceSheet> {
  final _noteController = TextEditingController();
  late DateTime _checkIn = widget.shift.checkInAt;
  late DateTime _checkOut =
      widget.shift.checkOutAt ??
      widget.shift.checkInAt.add(const Duration(hours: 1));
  bool _submitting = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String? get _problem {
    final note = _noteController.text.trim();
    if (!_checkOut.isAfter(_checkIn)) return S().attendanceCorrectOutBeforeIn;
    if (note.isEmpty) return S().attendanceCorrectNoteRequired;
    return null;
  }

  Future<void> _submit() async {
    final problem = _problem;
    if (problem != null) return showError(problem);

    setState(() => _submitting = true);

    final done = await widget.onSubmit(
      _checkIn,
      _checkOut,
      _noteController.text.trim(),
    );

    if (!mounted) return;
    if (done) {
      Navigator.of(context).pop();
    } else {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        10.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetGrabber(),
            Text(
              S().attendanceCorrectTitle,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 14.h),
            AttendanceDateTimeField(
              label: S().attendanceCorrectCheckIn,
              value: _checkIn,
              onChanged: (value) => setState(() => _checkIn = value),
            ),
            SizedBox(height: 10.h),
            AttendanceDateTimeField(
              label: S().attendanceCorrectCheckOut,
              value: _checkOut,
              onChanged: (value) => setState(() => _checkOut = value),
            ),
            SizedBox(height: 10.h),
            AppTextField(
              controller: _noteController,
              hint: S().attendanceCorrectNote,
              maxLines: 3,
            ),
            SizedBox(height: 16.h),
            PrimaryCtaButton(
              label: S().save,
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
