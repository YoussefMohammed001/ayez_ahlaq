import '../../domain/entities/sale.dart';
import '../../domain/entities/sale_item.dart';
import '../../domain/entities/sale_status.dart';

class SaleModel extends Sale {
  const SaleModel({
    required super.id,
    required super.code,
    required super.subtotal,
    required super.discount,
    required super.total,
    required super.status,
    required super.items,
    super.soldByMemberId,
    super.soldByName,
    super.customerName,
    super.customerPhone,
    super.paymentMethod,
    super.note,
    super.createdAt,
    super.cancelledAt,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      soldByMemberId: (json['soldByMemberId'] as num?)?.toInt(),
      soldByName: json['soldByName'] as String?,
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      status: SaleStatus.fromApi(json['status'] as String?),
      note: json['note'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      cancelledAt: DateTime.tryParse(json['cancelledAt'] as String? ?? ''),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => _itemFrom(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static SaleItem _itemFrom(Map<String, dynamic> json) {
    return SaleItem(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toDouble() ?? 0,
    );
  }
}
