import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../customer/booking/presentation/widgets/booking_payment_methods_row.dart';
import '../../../../barber/salary/presentation/helpers/salary_amount_validator.dart';
import '../manager/new_sale_cubit.dart';
import '../manager/new_sale_state.dart';
import 'new_sale_summary.dart';
import 'sale_products_section.dart';

typedef NewSaleSubmit =
    Future<void> Function({
      String? customerName,
      String? customerPhone,
      required double discount,
      String? note,
    });

class NewSaleForm extends StatefulWidget {
  final NewSaleSubmit onSubmit;

  const NewSaleForm({super.key, required this.onSubmit});

  @override
  State<NewSaleForm> createState() => _NewSaleFormState();
}

class _NewSaleFormState extends State<NewSaleForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _discountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _discountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _discount =>
      SalaryAmountValidator.parse(_discountController.text) ?? 0;

  String? _optional(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : text;
  }

  String? _validateDiscount(String? value) =>
      (value ?? '').trim().isEmpty || _discount >= 0
      ? null
      : S().saleDiscountInvalid;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      customerName: _optional(_nameController),
      customerPhone: _optional(_phoneController),
      discount: _discount,
      note: _optional(_noteController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
        children: [
          const SaleProductsSection(),
          SectionTitle(title: S().saleCustomerNameOptional),
          AppTextField(controller: _nameController, hint: S().memberNameHint),
          SectionTitle(title: S().customerPhoneLabelOptional),
          AppTextField(
            controller: _phoneController,
            hint: S().memberPhoneHint,
            isNumber: true,
            validator: (v) =>
                Validators.validateEgyptianPhoneNumber(v, isRequired: false),
          ),
          SectionTitle(title: S().paymentMethodLabel),
          BlocBuilder<NewSaleCubit, NewSaleState>(
            buildWhen: (previous, current) =>
                previous.methods != current.methods ||
                previous.paymentMethod != current.paymentMethod,
            builder: (context, state) => BookingPaymentMethodsRow(
              methods: state.methods,
              selectedCode: state.paymentMethod ?? '',
              onSelected: context.read<NewSaleCubit>().selectMethod,
            ),
          ),
          SectionTitle(title: S().saleDiscountLabel),
          AppTextField(
            controller: _discountController,
            hint: '0',
            isNumber: true,
            validator: _validateDiscount,
          ),
          SectionTitle(title: S().saleNoteOptional),
          AppTextField(controller: _noteController, maxLines: 2),
          SizedBox(height: 16.h),
          ListenableBuilder(
            listenable: _discountController,
            builder: (context, _) =>
                NewSaleSummary(discount: _discount, onSubmit: _submit),
          ),
        ],
      ),
    );
  }
}
