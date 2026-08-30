import 'package:flutter/widgets.dart';
import '../../data/requests/product_form_request.dart';
import '../../domain/entities/merchant_product.dart';

class ProductFormControllers {
  final TextEditingController name;
  final TextEditingController brand;
  final TextEditingController price;
  final TextEditingController stock;
  final TextEditingController minOrder;
  final TextEditingController description;

  int? categoryId;

  ProductFormControllers(MerchantProduct? product)
    : name = TextEditingController(text: product?.name),
      brand = TextEditingController(text: product?.brand),
      price = TextEditingController(text: product?.price.toString()),
      stock = TextEditingController(text: product?.totalStock.toString() ?? '50'),
      minOrder = TextEditingController(
        text: product?.minOrderQty.toString() ?? '6',
      ),
      description = TextEditingController(text: product?.description),
      categoryId = product?.categoryId;

  ProductFormRequest buildRequest({
    required List<String> imagePaths,
    List<int>? keepImageIds,
  }) {
    return ProductFormRequest(
      name: name.text.trim(),
      brand: brand.text.trim(),
      categoryId: categoryId,
      price: int.parse(price.text),
      description: description.text.trim(),
      stock: int.parse(stock.text),
      minOrderQty: int.parse(minOrder.text),
      imagePaths: imagePaths,
      keepImageIds: keepImageIds,
    );
  }

  void dispose() {
    name.dispose();
    brand.dispose();
    price.dispose();
    stock.dispose();
    minOrder.dispose();
    description.dispose();
  }
}
