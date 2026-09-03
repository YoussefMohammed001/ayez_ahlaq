import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_category.dart';
import '../manager/barber_storefront_categories_cubit.dart';
import '../manager/barber_storefront_categories_state.dart';
import 'storefront_category_picker_sheet.dart';
import 'storefront_category_thumbnail.dart';

class StorefrontCategoryPickerField extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const StorefrontCategoryPickerField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  Future<void> _pick(BuildContext context) async {
    final picked = await StorefrontCategoryPickerSheet.show(
      context,
      selectedId: value,
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BarberStorefrontCategoriesCubit,
      BarberStorefrontCategoriesState
    >(
      builder: (context, state) {
        final selected = _selected(state.assignable);
        final scheme = context.colorScheme;

        return GestureDetector(
          onTap: () => _pick(context),
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: scheme.outline),
            ),
            child: Row(
              children: [
                StorefrontCategoryThumbnail(size: 44.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    selected?.name ?? S().chooseCategory,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                      color: selected == null
                          ? Theme.of(context).hintColor
                          : scheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20.r,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  StorefrontCategory? _selected(List<StorefrontCategory> categories) {
    if (value == null) return null;

    for (final category in categories) {
      if (category.id == value) return category;
    }

    return null;
  }
}
