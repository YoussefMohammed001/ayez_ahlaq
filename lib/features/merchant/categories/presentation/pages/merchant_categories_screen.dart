import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../manager/merchant_categories_cubit.dart';
import '../manager/merchant_categories_state.dart';
import '../widgets/add_category_sheet.dart';
import '../widgets/category_row.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantCategoriesScreen extends StatelessWidget {
  final int categoryLimit;

  const MerchantCategoriesScreen({super.key, required this.categoryLimit});

  Future<void> _confirmRemove(BuildContext context, int id) async {
    final cubit = context.read<MerchantCategoriesCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteCategory,
      message: S().deleteCategoryConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await cubit.deleteCategory(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().myCategories),
      body: BlocBuilder<MerchantCategoriesCubit, MerchantCategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading &&
              state.assignable.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == CategoriesStatus.failure &&
              state.assignable.isEmpty) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<MerchantCategoriesCubit>().loadCategories,
            );
          }

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              Text(
                S().categoriesNote(categoryLimit),
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.8,
                ),
              ),
              SectionTitle(
                title: S().myCategoriesCount(state.own.length, categoryLimit),
                actionLabel: state.own.length < categoryLimit ? S().addAction : null,
                onAction: () => AddCategorySheet.show(context),
              ),
              if (state.own.isEmpty)
                AppEmptyState(
                  icon: Icons.category_outlined,
                  title: S().noOwnCategories,
                  compact: true,
                )
              else
                for (final category in state.own)
                  CategoryRow(
                    category: category,
                    onRemove: () => _confirmRemove(context, category.id),
                    onTap: () =>
                        AddCategorySheet.show(context, category: category),
                  ),
              SectionTitle(title: S().globalCategories),
              for (final category in state.globalCategories)
                CategoryRow(category: category),
            ],
          );
        },
      ),
    );
  }
}
