import 'package:equatable/equatable.dart';

class BarberReview extends Equatable {
  final int id;
  final int stars;
  final String? note;
  final String customerName;
  final int bookingId;
  final DateTime? createdAt;

  const BarberReview({
    required this.id,
    required this.stars,
    required this.customerName,
    required this.bookingId,
    this.note,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, stars, note, customerName, bookingId, createdAt];
}
