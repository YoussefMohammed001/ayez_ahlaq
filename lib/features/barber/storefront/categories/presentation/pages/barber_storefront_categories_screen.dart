import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_empty_state.dart';
import '../../../../../../core/widgets/app_error_state.dart';
import '../../../../../../core/widgets/section_title.dart';
import '../../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../../core/widgets/list_skeleton.dart';
import '../../../../../../generated/l10n.dart';
import '../manager/barber_storefront_categories_cubit.dart';
import '../manager/barber_storefront_categories_state.dart';
import '../widgets/add_storefront_category_sheet.dart';
import '../widgets/storefront_category_row.dart';

class BarberStorefrontCategoriesScreen extends StatelessWidget {
  const BarberStorefrontCategoriesScreen({super.key});

  Future<void> _confirmRemove(BuildContext context, int id) async {
    final cubit = context.read<BarberStorefrontCategoriesCubit>();
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
    return BlocBuilder<
      BarberStorefrontCategoriesCubit,
      BarberStorefrontCategoriesState
    >(
      builder: (context, state) {
        if (state.status == StorefrontCategoriesStatus.loading &&
            state.assignable.isEmpty) {
          return const ListSkeleton();
        }

        if (state.status == StorefrontCategoriesStatus.failure &&
            state.assignable.isEmpty) {
          return AppErrorState(
            message: state.errorMessage,
            onRetry: context
                .read<BarberStorefrontCategoriesCubit>()
                .loadCategories,
          );
        }

        return ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            SectionTitle(
              title: S().myCategories,
              actionLabel: S().addAction,
              onAction: () => AddStorefrontCategorySheet.show(context),
            ),
            if (state.own.isEmpty)
              AppEmptyState(
                icon: Icons.category_outlined,
                title: S().noOwnCategories,
                compact: true,
              )
            else
              for (final category in state.own)
                StorefrontCategoryRow(
                  category: category,
                  onRemove: () => _confirmRemove(context, category.id),
                ),
            SectionTitle(title: S().globalCategories),
            for (final category in state.globalCategories)
              StorefrontCategoryRow(category: category),
          ],
        );
      },
    );
  }
}
