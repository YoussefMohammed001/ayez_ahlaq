import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/rating_target.dart';
import '../../domain/entities/customer_rating.dart';

class CustomerRatingRow extends StatelessWidget {
  final CustomerRating rating;

  const CustomerRatingRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final isBarber = rating.target == RatingTarget.barber;
    final label = isBarber ? S().barberRatingLabel : S().shopRatingLabel;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rating.targetName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      label,
                      style: TextStyle(fontSize: 11.sp, color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < 5; i++)
                    Icon(
                      i < rating.stars ? Icons.star_rounded : Icons.star_border_rounded,
                      size: 14.r,
                      color: context.semantic.accentStrong,
                    ),
                ],
              ),
            ],
          ),
          if (rating.note != null && rating.note!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              rating.note!,
              style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant, height: 1.6),
            ),
          ],
          SizedBox(height: 6.h),
          Text(
            RelativeDateLabel.format(rating.createdAt),
            style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
