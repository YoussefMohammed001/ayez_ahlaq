import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'common.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onQuickAdd;

  const ProductCard({super.key, required this.product, required this.onTap, required this.onQuickAdd});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink800,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientTile(colors: product.gradient, height: 92, width: double.infinity),
              const SizedBox(height: 7),
              SizedBox(
                height: 34,
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: AppColors.ivory100, height: 1.4),
                ),
              ),
              StarRating(rating: product.rating, size: 11),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${product.price} ج', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.brass300)),
                  GestureDetector(
                    onTap: onQuickAdd,
                    child: Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.brass500, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.add, size: 16, color: AppColors.ink950),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StickyFooter extends StatelessWidget {
  final Widget child;
  const StickyFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 22),
      decoration: const BoxDecoration(color: AppColors.ink900, border: Border(top: BorderSide(color: AppColors.hairline))),
      child: SafeArea(top: false, child: Row(children: [Expanded(child: child)])),
    );
  }
}

class PriceTotalLabel extends StatelessWidget {
  final String label;
  final String value;
  const PriceTotalLabel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(fontSize: 10.5)),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.brass300)),
      ],
    );
  }
}
