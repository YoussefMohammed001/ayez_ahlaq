import 'package:url_launcher/url_launcher.dart';
import '../analytics/app_analytics.dart';
import '../analytics/external_link_target.dart';
import '../di/sl.dart';
import 'alerts.dart';

class ExternalUrlLauncher {
  const ExternalUrlLauncher._();

  static Future<void> open(String url, {required String errorMessage}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      sl<AppAnalytics>().externalLinkOpened(ExternalLinkTarget.of(uri));
    } else {
      showError(errorMessage);
    }
  }
}
