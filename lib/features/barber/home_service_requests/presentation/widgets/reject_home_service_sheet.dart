import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/home_service_requests_cubit.dart';

class RejectHomeServiceSheet extends StatefulWidget {
  final int requestId;

  const RejectHomeServiceSheet({super.key, required this.requestId});

  static Future<void> show(BuildContext context, int requestId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<HomeServiceRequestsCubit>(),
        child: RejectHomeServiceSheet(requestId: requestId),
      ),
    );
  }

  @override
  State<RejectHomeServiceSheet> createState() => _RejectHomeServiceSheetState();
}

class _RejectHomeServiceSheetState extends State<RejectHomeServiceSheet> {
  final _controller = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final reason = _controller.text.trim();
    if (_submitting || reason.isEmpty) return;

    setState(() => _submitting = true);

    final rejected = await context
        .read<HomeServiceRequestsCubit>()
        .reject(widget.requestId, reason);

    if (!mounted) return;
    if (rejected) {
      Navigator.of(context).pop();
    } else {
      setState(() => _submitting = false);
    }
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
          PrimaryCtaButton(
            label: S().confirmReject,
            isLoading: _submitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
