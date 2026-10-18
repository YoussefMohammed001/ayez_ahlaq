import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_request_adjustment.dart';
import '../manager/home_service_requests_cubit.dart';
import '../manager/home_service_requests_state.dart';
import 'home_service_adjustments_field.dart';

class EditHomeServicePriceSheet extends StatefulWidget {
  final HomeServiceRequest request;

  const EditHomeServicePriceSheet({super.key, required this.request});

  static Future<void> show(BuildContext context, HomeServiceRequest request) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<HomeServiceRequestsCubit>(),
        child: EditHomeServicePriceSheet(request: request),
      ),
    );
  }

  @override
  State<EditHomeServicePriceSheet> createState() =>
      _EditHomeServicePriceSheetState();
}

class _EditHomeServicePriceSheetState
    extends State<EditHomeServicePriceSheet> {
  late List<HomeServiceRequestAdjustment> _adjustments;

  @override
  void initState() {
    super.initState();
    _adjustments = widget.request.adjustments;
  }

  Future<void> _submit() async {
    final adjustments =
        _adjustments.where((a) => a.label.isNotEmpty || a.amount != 0).toList();

    if (adjustments.isEmpty) {
      showError(S().addAtLeastOneAdjustment);
      return;
    }

    final cubit = context.read<HomeServiceRequestsCubit>();
    final saved = await cubit.updatePrice(widget.request.id, adjustments);

    if (!mounted) return;
    if (saved) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: S().billAdjustments),
              HomeServiceAdjustmentsField(
                adjustments: _adjustments,
                onChanged: (adjustments) => _adjustments = adjustments,
              ),
              SizedBox(height: 16.h),
              BlocBuilder<HomeServiceRequestsCubit, HomeServiceRequestsState>(
                builder: (_, state) => PrimaryCtaButton(
                  label: S().save,
                  isLoading: state.updatingRequestId == widget.request.id,
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
