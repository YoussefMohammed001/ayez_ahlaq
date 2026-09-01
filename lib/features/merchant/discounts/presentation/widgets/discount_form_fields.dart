import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../products/presentation/manager/merchant_products_cubit.dart';
import '../../domain/entities/discount_scope.dart';
import '../../domain/entities/reward_value_rules.dart';
import '../manager/discount_form_controllers.dart';
import 'product_selector.dart';
import 'reward_type_selector.dart';
import 'shop_selector.dart';
import '../../../../../generated/l10n.dart';

class DiscountFormFields extends StatelessWidget {
  final DiscountFormControllers controllers;
  final VoidCallback onChanged;

  const DiscountFormFields({
    super.key,
    required this.controllers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: S().discountName),
        AppTextField(
          controller: controllers.name,
          hint: S().discountNameHint,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? S().discountNameRequired : null,
        ),
        if (controllers.scope.needsProduct) ...[
          SectionTitle(title: S().product),
          ProductSelector(
            value: controllers.targetProductId,
            onChanged: (value) {
              controllers.targetProductId = value;
              onChanged();
            },
          ),
        ],
        if (controllers.scope == DiscountScope.buyXGetY) ...[
          SectionTitle(title: S().buyQuantityLabel),
          AppTextField(
            controller: controllers.buyQuantity,
            hint: '4',
            isNumber: true,
            validator: _positive,
          ),
          SectionTitle(title: S().rewardQuantityLabel),
          AppTextField(
            controller: controllers.rewardQuantity,
            hint: '1',
            isNumber: true,
            validator: _positive,
          ),
        ],
        if (controllers.scope == DiscountScope.orderTotal) ...[
          SectionTitle(title: S().minOrderTotalLabel),
          AppTextField(
            controller: controllers.minOrderTotal,
            hint: '1000',
            isNumber: true,
            validator: _positive,
          ),
        ],
        SectionTitle(title: S().rewardTypeLabel),
        RewardTypeSelector(
          value: controllers.rewardType,
          options: controllers.rewardOptions,
          onChanged: (value) {
            controllers.rewardType = value;
            onChanged();
          },
        ),
        if (controllers.rewardType.needsValue) ...[
          SectionTitle(title: S().discountValue),
          AppTextField(
            controller: controllers.rewardValue,
            hint: controllers.rewardType.isPercent ? '15' : '50',
            isNumber: true,
            validator: (value) => _validateRewardValue(context, value),
          ),
        ],
        SectionTitle(title: S().shops),
        ShopSelector(
          selected: controllers.shopIds,
          onChanged: (value) {
            controllers.shopIds = value;
            onChanged();
          },
        ),
      ],
    );
  }

  String? _positive(String? value) =>
      (int.tryParse(value ?? '') ?? 0) <= 0 ? S().invalidNumber : null;

  String? _validateRewardValue(BuildContext context, String? value) {
    final invalid = _positive(value);
    if (invalid != null) return invalid;

    final amount = num.parse(value!);
    final type = controllers.rewardType;

    if (RewardValueRules.exceedsPercent(type, amount)) {
      return S().percentAboveMax;
    }

    final ceiling = controllers.amountCeilingFor(_targetProductPrice(context));

    if (RewardValueRules.exceedsCeiling(type, amount, ceiling)) {
      return S().amountAboveTotal;
    }

    return null;
  }

  int? _targetProductPrice(BuildContext context) {
    final id = controllers.targetProductId;
    if (id == null) return null;

    for (final product in context.read<MerchantProductsCubit>().state.products) {
      if (product.id == id) return product.price;
    }

    return null;
  }
}
