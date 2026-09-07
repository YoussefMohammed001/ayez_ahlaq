import 'package:equatable/equatable.dart';

class MemberClient extends Equatable {
  final String code;
  final String customerName;
  final String customerPhone;
  final String bookingDate;
  final String slotTime;
  final String serviceLabel;
  final String? styleName;
  final int totalPrice;

  const MemberClient({
    required this.code,
    required this.customerName,
    required this.customerPhone,
    required this.bookingDate,
    required this.slotTime,
    required this.serviceLabel,
    this.styleName,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
    code,
    customerName,
    customerPhone,
    bookingDate,
    slotTime,
    serviceLabel,
    styleName,
    totalPrice,
  ];
}
