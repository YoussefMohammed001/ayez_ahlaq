class NotificationReference {
  const NotificationReference._();

  static const Map<String, String> _referenceByTypePrefix = {
    'home_service_broadcast': 'homeServiceBroadcast',
    'home_service': 'homeService',
    'attendance': 'attendance',
    'salary': 'salary',
    'booking': 'booking',
    'store_order': 'productOrder',
    'order': 'productOrder',
    'subscription_request': 'subscriptionRequest',
    'subscription': 'subscription',
    'wallet_request': 'walletRequests',
    'money_item': 'moneyItemOccurrence',
    'money_pin': 'moneyPin',
    'account': 'account',
    'admin_announcement': 'adminAnnouncement',
    'merchant_broadcast': 'merchant',
    'shop_broadcast': 'shop',
    'rating': 'rating',
    'low_stock': 'lowStock',
    'discount_ended': 'discountEnded',
  };

  static String canonical({required String type, String? referenceType}) {
    if (referenceType != null && referenceType.isNotEmpty) {
      return _camelCase(referenceType);
    }
    for (final entry in _referenceByTypePrefix.entries) {
      if (type == entry.key || type.startsWith('${entry.key}_')) {
        return entry.value;
      }
    }
    return _camelCase(type);
  }

  static String _camelCase(String value) {
    final parts = value.split('_');
    return parts.first +
        parts
            .skip(1)
            .map((part) => part.isEmpty ? part : part[0].toUpperCase() + part.substring(1))
            .join();
  }
}
