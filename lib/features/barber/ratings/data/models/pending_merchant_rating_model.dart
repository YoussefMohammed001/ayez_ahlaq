import '../../domain/entities/pending_merchant_rating.dart';

class PendingMerchantRatingModel extends PendingMerchantRating {
  const PendingMerchantRatingModel({
    required super.orderId,
    required super.code,
    required super.merchantName,
  });

  static PendingMerchantRatingModel? fromResponseData(dynamic data) {
    if (data is! Map<String, dynamic>) return null;

    final orderId = data['orderId'] as int?;
    if (orderId == null) return null;

    return PendingMerchantRatingModel(
      orderId: orderId,
      code: data['code'] as String? ?? '',
      merchantName: data['merchantName'] as String? ?? '',
    );
  }
}
