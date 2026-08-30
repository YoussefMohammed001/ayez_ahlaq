import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/barber_widgets.dart';
import '../widgets/common.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'تقييمات العملاء'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
            child: Row(
              children: [
                const Text('4.9', style: TextStyle(fontSize: 32, color: AppColors.brass300, fontWeight: FontWeight.w700)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    StarRating(rating: 4.9, size: 14, showValue: false),
                    SizedBox(height: 3),
                    Text('من 410 تقييم', style: TextStyle(fontSize: 11.5, color: AppColors.ivory500)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final r in MockData.reviews) ReviewCard(review: r),
        ],
      ),
    );
  }
}
