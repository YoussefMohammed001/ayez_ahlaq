import 'shop.dart';

class ShopsSearch {
  const ShopsSearch._();

  static List<Shop> filter(List<Shop> shops, String query) {
    final words = _normalize(query).split(' ').where((w) => w.isNotEmpty);
    if (words.isEmpty) return shops;

    return shops.where((shop) {
      final haystack = _normalize('${shop.name} ${shop.address ?? ''}');
      return words.every(haystack.contains);
    }).toList();
  }

  static String _normalize(String text) => text
      .toLowerCase()
      .replaceAll(RegExp('[ً-ٟـ]'), '')
      .replaceAll(RegExp('[أإآ]'), 'ا')
      .replaceAll('ى', 'ي')
      .replaceAll('ة', 'ه')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
