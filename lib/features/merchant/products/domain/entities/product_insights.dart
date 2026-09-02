import 'merchant_product.dart';

extension ProductInsights on List<MerchantProduct> {
  List<MerchantProduct> get outOfStock =>
      where((product) => product.isOutOfStock).toList();

  List<MerchantProduct> get discounted =>
      where((product) => product.hasDiscount).toList();

  List<MerchantProduct> get inactive =>
      where((product) => !product.active).toList();

  int get totalStockUnits =>
      fold(0, (sum, product) => sum + product.totalStock);

  List<MerchantProduct> get mostStocked {
    final sorted = [...this]
      ..sort((a, b) => b.totalStock.compareTo(a.totalStock));
    return sorted.take(3).toList();
  }

  List<MerchantProduct> get runningLow {
    final sorted = where((product) => !product.isOutOfStock).toList()
      ..sort((a, b) => a.totalStock.compareTo(b.totalStock));
    return sorted.take(3).toList();
  }
}
