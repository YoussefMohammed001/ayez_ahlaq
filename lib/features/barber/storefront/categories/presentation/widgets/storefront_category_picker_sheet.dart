import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/extensions/ext_theme.dart';
import '../../../../../../core/widgets/app_empty_state.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../generated/l10n.dart';
import '../../domain/entities/storefront_category.dart';
import '../manager/barber_storefront_categories_cubit.dart';
import '../manager/barber_storefront_categories_state.dart';
import 'add_storefront_category_sheet.dart';
import 'storefront_category_option_tile.dart';

class StorefrontCategoryPickerSheet extends StatelessWidget {
  final int? selectedId;

  const StorefrontCategoryPickerSheet({super.key, required this.selectedId});

  static Future<int?> show(BuildContext context, {int? selectedId}) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<BarberStorefrontCategoriesCubit>(),
        child: StorefrontCategoryPickerSheet(selectedId: selectedId),
      ),
    );
  }

  Future<void> _addNew(BuildContext context) async {
    final cubit = context.read<BarberStorefrontCategoriesCubit>();
    final previousCount = cubit.state.own.length;

    await AddStorefrontCategorySheet.show(context);

    if (!context.mounted) return;

    final createdOwn = cubit.state.own;
    if (createdOwn.length > previousCount) {
      Navigator.of(context).pop(createdOwn.last.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BarberStorefrontCategoriesCubit,
      BarberStorefrontCategoriesState
    >(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: S().chooseCategory),
              Flexible(child: _buildList(context, state.assignable)),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _addNew(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_rounded, size: 18.r, color: context.semantic.accentStrong),
                    SizedBox(width: 6.w),
                    Text(
                      S().newCategory,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: context.semantic.accentStrong,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<StorefrontCategory> categories) {
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
      itemBuilder: (_, index) => StorefrontCategoryOptionTile(
        category: categories[index],
        selected: categories[index].id == selectedId,
        onTap: () => Navigator.of(context).pop(categories[index].id),
      ),
    );
  }
}
