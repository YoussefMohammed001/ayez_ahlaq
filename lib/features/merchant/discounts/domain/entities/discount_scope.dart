enum DiscountScope {
  product,
  buyXGetY,
  orderTotal;

  static DiscountScope fromApi(String? value) => switch (value) {
    'BUY_X_GET_Y' => DiscountScope.buyXGetY,
    'ORDER_TOTAL' => DiscountScope.orderTotal,
    _ => DiscountScope.product,
  };

  String toApi() => switch (this) {
    DiscountScope.product => 'PRODUCT',
    DiscountScope.buyXGetY => 'BUY_X_GET_Y',
    DiscountScope.orderTotal => 'ORDER_TOTAL',
  };



  bool get needsProduct => this != DiscountScope.orderTotal;
}
