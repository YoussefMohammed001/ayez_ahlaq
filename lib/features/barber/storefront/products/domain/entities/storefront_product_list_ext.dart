import 'storefront_product.dart';

extension StorefrontProductListExt on List<StorefrontProduct> {
  List<StorefrontProduct> without(int id) =>
      where((p) => p.id != id).toList();

  List<StorefrontProduct> replace(StorefrontProduct product) =>
      map((p) => p.id == product.id ? product : p).toList();
}
