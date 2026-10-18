import 'package:equatable/equatable.dart';

class StoreMerchantPhone extends Equatable {
  final String phoneNumber;
  final String? label;

  const StoreMerchantPhone({required this.phoneNumber, this.label});

  @override
  List<Object?> get props => [phoneNumber, label];
}
