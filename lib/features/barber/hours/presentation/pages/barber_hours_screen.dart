import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_hours_cubit.dart';
import '../manager/barber_hours_state.dart';
import '../widgets/working_day_row.dart';

class BarberHoursScreen extends StatelessWidget {
  const BarberHoursScreen({super.key});

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<BarberHoursCubit>();
    final saved = await cubit.saveHours();

    if (!context.mounted) return;

    if (saved) {
      showSuccess(S().hoursSaved);
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().workingHoursTitle),
      body: BlocBuilder<BarberHoursCubit, BarberHoursState>(
        builder: (context, state) {
          if (state.status == BarberHoursStatus.loading && state.days.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BarberHoursStatus.failure && state.days.isEmpty) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<BarberHoursCubit>().loadHours,
            );
          }

          final cubit = context.read<BarberHoursCubit>();

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              for (final day in state.days)
                WorkingDayRow(
                  day: day,
                  onToggle: (value) => cubit.updateDay(
                    day.dayOfWeek,
                    (d) => d.copyWith(isOpen: value),
                  ),
                  onOpenTimeChanged: (value) => cubit.updateDay(
                    day.dayOfWeek,
                    (d) => d.copyWith(openTime: value),
                  ),
                  onCloseTimeChanged: (value) => cubit.updateDay(
                    day.dayOfWeek,
                    (d) => d.copyWith(closeTime: value),
                  ),
                ),
              SizedBox(height: 12.h),
              PrimaryCtaButton(
                label: S().save,
                isLoading: state.isSubmitting,
                onPressed: () => _submit(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
