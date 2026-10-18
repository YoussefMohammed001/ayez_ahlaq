import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/star_picker_row.dart';
import '../manager/pending_visit_rating_cubit.dart';
import '../manager/pending_visit_rating_state.dart';

class VisitRatingSheet extends StatefulWidget {
  const VisitRatingSheet({super.key});

  @override
  State<VisitRatingSheet> createState() => _VisitRatingSheetState();
}

class _VisitRatingSheetState extends State<VisitRatingSheet> {
  final _noteController = TextEditingController();
  int _barberStars = 0;
  int _shopStars = 0;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    final pending = context.read<PendingVisitRatingCubit>().state.pending!;
    final rateBarber = pending.canRateBarber;
    final missingStars = rateBarber ? _barberStars == 0 : _shopStars == 0;
    if (missingStars) {
      showError(S().selectStarsError);
      return;
    }
    final note = _noteController.text.trim();
    context.read<PendingVisitRatingCubit>().submit(
      barberStars: rateBarber ? _barberStars : null,
      barberNote: rateBarber && note.isNotEmpty ? note : null,
      shopStars: pending.canRateShop && _shopStars > 0 ? _shopStars : null,
    );
  }

  void _onStateChanged(BuildContext context, PendingVisitRatingState state) {
    if (state.status == PendingVisitRatingStatus.submitted) {
      showSuccess(S().ratingSubmittedMessage);
      Navigator.of(context).pop();
    }
    if (state.status == PendingVisitRatingStatus.failure &&
        state.errorMessage != null) {
      showError(state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pending = context.read<PendingVisitRatingCubit>().state.pending!;

    return BlocListener<PendingVisitRatingCubit, PendingVisitRatingState>(
      listener: _onStateChanged,
      child: SingleChildScrollView(
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
            SectionTitle(title: S().visitRatingTitle),
            if (pending.canRateBarber) ...[
              Text(
                S().rateBarberSubtitle(pending.barberName),
                style: TextStyle(fontSize: 12.5.sp),
              ),
              SizedBox(height: 12.h),
              StarPickerRow(
                stars: _barberStars,
                onChanged: (s) => setState(() => _barberStars = s),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: _noteController,
                maxLines: 2,
                style: TextStyle(fontSize: 13.5.sp),
                decoration: AppInputDecoration.build(context, S().rateNoteHint),
              ),
              SizedBox(height: 18.h),
            ],
            if (pending.canRateShop) ...[
              Text(
                S().rateShopSubtitle(pending.shopName),
                style: TextStyle(fontSize: 12.5.sp),
              ),
              SizedBox(height: 12.h),
              StarPickerRow(
                stars: _shopStars,
                onChanged: (s) => setState(() => _shopStars = s),
              ),
              SizedBox(height: 16.h),
            ],
            BlocBuilder<PendingVisitRatingCubit, PendingVisitRatingState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().submitRating,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S().skipForNow),
            ),
          ],
        ),
      ),
    );
  }
}
