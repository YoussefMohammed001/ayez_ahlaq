import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final directory = Platform.environment['SHOTS_DIR'] ?? 'build/shots';
  await Directory(directory).create(recursive: true);

  await integrationDriver(
    onScreenshot: (name, bytes, [args]) async {
      await File('$directory/$name.png').writeAsBytes(bytes);
      return true;
    },
  );
}
