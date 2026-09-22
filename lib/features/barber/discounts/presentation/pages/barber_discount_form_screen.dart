import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../merchant/discounts/presentation/widgets/scope_selector.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../domain/entities/barber_discount.dart';
import '../manager/barber_discount_form_controllers.dart';
import '../manager/barber_discounts_cubit.dart';
import '../manager/barber_discounts_state.dart';
import '../widgets/barber_discount_form_fields.dart';
import '../../../../../generated/l10n.dart';

class BarberDiscountFormScreen extends StatefulWidget {
  final BarberDiscount? discount;

  const BarberDiscountFormScreen({super.key, this.discount});

  @override
  State<BarberDiscountFormScreen> createState() =>
      _BarberDiscountFormScreenState();
}

class _BarberDiscountFormScreenState extends State<BarberDiscountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late BarberDiscountFormControllers _controllers;
  bool _isLoading = false;

  bool get _isEditing => widget.discount != null;

  @override
  void initState() {
    super.initState();
    _controllers = BarberDiscountFormControllers(widget.discount);
    if (_isEditing) _refreshDiscount();
  }

  Future<void> _refreshDiscount() async {
    setState(() => _isLoading = true);

    final fresh = await context.read<BarberDiscountsCubit>().refreshDiscount(
      widget.discount!.id,
    );

    if (!mounted) return;

    setState(() {
      if (fresh != null) {
        _controllers.dispose();
        _controllers = BarberDiscountFormControllers(fresh);
      }
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<BarberDiscountsCubit>();
    final request = _controllers.buildRequest();
    final saved = _isEditing
        ? await cubit.updateDiscount(widget.discount!.id, request)
        : await cubit.createDiscount(request);

    if (!mounted) return;

    if (saved) {
      context.read<BarberStorefrontProductsCubit>().loadProducts();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: _isEditing ? S().editDiscount : S().newDiscount),
      body: _isLoading ? const ListSkeleton() : _buildForm(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
        children: [
          SectionTitle(title: S().discountType),
          ScopeSelector(
            value: _controllers.scope,
            onChanged: (value) =>
                setState(() => _controllers.onScopeChanged(value)),
          ),
          BarberDiscountFormFields(
            controllers: _controllers,
            onChanged: () => setState(() {}),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<BarberDiscountsCubit, BarberDiscountsState>(
            builder: (context, state) => PrimaryCtaButton(
              label: _isEditing ? S().save : S().createDiscount,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
