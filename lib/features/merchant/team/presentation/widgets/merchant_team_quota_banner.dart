import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../subscription/domain/entities/subscription_quota.dart';
import '../../../subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../../subscription/presentation/manager/merchant_subscription_state.dart';

class MerchantTeamQuotaBanner extends StatelessWidget {
  const MerchantTeamQuotaBanner({super.key});

  String _value(SubscriptionQuota quota) {
    final cap = quota.cap;
    return cap == null
        ? S().quotaUnlimited
        : S().quotaUsedOfCap(quota.used, cap);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantSubscriptionCubit, MerchantSubscriptionState>(
      buildWhen: (previous, current) =>
          previous.subscription?.employees != current.subscription?.employees,
      builder: (context, state) {
        final quota = state.subscription?.employees;
        if (quota == null) return const SizedBox.shrink();

        return AppCard(
          margin: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(child: AppText(S().quotaEmployees, style: font13w600)),
              AppText(
                _value(quota),
                style: font13w700.copyWith(color: context.colorScheme.primary),
              ),
            ],
          ),
        );
      },
    );
  }
}
