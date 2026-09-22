import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';

class BarberProfileDetailsScreen extends StatelessWidget {
  const BarberProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().profileDetailsTitle),
      body: BlocBuilder<BarberProfileCubit, BarberProfileState>(
        builder: (context, state) {
          final profile = state.profile;
          if (profile == null) return const SizedBox.shrink();

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              AppCard(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
                child: Column(
                  children: [
                    InfoRow(
                      icon: Icons.person_outline_rounded,
                      label: S().nameLabel,
                      value: profile.name,
                    ),
                    InfoRow(
                      icon: Icons.storefront_outlined,
                      label: S().shopLabel,
                      value: profile.shopName,
                    ),
                    InfoRow(
                      icon: Icons.call_outlined,
                      label: S().contact,
                      value: profile.phoneNumber,
                      verified: profile.active,
                    ),
                    InfoRow(
                      icon: Icons.star_border_rounded,
                      label: S().ratingLabel,
                      value: profile.ratingCount == 0
                          ? S().noReviewsYet
                          : '${profile.rating.toStringAsFixed(1)} (${profile.ratingCount})',
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
