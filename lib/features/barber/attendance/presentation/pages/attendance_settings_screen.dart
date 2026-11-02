import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/attendance_settings_cubit.dart';
import '../manager/attendance_settings_state.dart';
import '../widgets/attendance_settings_form.dart';

class AttendanceSettingsScreen extends StatelessWidget {
  const AttendanceSettingsScreen({super.key});

  Future<void> _save(
    BuildContext context,
    bool enforced,
    int? rangeMeters,
  ) async {
    final saved = await context.read<AttendanceSettingsCubit>().save(
      enforced: enforced,
      rangeMeters: rangeMeters,
    );

    if (saved && context.mounted) showSuccess(S().attendanceSettingsSaved);
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<AttendanceSettingsCubit, AttendanceSettingsState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().attendanceSettingsTitle),
        body: BlocBuilder<AttendanceSettingsCubit, AttendanceSettingsState>(
          builder: (context, state) {
            final cubit = context.read<AttendanceSettingsCubit>();
            final settings = state.settings;

            if (settings == null) {
              return state.status == AttendanceSettingsStatus.failure
                  ? AppErrorState(
                      message: state.errorMessage,
                      onRetry: cubit.load,
                    )
                  : const Center(child: CircularProgressIndicator());
            }

            return RefreshableStateView(
              onRefresh: cubit.load,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                child: AttendanceSettingsForm(
                  key: ValueKey(settings),
                  settings: settings,
                  isSubmitting: state.isSubmitting,
                  onSave: (enforced, range) => _save(context, enforced, range),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
