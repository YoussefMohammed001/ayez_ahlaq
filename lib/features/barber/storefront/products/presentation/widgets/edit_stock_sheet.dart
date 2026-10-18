import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_text_field.dart';
import '../../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';

class EditStockSheet extends StatefulWidget {
  final int currentStock;
  final Future<bool> Function(int quantity) onSubmit;

  const EditStockSheet({
    super.key,
    required this.currentStock,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required int currentStock,
    required Future<bool> Function(int quantity) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditStockSheet(
        currentStock: currentStock,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<EditStockSheet> createState() => _EditStockSheetState();
}

class _EditStockSheetState extends State<EditStockSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _quantityController = TextEditingController(
    text: widget.currentStock.toString(),
  );
  bool _submitting = false;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final quantity = int.parse(_quantityController.text.trim());
    final saved = await widget.onSubmit(quantity);

    if (!mounted) return;
    setState(() => _submitting = false);
    if (saved) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: S().editStockTitle),
                AppTextField(
                  controller: _quantityController,
                  hint: S().stockQuantityHint,
                  isNumber: true,
                  validator: (v) =>
                      int.tryParse((v ?? '').trim()) == null
                          ? S().invalidNumber
                          : null,
                ),
                SizedBox(height: 20.h),
                PrimaryCtaButton(
                  label: S().save,
                  isLoading: _submitting,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
