import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/booking_flow_cubit.dart';

class ChooseStyleScreen extends StatelessWidget {
  const ChooseStyleScreen({super.key});

  void _proceed(BuildContext context) => context.push(Routes.customerChooseBarberScreen);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingFlowCubit>();
    final styles = cubit.state.shopDetail!.haircutStyles;

    return Scaffold(
      appBar: AppTopBar(title: S().chooseStyleTitle),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 12.h),
              children: [
                ...styles.map(
                  (style) => AppCard(
                    margin: EdgeInsets.only(bottom: 10.h),
                    onTap: () {
                      cubit.selectStyle(
                        haircutStyleId: style.id,
                        styleName: style.name,
                        priceDelta: style.priceDelta,
                      );
                      _proceed(context);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            style.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Text(
                          style.priceDelta > 0 ? '+${style.priceDelta}' : '${style.priceDelta}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: context.semantic.accentStrong,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
            child: PrimaryCtaButton(
              label: S().skip,
              onPressed: () {
                cubit.selectStyle();
                _proceed(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
