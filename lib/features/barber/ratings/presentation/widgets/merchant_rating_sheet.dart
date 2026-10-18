import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/star_picker_row.dart';
import '../manager/pending_merchant_rating_cubit.dart';
import '../manager/pending_merchant_rating_state.dart';

class MerchantRatingSheet extends StatefulWidget {
  const MerchantRatingSheet({super.key});

  @override
  State<MerchantRatingSheet> createState() => _MerchantRatingSheetState();
}

class _MerchantRatingSheetState extends State<MerchantRatingSheet> {
  final _noteController = TextEditingController();
  int _stars = 0;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_stars == 0) {
      showError(S().selectStarsError);
      return;
    }
    final note = _noteController.text.trim();
    context.read<PendingMerchantRatingCubit>().submit(
      stars: _stars,
      note: note.isEmpty ? null : note,
    );
  }

  void _onStateChanged(BuildContext context, PendingMerchantRatingState state) {
    if (state.status == PendingMerchantRatingStatus.submitted) {
      showSuccess(S().ratingSubmittedMessage);
      Navigator.of(context).pop();
    }
    if (state.status == PendingMerchantRatingStatus.failure &&
        state.errorMessage != null) {
      showError(state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pending = context.read<PendingMerchantRatingCubit>().state.pending!;

    return BlocListener<PendingMerchantRatingCubit, PendingMerchantRatingState>(
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
            SectionTitle(title: S().merchantRatingTitle),
            Text(
              S().rateShopSubtitle(pending.merchantName),
              style: TextStyle(fontSize: 12.5.sp),
            ),
            SizedBox(height: 12.h),
            StarPickerRow(
              stars: _stars,
              onChanged: (s) => setState(() => _stars = s),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _noteController,
              maxLines: 2,
              style: TextStyle(fontSize: 13.5.sp),
              decoration: AppInputDecoration.build(context, S().rateNoteHint),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<PendingMerchantRatingCubit, PendingMerchantRatingState>(
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
