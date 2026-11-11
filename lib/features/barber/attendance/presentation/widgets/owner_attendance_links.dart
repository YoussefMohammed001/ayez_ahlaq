import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/menu_row.dart';
import '../../../../../generated/l10n.dart';

class OwnerAttendanceLinks extends StatelessWidget {
  final String teamRoute;
  final String settingsRoute;

  const OwnerAttendanceLinks({
    super.key,
    this.teamRoute = Routes.barberAttendanceTeamScreen,
    this.settingsRoute = Routes.barberAttendanceSettingsScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          MenuRow(
            icon: Icons.groups_outlined,
            label: S().attendanceTeamNowTitle,
            onTap: () => context.push(teamRoute),
          ),
          MenuRow(
            icon: Icons.tune_rounded,
            label: S().attendanceSettingsTitle,
            showDivider: false,
            onTap: () => context.push(settingsRoute),
          ),
        ],
      ),
    );
  }
}
