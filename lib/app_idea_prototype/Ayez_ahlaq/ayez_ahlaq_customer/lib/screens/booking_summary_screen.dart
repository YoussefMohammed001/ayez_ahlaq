import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/cards.dart';
import '../widgets/common.dart';
import 'booking_success_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final date = MockData.dates.firstWhere((d) => d.id == state.selectedDateId);

    return Scaffold(
      appBar: const AppTopBar(title: 'ملخص الحجز'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.ink800,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: Column(
                    children: [
                      _SumRow(label: 'الصالون', value: state.selectedShop.name),
                      _SumRow(label: 'الحلاق', value: state.selectedBarber.name),
                      _SumRow(label: 'الخدمة', value: state.selectedService.name),
                      _SumRow(label: 'الشكل', value: state.selectedStyle.name),
                      _SumRow(label: 'المعاد', value: '${date.day} ${date.num} — ${state.selectedTime} م', last: true),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Divider(color: AppColors.hairline, height: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('الإجمالي', style: TextStyle(color: AppColors.ivory300, fontWeight: FontWeight.w700, fontSize: 13)),
                            Text('${state.totalServicePrice} ج', style: const TextStyle(color: AppColors.brass300, fontWeight: FontWeight.w800, fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SectionTitle(title: 'طريقة الدفع'),
                Row(
                  children: [
                    Expanded(
                      child: _PayOption(
                        icon: Icons.payments_outlined,
                        label: 'كاش عند الوصول',
                        selected: state.bookingPayment == PaymentMethod.cash,
                        onTap: () => state.setBookingPayment(PaymentMethod.cash),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _PayOption(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'بطاقة/محفظة',
                        selected: state.bookingPayment == PaymentMethod.card,
                        onTap: () => state.setBookingPayment(PaymentMethod.card),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.ink800,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'ملاحظة للحلاق (اختياري)',
                      hintStyle: TextStyle(color: AppColors.ivory700),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: AppColors.ivory100),
                  ),
                ),
              ],
            ),
          ),
          StickyFooter(
            child: Row(
              children: [
                PriceTotalLabel(label: 'هيتدفع', value: '${state.totalServicePrice} ج'),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brass500,
                    foregroundColor: AppColors.ink950,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 26),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    final booking = state.confirmBooking();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => BookingSuccessScreen(bookingCode: booking.code)),
                    );
                  },
                  child: const Text('تأكيد الحجز', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SumRow extends StatelessWidget {
  final String label;
  final String value;
  final bool last;
  const _SumRow({required this.label, required this.value, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: AppColors.hairline)),
      ),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(label, style: AppTextStyles.bodySmall.copyWith(fontSize: 11.5))),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: const TextStyle(color: AppColors.ivory100, fontWeight: FontWeight.w600, fontSize: 13.5))),
        ],
      ),
    );
  }
}

class _PayOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PayOption({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.brass500.withOpacity(0.08) : AppColors.ink800,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.brass500 : AppColors.hairline, width: 1.5),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: selected ? AppColors.brass400 : AppColors.ivory300),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.ivory100)),
          ],
        ),
      ),
    );
  }
}
