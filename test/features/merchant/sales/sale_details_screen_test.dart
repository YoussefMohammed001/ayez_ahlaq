import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/merchant/sales/data/apis/merchant_sales_api.dart';
import 'package:ayez_ahlaq/features/merchant/sales/data/repos/merchant_sales_repo.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/use_cases/cancel_sale_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/use_cases/get_sales_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/manager/sales_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/pages/sale_details_screen.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> _sale({String status = 'DONE'}) => {
  'id': 5,
  'code': 'MS-000005',
  'soldByMemberId': null,
  'soldByName': null,
  'customerName': 'Street customer',
  'customerPhone': '01012345678',
  'paymentMethod': 'CASH',
  'subtotal': 120,
  'discount': 10,
  'total': 110,
  'status': status,
  'note': 'walk-in test',
  'createdAt': '2026-11-11T10:37:44',
  'cancelledAt': null,
  'items': [
    {
      'productId': 29,
      'productName': 'prod',
      'unitPrice': 120,
      'quantity': 1,
      'lineTotal': 120,
    },
  ],
};

class _FakeApi implements MerchantSalesApi {
  var cancelCalls = 0;
  var status = 'DONE';

  @override
  Future<Either<Failure, dynamic>> getSales({
    required int page,
    required int size,
  }) async => Right({
    'data': {
      'content': [_sale(status: status)],
      'page': 0,
      'size': 20,
      'totalElements': 1,
      'totalPages': 1,
    },
  });

  @override
  Future<Either<Failure, dynamic>> cancelSale(int id) async {
    cancelCalls++;
    status = 'CANCELLED';
    return Right({'data': _sale(status: 'CANCELLED')});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

Future<_FakeApi> _open(WidgetTester tester, {required String kind}) async {
  SharedPreferences.setMockInitialValues({
    PreferencesKeys.merchantAccountKind.name: kind,
  });
  await sl.reset();
  sl.registerSingleton(
    PreferencesStorage(await SharedPreferences.getInstance()),
  );
  tester.view.physicalSize = const Size(1200, 3200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final api = _FakeApi();
  final repo = MerchantSalesRepo(api);
  final cubit = SalesCubit(GetSalesUseCase(repo), CancelSaleUseCase(repo));
  await cubit.load();

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (_, _) => BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          theme: lightTheme,
          home: const SaleDetailsScreen(saleId: 5),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return api;
}

void main() {
  testWidgets('the owner can cancel a completed sale', (tester) async {
    final api = await _open(tester, kind: 'owner');

    expect(find.text(S().cancelSaleTitle), findsOneWidget);

    await tester.tap(find.text(S().cancelSaleTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S().cancelSaleTitle).last);
    await tester.pumpAndSettle();

    expect(api.cancelCalls, 1);
    expect(find.text(S().saleStatusCancelled), findsOneWidget);
    expect(find.text(S().cancelSaleTitle), findsNothing);
  });

  testWidgets('declining the confirmation keeps the sale', (tester) async {
    final api = await _open(tester, kind: 'owner');

    await tester.tap(find.text(S().cancelSaleTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(S().cancel));
    await tester.pumpAndSettle();

    expect(api.cancelCalls, 0);
    expect(find.text(S().saleStatusDone), findsOneWidget);
  });

  testWidgets('a sub-merchant never sees the cancel action', (tester) async {
    await _open(tester, kind: 'subMerchant');

    expect(find.text(S().cancelSaleTitle), findsNothing);
    expect(find.text(S().saleStatusDone), findsOneWidget);
  });

  testWidgets('shows the items and the totals of the sale', (tester) async {
    await _open(tester, kind: 'owner');

    expect(find.text(S().saleItemLine('prod', '1')), findsOneWidget);
    expect(find.text(S().saleTotalRow), findsOneWidget);
    expect(find.text('walk-in test'), findsOneWidget);
  });
}
