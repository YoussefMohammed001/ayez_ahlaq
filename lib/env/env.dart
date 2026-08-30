import 'flavor.dart';

bool isDevEnvironment() => currentFlavor == Flavor.dev;
bool isProdEnvironment() => currentFlavor == Flavor.prod;
