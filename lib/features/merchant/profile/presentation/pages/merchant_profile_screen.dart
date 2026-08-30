import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../domain/entities/merchant_profile.dart';
import '../manager/merchant_profile_cubit.dart';
import '../manager/merchant_profile_state.dart';
import '../widgets/profile_admin_menu.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const MerchantProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading &&
                state.profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                SizedBox(height: 20.h),
                _buildHeader(context, state.profile),
                SizedBox(height: 18.h),
                if (state.profile != null) _buildInfo(state.profile!),
                ProfileAdminMenu(
                  profile: state.profile,
                  onLogout: onLogout,
                ),
                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MerchantProfile? profile) {
    final name = profile?.businessName ?? '';

    return Column(
      children: [
        AvatarCircle(
          initials: name.isEmpty ? S().avatarFallback : name.substring(0, 1),
          size: 84.r,
        ),
        SizedBox(height: 10.h),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          S().wholesaleSupplier,
          style: TextStyle(
            color: context.colorScheme.onSurfaceVariant,
            fontSize: 12.5.sp,
          ),
        ),
        SizedBox(height: 8.h),
        StatusBadge(
          label: (profile?.active ?? false) ? S().verifiedMerchant : S().underReview,
          tone: (profile?.active ?? false) ? BadgeTone.open : BadgeTone.gold,
        ),
      ],
    );
  }

  Widget _buildInfo(MerchantProfile profile) {
    return Column(
      children: [
        InfoRow(
          icon: Icons.person_outline,
          label: S().businessOwner,
          value: profile.ownerName,
        ),
        InfoRow(
          icon: Icons.call_outlined,
          label: S().contact,
          value: profile.phoneNumber,
        ),
        if (profile.email != null && profile.email!.isNotEmpty)
          InfoRow(
            icon: Icons.mail_outline,
            label: S().emailLabel,
            value: profile.email!,
          ),
      ],
    );
  }
}
