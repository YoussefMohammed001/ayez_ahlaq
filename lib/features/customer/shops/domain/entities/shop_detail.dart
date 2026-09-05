import 'package:equatable/equatable.dart';
import 'haircut_style.dart';
import 'shop.dart';
import 'shop_addon.dart';
import 'shop_barber.dart';
import 'shop_payment_method.dart';

class ShopDetail extends Equatable {
  final Shop shop;
  final List<ShopBarber> barbers;
  final List<HaircutStyle> haircutStyles;
  final List<ShopPaymentMethod> paymentMethods;
  final List<ShopAddon> addons;

  const ShopDetail({
    required this.shop,
    required this.barbers,
    required this.haircutStyles,
    required this.paymentMethods,
    required this.addons,
  });

  ShopDetail copyWith({List<ShopBarber>? barbers}) {
    return ShopDetail(
      shop: shop,
      barbers: barbers ?? this.barbers,
      haircutStyles: haircutStyles,
      paymentMethods: paymentMethods,
      addons: addons,
    );
  }

  @override
  List<Object?> get props => [
    shop,
    barbers,
    haircutStyles,
    paymentMethods,
    addons,
  ];
}
