import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../hours/presentation/widgets/working_day_row.dart';
import '../../../hours/domain/entities/working_week.dart';
import '../manager/home_service_hours_cubit.dart';
import '../manager/home_service_hours_state.dart';

class HomeServiceHoursScreen extends StatelessWidget {
  const HomeServiceHoursScreen({super.key});

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<HomeServiceHoursCubit>();
    final saved = await cubit.saveHours();

    if (!context.mounted) return;

    if (saved) showSuccess(S().hoursSaved);
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<HomeServiceHoursCubit, HomeServiceHoursState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().homeServiceHoursTitle),
        body: BlocBuilder<HomeServiceHoursCubit, HomeServiceHoursState>(
          builder: (context, state) {
            if (state.status == HomeServiceHoursStatus.loading &&
                state.days.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeServiceHoursStatus.failure &&
                state.days.isEmpty) {
              return AppErrorState(
                message: state.errorMessage,
                onRetry: context.read<HomeServiceHoursCubit>().loadHours,
              );
            }

            final cubit = context.read<HomeServiceHoursCubit>();

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
                  onPressed: state.days.isValid ? () => _submit(context) : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
