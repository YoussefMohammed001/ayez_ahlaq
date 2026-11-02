import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/customer_profile.dart';
import '../manager/customer_profile_cubit.dart';
import '../manager/customer_profile_state.dart';
import '../widgets/customer_profile_menu.dart';

class CustomerProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomerProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CustomerProfileCubit, CustomerProfileState>(
          builder: (context, state) {
            if (state.status == CustomerProfileStatus.loading &&
                state.profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                SizedBox(height: 20.h),
                _buildHeader(context, state.profile?.name ?? ''),
                if (state.profile != null) ...[
                  SizedBox(height: 18.h),
                  _buildInfoCard(context, state.profile!),
                ],
                SizedBox(height: 18.h),
                CustomerProfileMenu(onLogout: onLogout),
                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
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
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, CustomerProfile profile) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.call_outlined,
            label: S().contact,
            value: profile.phoneNumber,
            showDivider: profile.email != null,
            verified: profile.active,
            valueTextDirection: TextDirection.ltr,
          ),
          if (profile.email != null)
            InfoRow(
              icon: Icons.email_outlined,
              label: S().emailLabel,
              value: profile.email!,
              showDivider: false,
            ),
        ],
      ),
    );
  }
}
