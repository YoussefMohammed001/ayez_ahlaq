class ExternalLinkTarget {
  const ExternalLinkTarget._();

  static String of(Uri uri) {
    final host = uri.host.toLowerCase();

    if (uri.scheme == 'tel') return 'phone';
    if (uri.scheme == 'mailto') return 'email';
    if (host.contains('wa.me') || host.contains('whatsapp')) return 'whatsapp';
    if (uri.scheme == 'geo' ||
        host.contains('maps') ||
        uri.path.toLowerCase().contains('/maps') ||
        uri.scheme.contains('maps')) {
      return 'maps';
    }
    return 'web';
  }
}
