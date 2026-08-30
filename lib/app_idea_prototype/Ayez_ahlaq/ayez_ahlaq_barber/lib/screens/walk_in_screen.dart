import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/queue_entry.dart';
import '../models/shop_service.dart';
import '../state/barber_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/common.dart';

/// Registers a customer who walked in off the street rather than booking
/// through the app — available here and (once built) from the desktop
/// app too, since both read/write the same [BarberState].
class WalkInScreen extends StatefulWidget {
  const WalkInScreen({super.key});

  @override
  State<WalkInScreen> createState() => _WalkInScreenState();
}

class _WalkInScreenState extends State<WalkInScreen> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  late String _barberName = MockData.team.first.name;
  ShopService? _service;
  bool _alreadyDone = true;

  @override
  void initState() {
    super.initState();
    final services = context.read<BarberState>().services.where((s) => s.active);
    _service = services.isEmpty ? null : services.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.ivory700),
        filled: true,
        fillColor: AppColors.ink800,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.hairline)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.hairline)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.brass500, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BarberState>();
    final activeServices = state.services.where((s) => s.active).toList();

    return Scaffold(
      appBar: const AppTopBar(title: 'تسجيل عميل من الشارع'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          const Text(
            'لو عميل جالك من غير ما يحجز من التطبيق، سجله هنا عشان جدولك يتحدث ويبان صح للعملاء اللي بيحجزوا أونلاين.',
            style: TextStyle(fontSize: 12.5, color: AppColors.ivory500, height: 1.8),
          ),
          const SectionTitle(title: 'اسم العميل (اختياري)'),
          TextField(controller: _nameController, style: const TextStyle(color: AppColors.ivory100), decoration: _decoration('مثلاً: محمود سيد')),
          const SectionTitle(title: 'الحلاق اللي هيحلقله'),
          DropdownButtonFormField<String>(
            value: _barberName,
            dropdownColor: AppColors.ink800,
            style: const TextStyle(color: AppColors.ivory100),
            decoration: _decoration('اختار الحلاق'),
            items: [for (final m in MockData.team) DropdownMenuItem(value: m.name, child: Text(m.name))],
            onChanged: (v) => setState(() => _barberName = v ?? _barberName),
          ),
          const SectionTitle(title: 'نوع الخدمة'),
          DropdownButtonFormField<ShopService>(
            value: _service,
            dropdownColor: AppColors.ink800,
            style: const TextStyle(color: AppColors.ivory100),
            decoration: _decoration('اختار الخدمة'),
            items: [for (final s in activeServices) DropdownMenuItem(value: s, child: Text('${s.name} · ${s.price} ج'))],
            onChanged: (v) => setState(() => _service = v),
          ),
          const SectionTitle(title: 'المعاد'),
          TextField(
            controller: _timeController,
            style: const TextStyle(color: AppColors.ivory100),
            decoration: _decoration('مثلاً: 3:15'),
            onChanged: (_) => setState(() {}),
          ),
          const SectionTitle(title: 'حالته دلوقتي'),
          Row(
            children: [
              Expanded(
                child: _StatusChip(label: 'خلص بالفعل', selected: _alreadyDone, onTap: () => setState(() => _alreadyDone = true)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatusChip(label: 'قاعد على الكرسي دلوقتي', selected: !_alreadyDone, onTap: () => setState(() => _alreadyDone = false)),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brass500,
              foregroundColor: AppColors.ink950,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: _service == null || _timeController.text.trim().isEmpty
                ? null
                : () {
                    state.addWalkIn(
                      customerName: _nameController.text,
                      barberName: _barberName,
                      service: _service!.name,
                      price: _service!.price,
                      durationMinutes: _service!.durationMinutes,
                      time: _timeController.text.trim(),
                      status: _alreadyDone ? QueueStatus.done : QueueStatus.active,
                    );
                    Navigator.of(context).pop();
                  },
            child: const Text('تسجيل في الجدول', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _StatusChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.brass500.withOpacity(0.1) : AppColors.ink800,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.brass500 : AppColors.hairline, width: 1.5),
        ),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: selected ? AppColors.brass300 : AppColors.ivory300)),
      ),
    );
  }
}
