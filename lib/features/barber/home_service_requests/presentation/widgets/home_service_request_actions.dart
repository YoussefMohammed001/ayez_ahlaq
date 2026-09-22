import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request.dart';
import '../manager/home_service_requests_cubit.dart';
import 'home_service_status_label.dart';
import 'reject_home_service_sheet.dart';

class HomeServiceRequestActions extends StatelessWidget {
  final HomeServiceRequest request;

  const HomeServiceRequestActions({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    if (request.status.needsDecision) return _buildDecisionButtons(context);

    if (request.status.isTerminal || request.nextStatuses.isEmpty) {
      return _buildTerminalNote(context);
    }

    return Column(
      children: [
        for (final next in request.nextStatuses)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: PrimaryCtaButton(
              label: S().moveStatusTo(next.label),
              onPressed: () => context
                  .read<HomeServiceRequestsCubit>()
                  .advanceStatus(request.id, next),
            ),
          ),
      ],
    );
  }

  Widget _buildDecisionButtons(BuildContext context) {
    if (request.priceConfirmationPending) {
      return Text(
        S().homeServiceAwaitingPriceConfirmation,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.semantic.warning,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
      );
    }

    return Column(
      children: [
        PrimaryCtaButton(
          label: S().acceptHomeServiceRequest,
          onPressed: () =>
              context.read<HomeServiceRequestsCubit>().accept(request.id),
        ),
        SizedBox(height: 10.h),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(52.h),
            side: BorderSide(color: context.colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          onPressed: () => RejectHomeServiceSheet.show(context, request.id),
          child: Text(
            S().rejectHomeServiceRequest,
            style: TextStyle(
              color: context.semantic.warning,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTerminalNote(BuildContext context) {
    return Center(
      child: Text(
        request.status.label,
        style: TextStyle(
          color: context.semantic.success,
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
