import '../../domain/entities/store_feed_page.dart';
import 'store_feed_product_model.dart';

class StoreFeedPageModel extends StoreFeedPage {
  const StoreFeedPageModel({required super.items, super.nextCursor});

  factory StoreFeedPageModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List? ?? const [];
    return StoreFeedPageModel(
      items: items
          .map(
            (e) => StoreFeedProductModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      nextCursor: json['nextCursor'] as String?,
    );
  }
}
