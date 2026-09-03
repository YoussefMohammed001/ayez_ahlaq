import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../hours/presentation/widgets/working_day_row.dart';
import '../manager/member_hours_cubit.dart';
import '../manager/member_hours_state.dart';

class MemberHoursSection extends StatelessWidget {
  const MemberHoursSection({super.key});

  Future<void> _submit(BuildContext context) async {
    final cubit = context.read<MemberHoursCubit>();
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
    return BlocBuilder<MemberHoursCubit, MemberHoursState>(
      builder: (context, state) {
        final cubit = context.read<MemberHoursCubit>();

        if (state.status == MemberHoursStatus.loading && state.days.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MemberHoursStatus.failure && state.days.isEmpty) {
          return AppErrorState(
            compact: true,
            message: state.errorMessage,
            onRetry: () => cubit.loadHours(state.memberId!),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().memberHoursTitle),
            for (final day in state.days)
              WorkingDayRow(
                day: day,
                onToggle: (value) =>
                    cubit.updateDay(day.dayOfWeek, (d) => d.copyWith(isOpen: value)),
                onOpenTimeChanged: (value) =>
                    cubit.updateDay(day.dayOfWeek, (d) => d.copyWith(openTime: value)),
                onCloseTimeChanged: (value) =>
                    cubit.updateDay(day.dayOfWeek, (d) => d.copyWith(closeTime: value)),
              ),
            SizedBox(height: 8.h),
            PrimaryCtaButton(
              label: S().save,
              isLoading: state.isSubmitting,
              onPressed: () => _submit(context),
            ),
          ],
        );
      },
    );
  }
}
