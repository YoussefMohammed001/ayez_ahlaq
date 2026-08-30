import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/merchant_state.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/common.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController(text: '50');
  final _minOrderController = TextEditingController(text: '6');
  final _descController = TextEditingController();
  late String _category = MockData.categories.first;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _minOrderController.dispose();
    _descController.dispose();
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
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.rust400)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'إضافة منتج للجملة'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          children: [
            const Text(
              'المنتج ده هيبان بس في متجر المستلزمات جوه تطبيق الحلاقين، مش لعملاء عاديين.',
              style: TextStyle(fontSize: 12.5, color: AppColors.ivory500, height: 1.8),
            ),
            const SectionTitle(title: 'اسم المنتج'),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('مثلاً: وكس تثبيت قوي - عبوة صالونات'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'اكتب اسم المنتج' : null,
            ),
            const SectionTitle(title: 'الفئة'),
            DropdownButtonFormField<String>(
              value: _category,
              dropdownColor: AppColors.ink800,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('اختار فئة'),
              items: [for (final c in MockData.categories) DropdownMenuItem(value: c, child: Text(c))],
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: 'سعر الوحدة (جنيه)'),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppColors.ivory100),
                        decoration: _decoration('120'),
                        validator: (v) => (int.tryParse(v ?? '') ?? 0) <= 0 ? 'سعر غلط' : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: 'الحد الأدنى للطلب'),
                      TextFormField(
                        controller: _minOrderController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: AppColors.ivory100),
                        decoration: _decoration('6'),
                        validator: (v) => (int.tryParse(v ?? '') ?? 0) <= 0 ? 'رقم غلط' : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SectionTitle(title: 'الكمية المتاحة في المخزن'),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('50'),
              validator: (v) => (int.tryParse(v ?? '') ?? -1) < 0 ? 'رقم غلط' : null,
            ),
            const SectionTitle(title: 'وصف المنتج'),
            TextFormField(
              controller: _descController,
              maxLines: 4,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('اكتب وصف قصير للمنتج ومميزاته للحلاقين'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'اكتب وصف قصير' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brass500,
                foregroundColor: AppColors.ink950,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                context.read<MerchantState>().addProduct(
                      name: _nameController.text.trim(),
                      category: _category,
                      price: int.parse(_priceController.text),
                      description: _descController.text.trim(),
                      stock: int.parse(_stockController.text),
                      minOrderQty: int.parse(_minOrderController.text),
                    );
                Navigator.of(context).pop();
              },
              child: const Text('نشر المنتج', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
