import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_broadcast_cubit.dart';

class HomeServiceBroadcastActions extends StatelessWidget {
  final int candidateId;

  const HomeServiceBroadcastActions({super.key, required this.candidateId});

  Future<void> _accept(BuildContext context) async {
    final cubit = context.read<HomeServiceBroadcastCubit>();
    final accepted = await cubit.accept(candidateId);
    if (!context.mounted) return;
    if (accepted) context.pop();
  }

  Future<void> _reject(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().homeServiceBroadcastRejectTitle,
      message: S().homeServiceBroadcastRejectMessage,
      confirmLabel: S().homeServiceBroadcastRejectConfirm,
    );
    if (!confirmed || !context.mounted) return;

    final cubit = context.read<HomeServiceBroadcastCubit>();
    final rejected = await cubit.reject(candidateId);
    if (!context.mounted) return;
    if (rejected) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryCtaButton(
          label: S().homeServiceBroadcastAccept,
          onPressed: () => _accept(context),
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.semantic.warning,
            foregroundColor: context.colorScheme.surfaceContainerLowest,
            minimumSize: Size.fromHeight(52.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          ),
          onPressed: () => _reject(context),
          child: Text(
            S().homeServiceBroadcastReject,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}
