import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../tour/presentation/manager/barber_tour_cubit.dart';
import '../widgets/barber_help_entries.dart';
import '../widgets/help_faq_item.dart';
import '../widgets/help_tour_card.dart';

class BarberHelpScreen extends StatelessWidget {
  const BarberHelpScreen({super.key});

  void _startTour(BuildContext context) {
    final tourCubit = context.read<BarberTourCubit>();
    final router = GoRouter.of(context);
    while (router.canPop()) {
      router.pop();
    }
    tourCubit.requestTour();
  }

  @override
  Widget build(BuildContext context) {
    final entries = BarberHelpEntries.of(
      isTeamMember: UserHelpers.barberAccountKind.isTeamMember,
    );

    return Scaffold(
      appBar: AppTopBar(title: S().helpTitle),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
        children: [
          HelpTourCard(onTap: () => _startTour(context)),
          SizedBox(height: 22.h),
          Text(
            S().helpFaqSection,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          AppCard(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                for (final entry in entries) HelpFaqItem(entry: entry),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            S().helpContactHint,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
