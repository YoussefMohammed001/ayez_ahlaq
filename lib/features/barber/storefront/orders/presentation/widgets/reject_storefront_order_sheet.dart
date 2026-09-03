import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../manager/barber_storefront_orders_cubit.dart';

class RejectStorefrontOrderSheet extends StatefulWidget {
  final int orderId;

  const RejectStorefrontOrderSheet({super.key, required this.orderId});

  static Future<void> show(BuildContext context, int orderId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<BarberStorefrontOrdersCubit>(),
        child: RejectStorefrontOrderSheet(orderId: orderId),
      ),
    );
  }

  @override
  State<RejectStorefrontOrderSheet> createState() =>
      _RejectStorefrontOrderSheetState();
}

class _RejectStorefrontOrderSheetState
    extends State<RejectStorefrontOrderSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final reason = _controller.text.trim();
    if (reason.isEmpty) return;

    context
        .read<BarberStorefrontOrdersCubit>()
        .rejectOrder(widget.orderId, reason);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        0,
        20.w,
        MediaQuery.viewInsetsOf(context).bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: S().rejectReason),
          TextField(
            controller: _controller,
            maxLines: 3,
            style: TextStyle(
              color: context.colorScheme.onSurface,
              fontSize: 13.5.sp,
            ),
            decoration: AppInputDecoration.build(context, S().rejectReasonHint),
          ),
          SizedBox(height: 16.h),
          PrimaryCtaButton(label: S().confirmReject, onPressed: _submit),
        ],
      ),
    );
  }
}
