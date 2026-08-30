import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_input_decoration.dart';
import '../manager/merchant_categories_cubit.dart';
import '../manager/merchant_categories_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class CategoryDropdown extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
      builder: (context, state) {
        final categories = state.assignable;
        final selected =
            categories.any((c) => c.id == value) ? value : null;

        return DropdownButtonFormField<int>(
          initialValue: selected,
          isExpanded: true,
          dropdownColor: context.colorScheme.surfaceContainer,
          decoration: AppInputDecoration.build(context, S().chooseCategory),
          style: TextStyle(
            color: context.colorScheme.onSurface,
            fontSize: 13.5.sp,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.colorScheme.onSurfaceVariant,
            size: 20.r,
          ),
          items: [
            for (final category in categories)
              DropdownMenuItem(
                value: category.id,
                child: Text(
                  category.global ? category.name : '${category.name} ★',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: onChanged,
        );
      },
    );
  }
}
