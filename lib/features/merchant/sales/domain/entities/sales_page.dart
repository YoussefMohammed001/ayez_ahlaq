import 'package:equatable/equatable.dart';
import 'sale.dart';

class SalesPage extends Equatable {
  final List<Sale> sales;
  final int page;
  final int totalPages;

  const SalesPage({
    required this.sales,
    required this.page,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [sales, page, totalPages];
}
