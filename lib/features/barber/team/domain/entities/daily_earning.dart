import 'package:equatable/equatable.dart';

class DailyEarning extends Equatable {
  final String date;
  final num amount;
  final int clients;
  final num productAmount;

  const DailyEarning({
    required this.date,
    required this.amount,
    required this.clients,
    this.productAmount = 0,
  });

  @override
  List<Object?> get props => [date, amount, clients, productAmount];
}
