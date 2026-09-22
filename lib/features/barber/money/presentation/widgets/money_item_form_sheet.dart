import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_frequency.dart';
import '../../domain/entities/money_item.dart';
import '../manager/money_items_cubit.dart';
import '../manager/money_items_state.dart';
import 'money_item_schedule_fields.dart';

class MoneyItemFormSheet extends StatefulWidget {
  final MoneyItem? item;

  const MoneyItemFormSheet({super.key, this.item});

  static Future<void> show(BuildContext context, {MoneyItem? item}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MoneyItemsCubit>(),
        child: MoneyItemFormSheet(item: item),
      ),
    );
  }

  @override
  State<MoneyItemFormSheet> createState() => _MoneyItemFormSheetState();
}

class _MoneyItemFormSheetState extends State<MoneyItemFormSheet> {
  late final _descriptionController = TextEditingController(text: widget.item?.description);
  late final _amountController = TextEditingController(text: widget.item?.amount.toString());
  late MoneyDirection _direction = widget.item?.direction ?? MoneyDirection.subtract;
  late MoneyFrequency _frequency = widget.item?.frequency ?? MoneyFrequency.daily;
  late int _dayOfWeek = widget.item?.dayOfWeek ?? 0;
  late int _dayOfMonth = widget.item?.dayOfMonth ?? 1;
  bool _submitting = false;

  bool get _isEditing => widget.item != null;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final description = _descriptionController.text.trim();
    final amount = int.tryParse(_amountController.text.trim()) ?? 0;
    if (description.isEmpty || amount <= 0) return;

    setState(() => _submitting = true);
    final cubit = context.read<MoneyItemsCubit>();
    final dayOfWeek = _frequency == MoneyFrequency.weekly ? _dayOfWeek : null;
    final dayOfMonth = _frequency == MoneyFrequency.monthly ? _dayOfMonth : null;

    final saved = _isEditing
        ? await cubit.update(
            id: widget.item!.id,
            description: description,
            amount: amount,
            direction: _direction,
            frequency: _frequency,
            dayOfWeek: dayOfWeek,
            dayOfMonth: dayOfMonth,
            active: widget.item!.active,
          )
        : await cubit.create(
            description: description,
            amount: amount,
            direction: _direction,
            frequency: _frequency,
            dayOfWeek: dayOfWeek,
            dayOfMonth: dayOfMonth,
          );

    if (!mounted) return;
    setState(() => _submitting = false);
    if (saved) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyItemsCubit, MoneyItemsState>(
      isBusy: (state) =>
          _isEditing && state.mutatingIds.contains(widget.item!.id),
      errorMessage: (state) => state.errorMessage,
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom + 24.h;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: _isEditing ? S().moneyEditItem : S().moneyNewItem),
          AppTextField(controller: _descriptionController, hint: S().moneyDescriptionHint),
          SectionTitle(title: S().moneyAmountLabel),
          AppTextField(controller: _amountController, hint: S().moneyAmountHint, isNumber: true),
          SectionTitle(title: S().moneyDirectionLabel),
          Row(
            children: [
              Expanded(child: _buildDirectionTile(MoneyDirection.add)),
              SizedBox(width: 10.w),
              Expanded(child: _buildDirectionTile(MoneyDirection.subtract)),
            ],
          ),
          MoneyItemScheduleFields(
            frequency: _frequency,
            onFrequencyChanged: (value) => setState(() => _frequency = value),
            dayOfWeek: _dayOfWeek,
            onDayOfWeekChanged: (value) => setState(() => _dayOfWeek = value),
            dayOfMonth: _dayOfMonth,
            onDayOfMonthChanged: (value) => setState(() => _dayOfMonth = value),
          ),
          SizedBox(height: 16.h),
          PrimaryCtaButton(
            label: _isEditing ? S().save : S().add,
            isLoading: _submitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionTile(MoneyDirection direction) {
    final isAdd = direction == MoneyDirection.add;
    return OptionTile(
      label: isAdd ? S().moneyDirectionAdd : S().moneyDirectionSubtract,
      icon: isAdd ? Icons.add : Icons.remove,
      selected: _direction == direction,
      onTap: () => setState(() => _direction = direction),
    );
  }
}
