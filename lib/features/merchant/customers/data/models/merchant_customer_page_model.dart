import '../../domain/entities/merchant_customer_page.dart';
import 'merchant_customer_model.dart';

class MerchantCustomerPageModel extends MerchantCustomerPage {
  const MerchantCustomerPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
  });

  factory MerchantCustomerPageModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List?) ?? const [];
    return MerchantCustomerPageModel(
      content: content
          .map((e) => MerchantCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
