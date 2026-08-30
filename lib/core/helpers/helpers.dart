import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ayez_ahlaq/core/helpers/safe_print.dart';
import 'package:url_launcher/url_launcher.dart';
import '/core/routes/app_routes.dart';
import '/generated/l10n.dart';

const List<String> _allowedFileExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

class Helpers {
  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) return File(image.path);
    return null;
  }

  static Future<List<File>> getImages() async {
    final picker = ImagePicker();
    final result = await picker.pickMultiImage();
    if (result.isNotEmpty) return result.map((e) => File(e.path)).toList();
    return [];
  }

  static Future<File?> getImageFromCameraOrDevice() async {
    final picker = ImagePicker();
    File? image;

    await showCupertinoModalPopup(
      context: rootNavigatorKey.currentContext!,
      builder: (context) => CupertinoActionSheet(
        title: Text(S().choose_image_source),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              final picked = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (picked != null) image = File(picked.path);
              Navigator.of(context).pop();
            },
            child: Text(S().gallery),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final picked = await picker.pickImage(source: ImageSource.camera);
              if (picked != null) image = File(picked.path);
              Navigator.of(context).pop();
            },
            child: Text(S().camera),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S().cancel),
        ),
      ),
    );

    return image;
  }

  static Future<List<File>> pickLimitedImagesWithMaxSize({
    required int maxCount,
    int maxSizeInMB = 5,
  }) async {
    final picker = ImagePicker();
    final result = await picker.pickMultiImage();
    if (result.isEmpty) return [];

    final List<File> validFiles = [];
    for (final xfile in result) {
      if (validFiles.length >= maxCount) break;
      final file = File(xfile.path);
      final bytes = await file.length();
      if (bytes / (1024 * 1024) <= maxSizeInMB) validFiles.add(file);
    }
    return validFiles;
  }

  static Future<File?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  static bool _isPickingFiles = false;

  static Future<File?> pickAnyFiles() async {
    if (_isPickingFiles) return null;
    _isPickingFiles = true;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedFileExtensions,
        allowMultiple: false,
      );
      if (result == null || result.files.single.path == null) return null;
      final file = File(result.files.single.path!);
      final ext = file.path.split('.').last.toLowerCase();
      if (!_allowedFileExtensions.contains(ext)) return null;
      return file;
    } catch (e) {
      safePrint('pickAnyFiles error: $e');
      return null;
    } finally {
      _isPickingFiles = false;
    }
  }

  static String formatNumberWithCommas({required num value}) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  static String convertToEnglishNumbers(String input) {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    final containsArabic = input.split('').any((ch) => arabic.contains(ch));
    if (containsArabic) {
      for (int i = 0; i < arabic.length; i++) {
        input = input.replaceAll(arabic[i], english[i]);
      }
    }
    return input;
  }
}

class LauncherHelper {
  static void launchURL({required String url}) async {
    if (!url.startsWith('https')) url = 'https://$url';
    await launchUrl(Uri.parse(url));
  }

  static void launchWhatsApp(String phone) async {
    final message = S().welcome_message;
    if (phone.startsWith('00966')) phone = phone.substring(5);
    final url = 'whatsapp://send?phone=+966$phone&text=$message';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw S().whatsapp_error;
    }
  }

  static void launchYoutube({required String url}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw '${S().could_not_launch} $url';
    }
  }

  static Future<void> launchTwitter(String userName) async {
    final native = Uri.parse('twitter://user?screen_name=$userName');
    final web = Uri.parse('https://twitter.com/$userName');
    try {
      if (await canLaunchUrl(native)) {
        await launchUrl(native);
      } else if (await canLaunchUrl(web)) {
        await launchUrl(web);
      } else {
        throw S().twitter_error;
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchInstagram(String userName) async {
    final native = Uri.parse('instagram://user?username=$userName');
    final web = Uri.parse('https://www.instagram.com/$userName');
    try {
      if (await canLaunchUrl(native)) {
        await launchUrl(native);
      } else if (await canLaunchUrl(web)) {
        await launchUrl(web);
      } else {
        throw S().instagram_error;
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void launchFacebook(String userName) async {
    final native = Uri.parse(
      'fb://facewebmodal/f?href=https://www.facebook.com/$userName',
    );
    final web = Uri.parse('https://www.facebook.com/$userName');
    if (await canLaunchUrl(native)) {
      await launchUrl(native);
    } else if (await canLaunchUrl(web)) {
      await launchUrl(web);
    } else {
      throw '${S().could_not_launch} $web';
    }
  }

  static Future<void> launchSnapchat(String userName) async {
    final native = Uri.parse('snapchat://add/$userName');
    final web = Uri.parse('https://www.snapchat.com/add/$userName');
    try {
      if (await canLaunchUrl(native)) {
        await launchUrl(native);
      } else if (await canLaunchUrl(web)) {
        await launchUrl(web);
      } else {
        throw S().snapchat_error;
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchTikTok(String userName) async {
    final web = Uri.parse('https://www.tiktok.com/@$userName');
    final native = Uri.parse('com.zhiliaoapp.musically://user?u=$userName');
    try {
      if (await canLaunchUrl(native)) {
        await launchUrl(native);
      } else if (await canLaunchUrl(web)) {
        await launchUrl(web);
      } else {
        throw S().tiktok_error;
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchMapsLocation(
    double latitude,
    double longitude, {
    String? label,
  }) async {
    final encoded = Uri.encodeComponent(label ?? '');
    final google = Uri.parse(
      'geo:$latitude,$longitude?q=$latitude,$longitude($encoded)',
    );
    final web = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
    if (await canLaunchUrl(google)) {
      await launchUrl(google);
    } else {
      await launchUrl(web, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> launchMapsNavigation(
    double latitude,
    double longitude,
  ) async {
    final google = Uri.parse('google.navigation:q=$latitude,$longitude&mode=d');
    final web = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving',
    );
    if (await canLaunchUrl(google)) {
      await launchUrl(google);
    } else {
      await launchUrl(web, mode: LaunchMode.externalApplication);
    }
  }

  static void callPhone({phone}) async {
    await launchUrl(Uri.parse('tel:$phone'));
  }

  static void sendMail(mail) async {
    await launchUrl(Uri.parse('mailto:$mail'));
  }
}
