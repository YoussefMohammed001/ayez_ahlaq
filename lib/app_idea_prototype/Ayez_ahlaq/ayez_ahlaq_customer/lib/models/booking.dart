import 'shop.dart';
import 'barber.dart';
import 'service.dart';

class Booking {
  final String code;
  final Shop shop;
  final Barber barber;
  final BarberService service;
  final String styleName;
  final int totalPrice;
  final String dateLabel;
  final String time;
  final bool done;
  final int queueAhead;
  double rating;

  Booking({
    required this.code,
    required this.shop,
    required this.barber,
    required this.service,
    required this.styleName,
    required this.totalPrice,
    required this.dateLabel,
    required this.time,
    required this.done,
    this.queueAhead = 1,
    this.rating = 0,
  });
}
