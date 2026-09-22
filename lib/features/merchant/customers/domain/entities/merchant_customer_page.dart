import 'package:equatable/equatable.dart';
import 'merchant_customer.dart';

class MerchantCustomerPage extends Equatable {
  final List<MerchantCustomer> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  const MerchantCustomerPage({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [content, page, size, totalElements, totalPages];
}
