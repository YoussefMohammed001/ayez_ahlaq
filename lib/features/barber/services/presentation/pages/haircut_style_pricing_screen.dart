import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/shop_haircut_styles_cubit.dart';
import '../manager/shop_haircut_styles_state.dart';
import '../widgets/shop_haircut_styles_section.dart';

class HaircutStylePricingScreen extends StatefulWidget {
  const HaircutStylePricingScreen({super.key});

  @override
  State<HaircutStylePricingScreen> createState() =>
      _HaircutStylePricingScreenState();
}

class _HaircutStylePricingScreenState
    extends State<HaircutStylePricingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopHaircutStylesCubit>().loadHaircutStyles();
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<ShopHaircutStylesCubit, ShopHaircutStylesState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().haircutStylesTitle),
        body: BlocBuilder<ShopHaircutStylesCubit, ShopHaircutStylesState>(
          builder: (context, state) {
            if (state.status == ShopHaircutStylesStatus.loading &&
                state.styles.isEmpty) {
              return const ListSkeleton();
            }

            if (state.status == ShopHaircutStylesStatus.failure &&
                state.styles.isEmpty) {
              return AppErrorState(
                message: state.errorMessage,
                onRetry: context.read<ShopHaircutStylesCubit>().loadHaircutStyles,
              );
            }

            if (state.styles.isEmpty) {
              return AppEmptyState(
                icon: Icons.content_cut_outlined,
                title: S().noHaircutStylesYet,
              );
            }

            return RefreshableStateView(
              onRefresh: context.read<ShopHaircutStylesCubit>().loadHaircutStyles,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                child: const ShopHaircutStylesSection(),
              ),
            );
          },
        ),
      ),
    );
  }
}
