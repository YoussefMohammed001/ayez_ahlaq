import '../../domain/entities/home_service_shop.dart';
import 'home_service_shop_list_args.dart';

class HomeServiceRequestArgs {
  final HomeServiceShop? shop;
  final HomeServiceShopListArgs dateTimeArgs;

  const HomeServiceRequestArgs({this.shop, required this.dateTimeArgs});
}
