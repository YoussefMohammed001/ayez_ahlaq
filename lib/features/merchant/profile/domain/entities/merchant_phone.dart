import 'package:equatable/equatable.dart';

class MerchantPhone extends Equatable {
  final int id;
  final String phoneNumber;
  final String? countryCode;
  final String? label;

  const MerchantPhone({
    required this.id,
    required this.phoneNumber,
    this.countryCode,
    this.label,
  });

  @override
  List<Object?> get props => [id, phoneNumber, countryCode, label];
}
