import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/place_info.dart';
import 'package:ayez_ahlaq/shared/location/presentation/widgets/map_picker_selected_card.dart';

Widget _host(PlaceInfo place, {bool isResolving = false}) => ScreenUtilInit(
  designSize: const Size(402, 874),
  builder: (_, __) => MaterialApp(
    theme: lightTheme,
    home: Scaffold(
      body: MapPickerSelectedCard(
        place: place,
        isResolving: isResolving,
        isLocating: false,
        onLocateMe: () {},
      ),
    ),
  ),
);

void main() {
  const place = PlaceInfo(
    name: 'شارع عباس العقاد',
    city: 'القاهرة',
    fullAddress: 'شارع عباس العقاد، مدينة نصر',
  );

  testWidgets('shows the name and the full address', (tester) async {
    await tester.pumpWidget(_host(place));

    expect(find.text('شارع عباس العقاد'), findsOneWidget);
    expect(find.textContaining('مدينة نصر'), findsOneWidget);
  });

  testWidgets('adds the city when the address does not mention it', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const PlaceInfo(name: 'س', city: 'الجيزة', fullAddress: 'شارع الهرم'),
      ),
    );

    expect(find.text('شارع الهرم، الجيزة'), findsOneWidget);
  });

  testWidgets('says it is looking for the address and hides the old one', (
    tester,
  ) async {
    await tester.pumpWidget(_host(place, isResolving: true));

    expect(find.text(S().searchingAddress), findsOneWidget);
    expect(find.textContaining('مدينة نصر'), findsNothing);
  });

  testWidgets('falls back to a neutral title when nothing was found', (
    tester,
  ) async {
    await tester.pumpWidget(_host(PlaceInfo.empty));

    expect(find.text(S().unnamedLocation), findsOneWidget);
  });
}
