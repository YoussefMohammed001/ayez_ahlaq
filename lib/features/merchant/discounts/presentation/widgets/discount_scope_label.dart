import '../../../../../generated/l10n.dart';
import '../../domain/entities/discount_scope.dart';

extension DiscountScopeLabel on DiscountScope {
  String get label => switch (this) {
    DiscountScope.product => S().scopeProduct,
    DiscountScope.buyXGetY => S().scopeBuyXGetY,
    DiscountScope.orderTotal => S().scopeOrderTotal,
  };

  String get hint => switch (this) {
    DiscountScope.product => S().scopeProductHint,
    DiscountScope.buyXGetY => S().scopeBuyXGetYHint,
    DiscountScope.orderTotal => S().scopeOrderTotalHint,
  };
}
