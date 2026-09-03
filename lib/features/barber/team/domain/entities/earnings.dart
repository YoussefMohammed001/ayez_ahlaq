import 'package:equatable/equatable.dart';
import 'daily_earning.dart';

class Earnings extends Equatable {
  final num today;
  final num last7Days;
  final num thisMonth;
  final int clientsToday;
  final int clientsThisMonth;
  final num avgTicket;
  final num supplierSpendThisMonth;
  final num netThisMonth;
  final List<DailyEarning> dailyLast7;

  const Earnings({
    required this.today,
    required this.last7Days,
    required this.thisMonth,
    required this.clientsToday,
    required this.clientsThisMonth,
    required this.avgTicket,
    required this.supplierSpendThisMonth,
    required this.netThisMonth,
    required this.dailyLast7,
  });

  const Earnings.empty()
    : today = 0,
      last7Days = 0,
      thisMonth = 0,
      clientsToday = 0,
      clientsThisMonth = 0,
      avgTicket = 0,
      supplierSpendThisMonth = 0,
      netThisMonth = 0,
      dailyLast7 = const [];

  @override
  List<Object?> get props => [
    today,
    last7Days,
    thisMonth,
    clientsToday,
    clientsThisMonth,
    avgTicket,
    supplierSpendThisMonth,
    netThisMonth,
    dailyLast7,
  ];
}
