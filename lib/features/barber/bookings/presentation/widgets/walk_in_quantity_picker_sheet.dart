import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/quantity_stepper.dart';

class WalkInQuantityPickerSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T item) nameOf;
  final int Function(T item) priceOf;
  final int Function(T item) quantityOf;
  final void Function(T item, int quantity) onQuantityChanged;

  const WalkInQuantityPickerSheet({
    super.key,
    required this.title,
    required this.items,
    required this.nameOf,
    required this.priceOf,
    required this.quantityOf,
    required this.onQuantityChanged,
  });

  static Future<void> show<T>(
    BuildContext context, {
    required String title,
    required List<T> items,
    required String Function(T item) nameOf,
    required int Function(T item) priceOf,
    required int Function(T item) quantityOf,
    required void Function(T item, int quantity) onQuantityChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WalkInQuantityPickerSheet<T>(
        title: title,
        items: items,
        nameOf: nameOf,
        priceOf: priceOf,
        quantityOf: quantityOf,
        onQuantityChanged: onQuantityChanged,
      ),
    );
  }

  @override
  State<WalkInQuantityPickerSheet<T>> createState() =>
      _WalkInQuantityPickerSheetState<T>();
}

class _WalkInQuantityPickerSheetState<T>
    extends State<WalkInQuantityPickerSheet<T>> {
  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final maxHeight = MediaQuery.of(context).size.height * 0.7;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.nameOf(item),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
                              ),
                              Text(
                                S().currencyEgp(widget.priceOf(item)),
                                style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        QuantityStepper(
                          quantity: widget.quantityOf(item),
                          onChanged: (value) {
                            setState(() => widget.onQuantityChanged(item, value));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            PrimaryCtaButton(
              label: S().walkInPickerDone,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
