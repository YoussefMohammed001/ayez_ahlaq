import 'package:equatable/equatable.dart';
import 'store_feed_product.dart';

class StoreFeedPage extends Equatable {
  final List<StoreFeedProduct> items;
  final String? nextCursor;

  const StoreFeedPage({required this.items, this.nextCursor});

  bool get hasMore => nextCursor != null;

  @override
  List<Object?> get props => [items, nextCursor];
}
