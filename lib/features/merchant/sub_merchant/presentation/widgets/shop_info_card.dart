import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../profile/presentation/manager/merchant_profile_cubit.dart';
import '../../../profile/presentation/manager/merchant_profile_state.dart';

class ShopInfoCard extends StatelessWidget {
  const ShopInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
      buildWhen: (previous, current) => previous.profile != current.profile,
      builder: (context, state) {
        final profile = state.profile;
        if (profile == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().shopSection),
            AppCard(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  InfoRow(
                    icon: Icons.storefront_outlined,
                    label: S().businessName,
                    value: profile.businessName,
                  ),
                  InfoRow(
                    icon: Icons.call_outlined,
                    label: S().memberPhoneLabel,
                    value: profile.phoneNumber,
                    valueTextDirection: TextDirection.ltr,
                    showDivider: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
          ],
        );
      },
    );
  }
}
