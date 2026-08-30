import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../domain/entities/discount.dart';
import '../manager/discount_form_controllers.dart';
import '../manager/merchant_discounts_cubit.dart';
import '../manager/merchant_discounts_state.dart';
import '../widgets/discount_form_fields.dart';
import '../widgets/scope_selector.dart';
import '../../../../../generated/l10n.dart';

class DiscountFormScreen extends StatefulWidget {
  final Discount? discount;

  const DiscountFormScreen({super.key, this.discount});

  @override
  State<DiscountFormScreen> createState() => _DiscountFormScreenState();
}

class _DiscountFormScreenState extends State<DiscountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _controllers = DiscountFormControllers(widget.discount);

  bool get _isEditing => widget.discount != null;

  @override
  void initState() {
    super.initState();
    context.read<MerchantDiscountsCubit>().loadShops();
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<MerchantDiscountsCubit>();
    final request = _controllers.buildRequest();
    final saved = _isEditing
        ? await cubit.updateDiscount(widget.discount!.id, request)
        : await cubit.createDiscount(request);

    if (!mounted) return;

    if (saved) {
      context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: _isEditing ? S().editDiscount : S().newDiscount,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            SectionTitle(title: S().discountType),
            ScopeSelector(
              value: _controllers.scope,
              onChanged: (value) => setState(
                () => _controllers.onScopeChanged(value),
              ),
            ),
            DiscountFormFields(
              controllers: _controllers,
              onChanged: () => setState(() {}),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<MerchantDiscountsCubit, MerchantDiscountsState>(
              builder: (context, state) => PrimaryCtaButton(
                label: _isEditing ? S().save : S().createDiscount,
                isLoading: state.isSubmitting,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
