import '../../domain/entities/shop_payment_method.dart';

class ShopPaymentMethodModel extends ShopPaymentMethod {
  const ShopPaymentMethodModel({required super.id, required super.name});

  factory ShopPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return ShopPaymentMethodModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
