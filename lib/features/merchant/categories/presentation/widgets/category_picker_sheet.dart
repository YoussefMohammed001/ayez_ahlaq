import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../domain/entities/merchant_category.dart';
import '../manager/merchant_categories_cubit.dart';
import '../manager/merchant_categories_state.dart';
import 'category_option_tile.dart';
import '../../../../../generated/l10n.dart';

class CategoryPickerSheet extends StatelessWidget {
  final int? selectedId;

  const CategoryPickerSheet({super.key, required this.selectedId});

  static Future<int?> show(BuildContext context, {int? selectedId}) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MerchantCategoriesCubit>(),
        child: CategoryPickerSheet(selectedId: selectedId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: S().chooseCategory),
              Flexible(child: _buildList(context, state.assignable)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<MerchantCategory> categories) {
    if (categories.isEmpty) {
      return AppEmptyState(
        icon: Icons.category_outlined,
        title: S().noOwnCategories,
        compact: true,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 4.h),
      itemCount: categories.length,
      itemBuilder: (_, index) => CategoryOptionTile(
        category: categories[index],
        selected: categories[index].id == selectedId,
        onTap: () => Navigator.of(context).pop(categories[index].id),
      ),
    );
  }
}
