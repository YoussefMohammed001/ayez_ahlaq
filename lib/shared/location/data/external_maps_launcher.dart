import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import '../domain/entities/geo_point.dart';

class ExternalMapsLauncher {
  Future<bool> openInGoogleMaps(GeoPoint point) async {
    final coordinates = '${point.latitude},${point.longitude}';

    if (Platform.isIOS) {
      final appUri = Uri.parse(
        'comgooglemaps://?q=$coordinates&center=$coordinates',
      );
      if (await canLaunchUrl(appUri)) return launchUrl(appUri);
    }

    final webUri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': coordinates,
    });
    return launchUrl(webUri, mode: LaunchMode.externalApplication);
  }
}
