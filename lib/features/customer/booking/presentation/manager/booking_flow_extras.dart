import '../../../shops/domain/entities/shop_addon.dart';
import '../../../shops/domain/entities/shop_drink.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';

abstract class BookingFlowExtras {
  static List<BookingAddon> withAddon(
    List<BookingAddon> current,
    ShopAddon addon,
    int quantity,
  ) {
    final next = current.where((a) => a.productId != addon.id).toList();
    if (quantity > 0) {
      next.add(
        BookingAddon(
          productId: addon.id,
          quantity: quantity,
          name: addon.name,
          price: addon.price,
        ),
      );
    }
    return next;
  }

  static List<BookingDrink> withDrink(
    List<BookingDrink> current,
    ShopDrink drink,
    int quantity,
  ) {
    final next = current.where((d) => d.drinkId != drink.id).toList();
    if (quantity > 0) {
      next.add(
        BookingDrink(
          drinkId: drink.id,
          quantity: quantity,
          name: drink.name,
          price: drink.price,
        ),
      );
    }
    return next;
  }
}
