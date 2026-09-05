import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/customer_booking.dart';
import '../../domain/entities/rating_target.dart';
import '../manager/booking_detail_cubit.dart';
import '../manager/booking_detail_state.dart';
import 'star_picker_row.dart';

class RateBookingSheet extends StatefulWidget {
  final CustomerBooking booking;

  const RateBookingSheet({super.key, required this.booking});

  static Future<void> show(BuildContext context, CustomerBooking booking) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<BookingDetailCubit>(),
        child: RateBookingSheet(booking: booking),
      ),
    );
  }

  @override
  State<RateBookingSheet> createState() => _RateBookingSheetState();
}

class _RateBookingSheetState extends State<RateBookingSheet> {
  late RatingTarget _target = widget.booking.ratedBarber
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

    final cubit = context.read<BookingDetailCubit>();
    final note = _noteController.text.trim();
    final success = await cubit.rateBooking(
      target: _target,
      stars: _stars,
      note: note.isEmpty ? null : note,
    );
    if (!mounted) return;

    if (!success) {
      if (cubit.state.errorMessage != null) showError(cubit.state.errorMessage!);
      return;
    }

    if (_target == RatingTarget.barber && !widget.booking.ratedShop) {
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
          SectionTitle(title: isBarber ? S().rateBarberTitle : S().rateShopTitle),
          Text(
            isBarber
                ? S().rateBarberSubtitle(widget.booking.barberName)
                : S().rateShopSubtitle(widget.booking.shopName),
            style: TextStyle(fontSize: 12.5.sp),
          ),
          SizedBox(height: 18.h),
          StarPickerRow(stars: _stars, onChanged: (s) => setState(() => _stars = s)),
          SizedBox(height: 18.h),
          TextField(
            controller: _noteController,
            maxLines: 3,
            style: TextStyle(fontSize: 13.5.sp),
            decoration: AppInputDecoration.build(context, S().rateNoteHint),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<BookingDetailCubit, BookingDetailState>(
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
