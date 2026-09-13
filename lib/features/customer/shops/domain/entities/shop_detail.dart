import 'package:equatable/equatable.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import 'haircut_style.dart';
import 'shop.dart';
import 'shop_addon.dart';
import 'shop_barber.dart';
import 'shop_drink.dart';

class ShopDetail extends Equatable {
  final Shop shop;
  final List<ShopBarber> barbers;
  final List<HaircutStyle> haircutStyles;
  final List<PaymentMethod> paymentMethods;
  final List<ShopAddon> addons;
  final List<ShopDrink> drinks;

  const ShopDetail({
    required this.shop,
    required this.barbers,
    required this.haircutStyles,
    required this.paymentMethods,
    required this.addons,
    this.drinks = const [],
  });

  ShopDetail copyWith({List<ShopBarber>? barbers}) {
    return ShopDetail(
      shop: shop,
      barbers: barbers ?? this.barbers,
      haircutStyles: haircutStyles,
      paymentMethods: paymentMethods,
      addons: addons,
      drinks: drinks,
    );
  }

  @override
  List<Object?> get props => [
    shop,
    barbers,
    haircutStyles,
    paymentMethods,
    addons,
    drinks,
  ];
}
