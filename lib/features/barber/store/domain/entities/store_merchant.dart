import 'package:equatable/equatable.dart';

class StoreMerchant extends Equatable {
  final int id;
  final String businessName;
  final String phoneNumber;
  final double rating;
  final int ratingCount;
  final int productCount;

  const StoreMerchant({
    required this.id,
    required this.businessName,
    required this.phoneNumber,
    required this.rating,
    required this.ratingCount,
    required this.productCount,
  });

  @override
  List<Object?> get props => [id, businessName, phoneNumber, rating, ratingCount, productCount];
}
