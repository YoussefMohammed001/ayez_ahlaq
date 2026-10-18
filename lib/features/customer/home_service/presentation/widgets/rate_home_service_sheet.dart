import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/rating_target.dart';
import '../../../../../shared/widgets/star_picker_row.dart';
import '../../domain/entities/home_service_request.dart';
import '../manager/home_service_request_detail_cubit.dart';
import '../manager/home_service_request_detail_state.dart';

class RateHomeServiceSheet extends StatefulWidget {
  final HomeServiceRequest request;

  const RateHomeServiceSheet({super.key, required this.request});

  static Future<void> show(BuildContext context, HomeServiceRequest request) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<HomeServiceRequestDetailCubit>(),
        child: RateHomeServiceSheet(request: request),
      ),
    );
  }

  @override
  State<RateHomeServiceSheet> createState() => _RateHomeServiceSheetState();
}

class _RateHomeServiceSheetState extends State<RateHomeServiceSheet> {
  late RatingTarget _target = widget.request.ratedBarber
      ? RatingTarget.shop
      : RatingTarget.barber;
  final _noteController = TextEditingController();
  int _stars = 0;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_stars == 0) {
      showError(S().selectStarsError);
      return;
    }

    final cubit = context.read<HomeServiceRequestDetailCubit>();
    final note = _noteController.text.trim();
    final success = await cubit.rate(
      target: _target,
      stars: _stars,
      note: note.isEmpty ? null : note,
    );
    if (!mounted) return;

    if (!success) {
      if (cubit.state.errorMessage != null)
        showError(cubit.state.errorMessage!);
      return;
    }

    if (_target == RatingTarget.barber && !widget.request.ratedShop) {
      setState(() {
        _target = RatingTarget.shop;
        _stars = 0;
        _noteController.clear();
      });
      return;
    }

    showSuccess(S().ratingSubmittedMessage);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isBarber = _target == RatingTarget.barber;
    final name = widget.request.shopName ?? '';

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
          SectionTitle(
            title: isBarber ? S().rateBarberTitle : S().rateShopTitle,
          ),
          Text(
            isBarber
                ? S().rateBarberSubtitle(name)
                : S().rateShopSubtitle(name),
            style: TextStyle(fontSize: 12.5.sp),
          ),
          SizedBox(height: 18.h),
          StarPickerRow(
            stars: _stars,
            onChanged: (s) => setState(() => _stars = s),
          ),
          SizedBox(height: 18.h),
          TextField(
            controller: _noteController,
            maxLines: 3,
            style: TextStyle(fontSize: 13.5.sp),
            decoration: AppInputDecoration.build(context, S().rateNoteHint),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<
            HomeServiceRequestDetailCubit,
            HomeServiceRequestDetailState
          >(
            builder: (context, state) => PrimaryCtaButton(
              label: S().submitRating,
              isLoading: state.isRating,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
