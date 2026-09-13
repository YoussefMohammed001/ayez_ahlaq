import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/service_catalog_item.dart';
import 'catalog_picker_field.dart';
import 'service_form_fields.dart';

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
  late bool _popular;

  @override
  void initState() {
    super.initState();
    _catalogId = widget.existing?.catalogId;
    _popular = widget.existing?.popular ?? false;
  }

  @override
  void dispose() {
    _priceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_catalogId == null || !_formKey.currentState!.validate()) return;

    final existing = widget.existing;
    final catalogItem = existing == null
        ? widget.catalog.firstWhere((c) => c.id == _catalogId)
        : null;

    final saved = await widget.onSubmit(
      BarberService(
        id: existing?.id ?? 0,
        catalogId: existing?.catalogId ?? catalogItem!.id,
        name: existing?.name ?? catalogItem!.name,
        description: existing?.description ?? catalogItem!.description,
        price: int.parse(_priceController.text.trim()),
        durationMinutes: int.parse(_durationController.text.trim()),
        popular: _popular,
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
                ServiceFormFields(
                  priceController: _priceController,
                  durationController: _durationController,
                  popular: _popular,
                  onPopularChanged: (value) => setState(() => _popular = value),
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
