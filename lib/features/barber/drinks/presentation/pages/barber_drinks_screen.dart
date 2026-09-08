import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/drink.dart';
import '../manager/barber_drinks_cubit.dart';
import '../manager/barber_drinks_state.dart';
import '../widgets/drink_form_sheet.dart';
import '../widgets/drink_row.dart';

class BarberDrinksScreen extends StatelessWidget {
  const BarberDrinksScreen({super.key});

  Future<void> _confirmRemove(BuildContext context, Drink drink) async {
    final cubit = context.read<BarberDrinksCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteDrink,
      message: S().deleteDrinkConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
      isDestructive: true,
    );

    if (confirmed) await cubit.deleteDrink(drink.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().drinksTitle),
      body: BlocBuilder<BarberDrinksCubit, BarberDrinksState>(
        builder: (context, state) {
          if (state.status == BarberDrinksStatus.loading &&
              state.drinks.isEmpty) {
            return const ListSkeleton();
          }

          if (state.status == BarberDrinksStatus.failure &&
              state.drinks.isEmpty) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<BarberDrinksCubit>().loadDrinks,
            );
          }

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
            children: [
              SectionTitle(
                title: S().drinksSubtitle,
                actionLabel: S().addAction,
                onAction: () => DrinkFormSheet.show(context),
              ),
              if (state.drinks.isEmpty)
                AppEmptyState(
                  icon: Icons.local_cafe_outlined,
                  title: S().noDrinks,
                  message: S().noDrinksHint,
                )
              else
                for (final drink in state.drinks)
                  DrinkRow(
                    drink: drink,
                    onEdit: () => DrinkFormSheet.show(context, drink: drink),
                    onRemove: () => _confirmRemove(context, drink),
                  ),
            ],
          );
        },
      ),
    );
  }
}
