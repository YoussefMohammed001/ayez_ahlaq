import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_settings.dart';
import 'attendance_last_change_note.dart';

class AttendanceSettingsForm extends StatefulWidget {
  static const minRange = 10;
  static const maxRange = 5000;

  final AttendanceSettings settings;
  final bool isSubmitting;
  final Future<void> Function(bool enforced, int? rangeMeters) onSave;

  const AttendanceSettingsForm({
    super.key,
    required this.settings,
    required this.isSubmitting,
    required this.onSave,
  });

  @override
  State<AttendanceSettingsForm> createState() => _AttendanceSettingsFormState();
}

class _AttendanceSettingsFormState extends State<AttendanceSettingsForm> {
  late bool _enforced = widget.settings.config.enforced;
  late final _rangeController = TextEditingController(
    text: widget.settings.config.rangeMeters?.toString() ?? '',
  );

  @override
  void dispose() {
    _rangeController.dispose();
    super.dispose();
  }

  bool _inRange(int value) =>
      value >= AttendanceSettingsForm.minRange &&
      value <= AttendanceSettingsForm.maxRange;

  void _submit() {
    final text = _rangeController.text.trim();
    final range = int.tryParse(text);

    if ((_enforced || text.isNotEmpty) && (range == null || !_inRange(range))) {
      return showError(S().attendanceRangeInvalid);
    }

    widget.onSave(_enforced, range);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S().attendanceEnforceLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                  ),
                  ToggleSwitch(
                    value: _enforced,
                    onTap: () => setState(() => _enforced = !_enforced),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                S().attendanceEnforceHint,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                S().attendanceRangeLabel,
                style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurface),
              ),
              SizedBox(height: 8.h),
              AppTextField(
                controller: _rangeController,
                hint: S().attendanceRangeHelper,
                isNumber: true,
              ),
            ],
          ),
        ),
        AttendanceLastChangeNote(settings: widget.settings),
        SizedBox(height: 20.h),
        PrimaryCtaButton(
          label: S().save,
          isLoading: widget.isSubmitting,
          onPressed: _submit,
        ),
        SizedBox(height: 20.h),
        AppCard(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: MenuRow(
            icon: Icons.history_rounded,
            label: S().attendanceSettingsLogTitle,
            showDivider: false,
            onTap: () => context.push(Routes.barberAttendanceSettingLogScreen),
          ),
        ),
      ],
    );
  }
}
