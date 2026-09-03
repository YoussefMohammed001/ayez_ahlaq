import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/service_catalog_item.dart';
import 'catalog_picker_field.dart';

class ServiceFormSheet extends StatefulWidget {
  final List<ServiceCatalogItem> catalog;
  final BarberService? existing;
  final bool isSubmitting;
  final Future<bool> Function(BarberService service) onSubmit;

  const ServiceFormSheet({
    super.key,
    required this.catalog,
    required this.isSubmitting,
    required this.onSubmit,
    this.existing,
  });

  static Future<void> show(
    BuildContext context, {
    required List<ServiceCatalogItem> catalog,
    required bool isSubmitting,
    required Future<bool> Function(BarberService service) onSubmit,
    BarberService? existing,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ServiceFormSheet(
        catalog: catalog,
        isSubmitting: isSubmitting,
        onSubmit: onSubmit,
        existing: existing,
      ),
    );
  }

  @override
  State<ServiceFormSheet> createState() => _ServiceFormSheetState();
}

class _ServiceFormSheetState extends State<ServiceFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _priceController = TextEditingController(
    text: widget.existing == null ? '' : '${widget.existing!.price}',
  );
  late final _durationController = TextEditingController(
    text: widget.existing == null ? '' : '${widget.existing!.durationMinutes}',
  );
  int? _catalogId;

  @override
  void initState() {
    super.initState();
    _catalogId = widget.existing?.catalogId;
  }

  @override
  void dispose() {
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_catalogId == null || !_formKey.currentState!.validate()) return;

    final catalogItem = widget.catalog.firstWhere((c) => c.id == _catalogId);

    final saved = await widget.onSubmit(
      BarberService(
        id: widget.existing?.id ?? 0,
        catalogId: catalogItem.id,
        name: catalogItem.name,
        description: catalogItem.description,
        price: int.parse(_priceController.text.trim()),
        durationMinutes: int.parse(_durationController.text.trim()),
        popular: widget.existing?.popular ?? false,
        active: widget.existing?.active ?? true,
      ),
    );

    if (saved && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
                SectionTitle(
                  title: widget.existing == null
                      ? S().addServiceTitle
                      : S().editServiceTitle,
                ),
                CatalogPickerField(
                  catalog: widget.catalog,
                  value: _catalogId,
                  enabled: widget.existing == null,
                  onChanged: (value) => setState(() => _catalogId = value),
                ),
                SectionTitle(title: S().servicePriceLabel),
                AppTextField(
                  controller: _priceController,
                  hint: S().servicePriceHint,
                  isNumber: true,
                  validator: (v) => (int.tryParse(v ?? '') ?? -1) <= 0
                      ? S().invalidPrice
                      : null,
                ),
                SectionTitle(title: S().serviceDurationLabel),
                AppTextField(
                  controller: _durationController,
                  hint: S().serviceDurationHint,
                  isNumber: true,
                  validator: (v) => (int.tryParse(v ?? '') ?? -1) <= 0
                      ? S().invalidNumber
                      : null,
                ),
                SizedBox(height: 20.h),
                PrimaryCtaButton(
                  label: S().save,
                  isLoading: widget.isSubmitting,
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
