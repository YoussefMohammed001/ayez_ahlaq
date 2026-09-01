import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/merchant_category.dart';
import '../manager/merchant_categories_cubit.dart';
import '../manager/merchant_categories_state.dart';
import 'category_picker_sheet.dart';
import 'category_thumbnail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class CategoryPickerField extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const CategoryPickerField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  Future<void> _pick(BuildContext context) async {
    final picked = await CategoryPickerSheet.show(context, selectedId: value);
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
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
                CategoryThumbnail(category: selected, size: 44.r),
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

  MerchantCategory? _selected(List<MerchantCategory> categories) {
    if (value == null) return null;

    for (final category in categories) {
      if (category.id == value) return category;
    }

    return null;
  }
}
