import '../../domain/entities/sales_page.dart';
import 'sale_model.dart';

class SalesPageModel extends SalesPage {
  const SalesPageModel({
    required super.sales,
    required super.page,
    required super.totalPages,
  });

  factory SalesPageModel.fromJson(Map<String, dynamic> json) {
    return SalesPageModel(
      sales: (json['content'] as List<dynamic>? ?? [])
          .map((e) => SaleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
