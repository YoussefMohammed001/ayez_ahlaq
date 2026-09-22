import '../../domain/entities/unresolved_bookings_page.dart';
import 'booking_model.dart';

class UnresolvedBookingsPageModel extends UnresolvedBookingsPage {
  const UnresolvedBookingsPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
  });

  factory UnresolvedBookingsPageModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List?) ?? const [];
    return UnresolvedBookingsPageModel(
      content: content
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      size: (json['size'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
