import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/merchant_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/merchant_widgets.dart';
import 'add_product_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MerchantState>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('منتجاتي', style: AppTextStyles.headingH2),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddProductScreen())),
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.brass500, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.add, color: AppColors.ink950, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
              child: Text('اللي بتعرضه هنا بيبان بس للحلاقين في متجر المستلزمات بتاعهم', style: AppTextStyles.bodySmall.copyWith(fontSize: 12)),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (var i = 0; i < state.products.length; i++)
                    ProductRow(
                      product: state.products[i],
                      onToggle: () => state.toggleProductActive(i),
                      onRemove: () => state.removeProduct(state.products[i].id),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
