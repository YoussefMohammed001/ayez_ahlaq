import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../state/barber_state.dart';
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
  final _descController = TextEditingController();
  late String _category = MockData.productCategories.firstWhere((c) => c != 'الكل');

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
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
      appBar: const AppTopBar(title: 'إضافة منتج جديد'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          children: [
            const Text(
              'المنتج هيبان في متجرك الشخصي، وعملاؤك يقدروا يطلبوه منك مباشرة.',
              style: TextStyle(fontSize: 12.5, color: AppColors.ivory500, height: 1.8),
            ),
            const SectionTitle(title: 'اسم المنتج'),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('مثلاً: وكس الصالون الخاص'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'اكتب اسم المنتج' : null,
            ),
            const SectionTitle(title: 'الفئة'),
            DropdownButtonFormField<String>(
              value: _category,
              dropdownColor: AppColors.ink800,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('اختار فئة'),
              items: [
                for (final c in MockData.productCategories.where((c) => c != 'الكل'))
                  DropdownMenuItem(value: c, child: Text(c)),
              ],
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            const SectionTitle(title: 'السعر (جنيه)'),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('مثلاً: 120'),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n <= 0) return 'اكتب سعر صحيح';
                return null;
              },
            ),
            const SectionTitle(title: 'وصف المنتج'),
            TextFormField(
              controller: _descController,
              maxLines: 4,
              style: const TextStyle(color: AppColors.ivory100),
              decoration: _decoration('اكتب وصف قصير للمنتج ومميزاته'),
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
                context.read<BarberState>().addMyProduct(
                      name: _nameController.text.trim(),
                      category: _category,
                      price: int.parse(_priceController.text),
                      description: _descController.text.trim(),
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
