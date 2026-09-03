import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/service_catalog_item.dart';

class CatalogPickerField extends StatelessWidget {
  final List<ServiceCatalogItem> catalog;
  final int? value;
  final ValueChanged<int?> onChanged;
  final bool enabled;

  const CatalogPickerField({
    super.key,
    required this.catalog,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  List<ServiceCatalogItem> _distinctById() {
    final seen = <int>{};
    return [
      for (final item in catalog)
        if (seen.add(item.id)) item,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final items = _distinctById();
    final selected = items.any((item) => item.id == value) ? value : null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: scheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: selected,
          hint: Text(
            S().chooseService,
            style: TextStyle(fontSize: 13.5.sp, color: Theme.of(context).hintColor),
          ),
          items: [
            for (final item in items)
              DropdownMenuItem(
                value: item.id,
                child: Text(
                  item.name,
                  style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
                ),
              ),
          ],
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}
