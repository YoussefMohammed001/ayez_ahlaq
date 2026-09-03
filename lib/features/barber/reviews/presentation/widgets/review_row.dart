import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/relative_date_label.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/barber_review.dart';

class ReviewRow extends StatelessWidget {
  final BarberReview review;

  const ReviewRow({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.customerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < 5; i++)
                    Icon(
                      i < review.stars ? Icons.star_rounded : Icons.star_border_rounded,
                      size: 14.r,
                      color: context.semantic.accentStrong,
                    ),
                ],
              ),
            ],
          ),
          if (review.note != null && review.note!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              review.note!,
              style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant, height: 1.6),
            ),
          ],
          SizedBox(height: 6.h),
          Text(
            RelativeDateLabel.format(review.createdAt),
            style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
