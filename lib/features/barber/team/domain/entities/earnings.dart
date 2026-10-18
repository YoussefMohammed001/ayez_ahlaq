import 'package:equatable/equatable.dart';
import 'daily_earning.dart';

class Earnings extends Equatable {
  final num today;
  final num last7Days;
  final num thisMonth;
  final int clientsToday;
  final int clientsLast7Days;
  final int clientsThisMonth;
  final num avgTicket;
  final num supplierSpendThisMonth;
  final num netThisMonth;
  final num productsToday;
  final num productsLast7Days;
  final num productsThisMonth;
  final int productOrdersThisMonth;
  final num totalThisMonth;
  final num tillAddedThisMonth;
  final num tillSubtractedThisMonth;
  final List<DailyEarning> dailyLast7;

  const Earnings({
    required this.today,
    required this.last7Days,
    required this.thisMonth,
    required this.clientsToday,
    this.clientsLast7Days = 0,
    required this.clientsThisMonth,
    required this.avgTicket,
    required this.supplierSpendThisMonth,
    required this.netThisMonth,
    this.productsToday = 0,
    this.productsLast7Days = 0,
    this.productsThisMonth = 0,
    this.productOrdersThisMonth = 0,
    this.totalThisMonth = 0,
    this.tillAddedThisMonth = 0,
    this.tillSubtractedThisMonth = 0,
    required this.dailyLast7,
  });

  const Earnings.empty()
    : today = 0,
      last7Days = 0,
      thisMonth = 0,
      clientsToday = 0,
      clientsLast7Days = 0,
      clientsThisMonth = 0,
      avgTicket = 0,
      supplierSpendThisMonth = 0,
      netThisMonth = 0,
      productsToday = 0,
      productsLast7Days = 0,
      productsThisMonth = 0,
      productOrdersThisMonth = 0,
      totalThisMonth = 0,
      tillAddedThisMonth = 0,
      tillSubtractedThisMonth = 0,
      dailyLast7 = const [];

  @override
  List<Object?> get props => [
    today,
    last7Days,
    thisMonth,
    clientsToday,
    clientsLast7Days,
    clientsThisMonth,
    avgTicket,
    supplierSpendThisMonth,
    netThisMonth,
    productsToday,
    productsLast7Days,
    productsThisMonth,
    productOrdersThisMonth,
    totalThisMonth,
    tillAddedThisMonth,
    tillSubtractedThisMonth,
    dailyLast7,
  ];
}
