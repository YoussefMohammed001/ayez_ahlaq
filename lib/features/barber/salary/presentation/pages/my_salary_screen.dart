import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/my_salary_cubit.dart';
import '../manager/salary_view_state.dart';
import '../widgets/salary_body.dart';

class MySalaryScreen extends StatelessWidget {
  const MySalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().mySalaryTitle),
      body: BlocBuilder<MySalaryCubit, SalaryViewState>(
        builder: (context, state) {
          final cubit = context.read<MySalaryCubit>();

          return RefreshableStateView(
            onRefresh: cubit.load,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              child: SalaryBody(
                state: state,
                cubit: cubit,
                notSetHint: S().salaryNotSetMemberHint,
              ),
            ),
          );
        },
      ),
    );
  }
}
