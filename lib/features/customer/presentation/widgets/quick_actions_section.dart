import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../generated/l10n.dart';
import 'quick_action_item.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().quickActionsTitle),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: Row(
            children: [
              Expanded(
                child: QuickActionItem(
                  icon: Icons.home_repair_service_outlined,
                  label: S().homeServiceShopListTitle,
                  onTap: () =>
                      context.push(Routes.customerHomeServiceShopListScreen),
                ),
              ),
              Expanded(
                child: QuickActionItem(
                  icon: Icons.event_note_outlined,
                  label: S().bookingsTitle,
                  onTap: () => context.push(Routes.customerBookingsScreen),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
