import 'bootstrap.dart';
import 'env/flavor.dart';
import 'firebase_options_dev.dart';

void main() => bootstrap(Flavor.dev, DefaultFirebaseOptions.currentPlatform);
