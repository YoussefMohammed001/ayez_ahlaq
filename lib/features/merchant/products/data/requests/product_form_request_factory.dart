import '../../domain/entities/merchant_product.dart';
import 'product_form_request.dart';

extension ProductFormRequestFactory on MerchantProduct {
  ProductFormRequest toFormRequest() => ProductFormRequest(
    name: name,
    brand: brand,
    categoryId: categoryId,
    description: description,
    price: price,
    minOrderQty: minOrderQty,
    stock: totalStock,
    keepImageIds: imageIds,
  );
}
