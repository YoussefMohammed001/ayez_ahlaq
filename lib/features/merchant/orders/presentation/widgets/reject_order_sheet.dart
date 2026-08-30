import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../manager/merchant_orders_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class RejectOrderSheet extends StatefulWidget {
  final int orderId;

  const RejectOrderSheet({super.key, required this.orderId});

  static Future<void> show(BuildContext context, int orderId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MerchantOrdersCubit>(),
        child: RejectOrderSheet(orderId: orderId),
      ),
    );
  }

  @override
  State<RejectOrderSheet> createState() => _RejectOrderSheetState();
}

class _RejectOrderSheetState extends State<RejectOrderSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final reason = _controller.text.trim();
    if (reason.isEmpty) return;

    context.read<MerchantOrdersCubit>().rejectOrder(widget.orderId, reason);
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
