import 'merchant_product.dart';

extension ProductListExt on List<MerchantProduct> {
  List<MerchantProduct> without(int id) =>
      where((p) => p.id != id).toList();

  List<MerchantProduct> markInactive(int id) =>
      map((p) => p.id == id ? p.copyWith(active: false) : p).toList();

  List<MerchantProduct> replace(MerchantProduct product) =>
      map((p) => p.id == product.id ? product : p).toList();
}
