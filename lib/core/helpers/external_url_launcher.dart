import 'package:url_launcher/url_launcher.dart';
import 'alerts.dart';

class ExternalUrlLauncher {
  const ExternalUrlLauncher._();

  static Future<void> open(String url, {required String errorMessage}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      showError(errorMessage);
    }
  }
}
