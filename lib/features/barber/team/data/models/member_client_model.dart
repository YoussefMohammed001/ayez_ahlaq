import '../../domain/entities/member_client.dart';

class MemberClientModel extends MemberClient {
  const MemberClientModel({
    required super.code,
    required super.customerName,
    required super.customerPhone,
    required super.bookingDate,
    required super.slotTime,
    required super.serviceLabel,
    super.styleName,
    required super.totalPrice,
  });

  factory MemberClientModel.fromJson(Map<String, dynamic> json) {
    return MemberClientModel(
      code: json['code'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      bookingDate: json['bookingDate'] as String? ?? '',
      slotTime: json['slotTime'] as String? ?? '',
      serviceLabel: json['serviceLabel'] as String? ?? '',
      styleName: json['styleName'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt() ?? 0,
    );
  }
}
