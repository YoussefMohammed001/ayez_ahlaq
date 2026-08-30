import 'bootstrap.dart';
import 'env/flavor.dart';
import 'firebase_options_prod.dart';

void main() => bootstrap(Flavor.prod, DefaultFirebaseOptions.currentPlatform);
