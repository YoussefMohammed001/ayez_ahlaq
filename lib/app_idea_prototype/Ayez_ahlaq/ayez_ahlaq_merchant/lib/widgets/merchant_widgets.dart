import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/purchase_order.dart';
import '../theme/app_colors.dart';
import 'common.dart';

class StatTile extends StatelessWidget {
  final String value;
  final String label;
  const StatTile({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.hairline)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, color: AppColors.brass300, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.ivory500), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

/// A tappable pill switch, same look as the barber app's toggle.
class ToggleSwitch extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;
  const ToggleSwitch({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 26,
        padding: const EdgeInsets.all(2),
        alignment: value ? Alignment.centerLeft : Alignment.centerRight,
        decoration: BoxDecoration(
          color: value ? AppColors.moss600 : AppColors.ink700,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: value ? AppColors.moss600 : AppColors.hairline),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: value ? Colors.white : AppColors.ivory500, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class ProductRow extends StatelessWidget {
  final Product product;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  const ProductRow({super.key, required this.product, required this.onToggle, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: product.active ? 1 : 0.5,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: AppColors.ink800, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
        child: Row(
          children: [
            GradientTile(colors: product.gradient, height: 54, width: 54, radius: 12),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: AppColors.ivory100, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('${product.price} ج · مخزون ${product.stock} · حد أدنى ${product.minOrderQty}', style: const TextStyle(fontSize: 10.5, color: AppColors.ivory500)),
                ],
              ),
            ),
            Column(
              children: [
                ToggleSwitch(value: product.active, onTap: onToggle),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.delete_outline, size: 18, color: AppColors.rust400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final PurchaseOrder order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tone = switch (order.status) {
      OrderStatus.processing => BadgeTone.gold,
      OrderStatus.shipped => BadgeTone.info,
      OrderStatus.delivered => BadgeTone.muted,
    };
    final itemsLabel = order.items.map((i) => '${i.qty}× ${i.productName}').join('، ');

    return Material(
      color: AppColors.ink800,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.hairline)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('${order.shopName} · ${order.barberName}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13.5, color: AppColors.ivory100, fontWeight: FontWeight.w700))),
                  Text(order.dateLabel, style: const TextStyle(fontSize: 10.5, color: AppColors.ivory500)),
                ],
              ),
              const SizedBox(height: 6),
              Text(itemsLabel, style: const TextStyle(fontSize: 11.5, color: AppColors.ivory500), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusBadge(label: order.status.label, tone: tone),
                  Text('${order.total} ج', style: const TextStyle(fontSize: 14, color: AppColors.brass300, fontWeight: FontWeight.w800)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
