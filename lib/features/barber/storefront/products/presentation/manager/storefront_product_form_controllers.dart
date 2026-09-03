import 'package:flutter/widgets.dart';
import '../../data/requests/storefront_product_form_request.dart';
import '../../domain/entities/storefront_product.dart';

class StorefrontProductFormControllers {
  final TextEditingController name;
  final TextEditingController brand;
  final TextEditingController price;
  final TextEditingController stock;
  final TextEditingController minOrder;
  final TextEditingController description;

  int? categoryId;

  StorefrontProductFormControllers(StorefrontProduct? product)
    : name = TextEditingController(text: product?.name),
      brand = TextEditingController(text: product?.brand),
      price = TextEditingController(text: product?.price.toString()),
      stock = TextEditingController(text: product?.stock.toString() ?? '50'),
      minOrder = TextEditingController(
        text: product?.minOrderQty.toString() ?? '1',
      ),
      description = TextEditingController(text: product?.description),
      categoryId = product?.categoryId;

  StorefrontProductFormRequest buildRequest({required List<String> imagePaths}) {
    return StorefrontProductFormRequest(
      name: name.text.trim(),
      brand: brand.text.trim(),
      categoryId: categoryId,
      price: int.parse(price.text),
      description: description.text.trim(),
      stock: int.parse(stock.text),
      minOrderQty: int.parse(minOrder.text),
      imagePaths: imagePaths,
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
