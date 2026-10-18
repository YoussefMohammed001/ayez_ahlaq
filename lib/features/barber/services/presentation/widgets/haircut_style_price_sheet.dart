import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/shop_haircut_style.dart';

class HaircutStylePriceSheet extends StatefulWidget {
  final ShopHaircutStyle style;
  final Future<bool> Function(int priceDelta, bool active) onSubmit;

  const HaircutStylePriceSheet({
    super.key,
    required this.style,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required ShopHaircutStyle style,
    required Future<bool> Function(int priceDelta, bool active) onSubmit,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => HaircutStylePriceSheet(style: style, onSubmit: onSubmit),
    );
  }

  @override
  State<HaircutStylePriceSheet> createState() =>
      _HaircutStylePriceSheetState();
}

class _HaircutStylePriceSheetState extends State<HaircutStylePriceSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _priceDeltaController = TextEditingController(
    text: widget.style.priceDelta.toString(),
  );
  late bool _active = widget.style.active;
  bool _submitting = false;

  @override
  void dispose() {
    _priceDeltaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final priceDelta = int.parse(_priceDeltaController.text.trim());
    final saved = await widget.onSubmit(priceDelta, _active);

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
                SectionTitle(title: widget.style.name),
                SectionTitle(title: S().haircutStylePriceDeltaLabel),
                AppTextField(
                  controller: _priceDeltaController,
                  hint: S().haircutStylePriceDeltaHint,
                  validator: (v) =>
                      int.tryParse((v ?? '').trim()) == null
                          ? S().haircutStylePriceDeltaInvalid
                          : null,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S().haircutStyleActiveLabel,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    ToggleSwitch(
                      value: _active,
                      onTap: () => setState(() => _active = !_active),
                    ),
                  ],
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
