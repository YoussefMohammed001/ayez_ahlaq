import 'package:equatable/equatable.dart';

class PendingMerchantRating extends Equatable {
  final int orderId;
  final String code;
  final String merchantName;

  const PendingMerchantRating({
    required this.orderId,
    required this.code,
    required this.merchantName,
  });

  @override
  List<Object?> get props => [orderId, code, merchantName];
}
