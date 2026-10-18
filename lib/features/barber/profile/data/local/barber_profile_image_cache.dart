import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class BarberProfileImageCache {
  static const _fileName = 'barber_shop_photo.cache';

  Future<Uint8List?> read() async {
    final file = await _file();
    if (!await file.exists()) return null;

    try {
      return await file.readAsBytes();
    } catch (_) {
      return null;
    }
  }

  Future<void> write(Uint8List bytes) async {
    final file = await _file();
    await file.writeAsBytes(bytes, flush: true);
  }

  Future<void> clear() async {
    final file = await _file();
    if (await file.exists()) await file.delete();
  }

  Future<File> _file() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}/$_fileName');
  }
}
