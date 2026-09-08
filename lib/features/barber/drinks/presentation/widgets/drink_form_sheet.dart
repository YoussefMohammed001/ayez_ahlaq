import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/switch_row_widget.dart';
import '../../domain/entities/drink.dart';
import '../manager/barber_drinks_cubit.dart';
import '../manager/barber_drinks_state.dart';

class DrinkFormSheet extends StatefulWidget {
  final Drink? drink;

  const DrinkFormSheet({super.key, this.drink});

  static Future<void> show(BuildContext context, {Drink? drink}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<BarberDrinksCubit>(),
        child: DrinkFormSheet(drink: drink),
      ),
    );
  }

  @override
  State<DrinkFormSheet> createState() => _DrinkFormSheetState();
}

class _DrinkFormSheetState extends State<DrinkFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late bool _active;

  bool get _isEditing => widget.drink != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.drink?.name ?? '');
    _priceController = TextEditingController(
      text: widget.drink == null ? '' : widget.drink!.price.toString(),
    );
    _active = widget.drink?.active ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<BarberDrinksCubit>();
    final name = _nameController.text.trim();
    final price = int.parse(_priceController.text.trim());

    final saved = _isEditing
        ? await cubit.updateDrink(
            id: widget.drink!.id,
            name: name,
            price: price,
            active: _active,
          )
        : await cubit.createDrink(name: name, price: price);

    if (!mounted) return;

    if (saved) {
      Navigator.of(context).pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        0,
        20.w,
        MediaQuery.viewInsetsOf(context).bottom + 24.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: _isEditing ? S().editDrink : S().addDrink),
            AppTextField(
              controller: _nameController,
              hint: S().drinkNameHint,
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? S().drinkNameRequired : null,
            ),
            SectionTitle(title: S().drinkPrice),
            AppTextField(
              controller: _priceController,
              hint: S().drinkPriceHint,
              isNumber: true,
              validator: _validatePrice,
            ),
            if (_isEditing)
              SwitchRow(
                label: S().drinkActive,
                value: _active,
                cs: context.colorScheme,
                onChanged: (value) => setState(() => _active = value),
              ),
            SizedBox(height: 16.h),
            BlocBuilder<BarberDrinksCubit, BarberDrinksState>(
              builder: (context, state) => PrimaryCtaButton(
                label: _isEditing ? S().save : S().add,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validatePrice(String? value) {
    final price = int.tryParse((value ?? '').trim());
    if (price == null || price < 0) return S().drinkPriceRequired;
    return null;
  }
}
