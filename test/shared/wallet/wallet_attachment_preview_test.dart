import 'dart:convert';
import 'dart:io';

import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/wallet/presentation/widgets/wallet_attachment_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late File image;

  setUp(() {
    image = File('${Directory.systemTemp.path}/wallet_preview_test.png')
      ..writeAsBytesSync(base64Decode(_pngBase64));
  });

  tearDown(() {
    if (image.existsSync()) image.deleteSync();
  });

  Future<void> pumpPreview(WidgetTester tester) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(402, 874),
        builder: (_, __) => MaterialApp(
          locale: const Locale('en'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: Scaffold(
            body: WalletAttachmentPreview(filePath: image.path),
          ),
        ),
      ),
    );
  }

  testWidgets('shows the picked image and a hint to open it', (tester) async {
    await pumpPreview(tester);

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Tap to view the full image'), findsOneWidget);
  });

  testWidgets('tapping opens the image full screen and it can be closed', (
    tester,
  ) async {
    await pumpPreview(tester);

    await tester.tap(find.byType(Image));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsNothing);
  });
}
