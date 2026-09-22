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
import '../manager/money_entries_cubit.dart';
import '../manager/money_entries_state.dart';

class MoneyEntryFormSheet extends StatefulWidget {
  const MoneyEntryFormSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MoneyEntriesCubit>(),
        child: const MoneyEntryFormSheet(),
      ),
    );
  }

  @override
  State<MoneyEntryFormSheet> createState() => _MoneyEntryFormSheetState();
}

class _MoneyEntryFormSheetState extends State<MoneyEntryFormSheet> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  MoneyDirection _direction = MoneyDirection.subtract;
  bool _submitting = false;

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
    final saved = await context.read<MoneyEntriesCubit>().createEntry(
      description: description,
      amount: amount,
      direction: _direction,
    );

    if (!mounted) return;
    setState(() => _submitting = false);
    if (saved) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<MoneyEntriesCubit, MoneyEntriesState>(
      isBusy: (state) => state.isSubmitting,
      errorMessage: (state) => state.errorMessage,
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20.w,
        0,
        20.w,
        MediaQuery.viewInsetsOf(context).bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: S().moneyNewEntry),
          AppTextField(controller: _descriptionController, hint: S().moneyDescriptionHint),
          SectionTitle(title: S().moneyAmountLabel),
          AppTextField(controller: _amountController, hint: S().moneyAmountHint, isNumber: true),
          SectionTitle(title: S().moneyDirectionLabel),
          Row(
            children: [
              Expanded(
                child: OptionTile(
                  label: S().moneyDirectionAdd,
                  icon: Icons.add,
                  selected: _direction == MoneyDirection.add,
                  onTap: () => setState(() => _direction = MoneyDirection.add),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: OptionTile(
                  label: S().moneyDirectionSubtract,
                  icon: Icons.remove,
                  selected: _direction == MoneyDirection.subtract,
                  onTap: () => setState(() => _direction = MoneyDirection.subtract),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          PrimaryCtaButton(label: S().add, isLoading: _submitting, onPressed: _submit),
        ],
      ),
    );
  }
}
