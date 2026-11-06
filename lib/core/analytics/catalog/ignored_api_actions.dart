import '../api_action_rule.dart';

class IgnoredApiActions {
  const IgnoredApiActions._();

  static final rules = <ApiActionRule>[
    ApiActionRule.post(r'^(customer|barber|merchant)/deviceToken$', ''),
    ApiActionRule.delete(
      r'^(customer|barber|merchant)/deviceToken(/all)?$',
      '',
    ),
    ApiActionRule.put(
      r'^(customer|barber|merchant)/notification/\d+/seen$',
      '',
    ),
    ApiActionRule.post(r'^barber/store/quote$', ''),
    ApiActionRule.post(r'^merchant/discount/quote$', ''),
    ApiActionRule.post(r'^barber/moneyPin/verify$', ''),
  ];
}
