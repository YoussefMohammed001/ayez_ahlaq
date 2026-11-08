import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../manager/pending_deductions_count_cubit.dart';

class DeductionsEntryCard extends StatelessWidget {
  const DeductionsEntryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PendingDeductionsCountCubit>()..load(),
      child: const _EntryCardBody(),
    );
  }
}

class _EntryCardBody extends StatelessWidget {
  const _EntryCardBody();

  Future<void> _open(BuildContext context) async {
    final cubit = context.read<PendingDeductionsCountCubit>();
    await context.push(Routes.barberSalaryDeductionsScreen);
    cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BlocBuilder<PendingDeductionsCountCubit, int>(
      builder: (context, pending) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
        child: AppCard(
          padding: EdgeInsets.all(14.r),
          onTap: () => _open(context),
          child: Row(
            children: [
              Badge(
                isLabelVisible: pending > 0,
                label: Text('$pending'),
                child: Icon(
                  Icons.fact_check_outlined,
                  color: scheme.primary,
                  size: 28.r,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S().deductionsEntryTitle, style: font14w700),
                    SizedBox(height: 2.h),
                    Text(
                      pending > 0
                          ? S().deductionsEntryPending('$pending')
                          : S().deductionsEntryNone,
                      style: font12w400.copyWith(
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
  }
}
