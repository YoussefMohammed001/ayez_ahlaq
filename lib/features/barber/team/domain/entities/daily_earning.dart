import 'package:equatable/equatable.dart';

class DailyEarning extends Equatable {
  final String date;
  final num amount;
  final int clients;

  const DailyEarning({
    required this.date,
    required this.amount,
    required this.clients,
  });

  @override
  List<Object?> get props => [date, amount, clients];
}
