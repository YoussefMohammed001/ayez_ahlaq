import '../../domain/entities/shop_detail.dart';
import 'haircut_style_model.dart';
import 'shop_addon_model.dart';
import 'shop_barber_model.dart';
import 'shop_model.dart';
import 'shop_payment_method_model.dart';

class ShopDetailModel extends ShopDetail {
  const ShopDetailModel({
    required super.shop,
    required super.barbers,
    required super.haircutStyles,
    required super.paymentMethods,
    required super.addons,
  });

  factory ShopDetailModel.fromJson(Map<String, dynamic> json) {
    return ShopDetailModel(
      shop: ShopModel.fromJson(json['shop'] as Map<String, dynamic>? ?? {}),
      barbers: (json['barbers'] as List<dynamic>? ?? [])
          .map((e) => ShopBarberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      haircutStyles: (json['haircutStyles'] as List<dynamic>? ?? [])
          .map((e) => HaircutStyleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethods: (json['paymentMethods'] as List<dynamic>? ?? [])
          .map((e) => ShopPaymentMethodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      addons: (json['addons'] as List<dynamic>? ?? [])
          .map((e) => ShopAddonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
