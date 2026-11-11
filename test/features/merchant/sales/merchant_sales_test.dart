import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/merchant/products/domain/entities/merchant_product.dart';
import 'package:ayez_ahlaq/features/merchant/products/domain/entities/product_image_source.dart';
import 'package:ayez_ahlaq/features/merchant/sales/data/apis/merchant_sales_api.dart';
import 'package:ayez_ahlaq/features/merchant/sales/data/repos/merchant_sales_repo.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale_draft.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale_line.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/entities/sale_status.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/use_cases/cancel_sale_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/use_cases/create_sale_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/use_cases/get_sale_payment_methods_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/sales/domain/use_cases/get_sales_use_case.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/helpers/sale_totals.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/manager/new_sale_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/sales/presentation/manager/sales_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

const _owner = {
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
  'status': 'DONE',
  'note': 'walk-in test',
  'createdAt': '2026-11-11T10:37:44.584044',
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

const _bySub = {
  'id': 7,
  'code': 'MS-000007',
  'soldByMemberId': 4000014,
  'soldByName': 'Sub Test',
  'customerName': 'Sub customer',
  'customerPhone': null,
  'paymentMethod': 'WALLET',
  'subtotal': 40,
  'discount': 0,
  'total': 40,
  'status': 'CANCELLED',
  'note': null,
  'createdAt': '2026-11-11T10:38:17',
  'cancelledAt': '2026-11-11T10:38:20.910233381',
  'items': [],
};

class _FakeApi implements MerchantSalesApi {
  Map<String, dynamic>? createBody;
  final pages = <int>[];
  int totalPages = 2;

  @override
  Future<Either<Failure, dynamic>> createSale(Map<String, dynamic> body) async {
    createBody = body;
    return const Right({'data': _owner});
  }

  @override
  Future<Either<Failure, dynamic>> getSales({
    required int page,
    required int size,
  }) async {
    pages.add(page);
    return Right({
      'data': {
        'content': [page == 0 ? _owner : _bySub],
        'page': page,
        'size': size,
        'totalElements': 2,
        'totalPages': totalPages,
      },
    });
  }

  @override
  Future<Either<Failure, dynamic>> cancelSale(int id) async => Right({
    'data': {..._owner, 'status': 'CANCELLED'},
  });

  @override
  Future<Either<Failure, dynamic>> getPaymentMethods() async => const Right({
    'data': [
      {'code': 'WALLET', 'label': 'المحفظة', 'enabled': true, 'sortOrder': 1},
      {'code': 'CASH', 'label': 'الدفع نقدًا', 'enabled': true, 'sortOrder': 2},
      {'code': 'CARD', 'label': 'بطاقة', 'enabled': false, 'sortOrder': 3},
    ],
  });
}

MerchantProduct _product(int id, int price, {int stock = 10}) =>
    MerchantProduct(
      id: id,
      name: 'p$id',
      price: price,
      effectivePrice: price - 5,
      minOrderQty: 6,
      active: true,
      totalStock: stock,
      imageSource: ProductImageSource.values.first,
      imageIds: const [],
    );

SalesCubit _salesCubit(_FakeApi api) {
  final repo = MerchantSalesRepo(api);
  return SalesCubit(GetSalesUseCase(repo), CancelSaleUseCase(repo));
}

NewSaleCubit _newSaleCubit(_FakeApi api) {
  final repo = MerchantSalesRepo(api);
  return NewSaleCubit(
    CreateSaleUseCase(repo),
    GetSalePaymentMethodsUseCase(repo),
  );
}

void main() {
  group('sale responses from dev', () {
    test('an owner sale has no seller and keeps its items', () async {
      final page = (await MerchantSalesRepo(_FakeApi()).getSales(
        page: 0,
        size: 20,
      )).getOrElse(() => throw StateError('failed'));
      final sale = page.sales.single;

      expect(sale.code, 'MS-000005');
      expect(sale.soldByMember, isFalse);
      expect(sale.total, 110);
      expect(sale.discount, 10);
      expect(sale.status, SaleStatus.done);
      expect(sale.items.single.productName, 'prod');
      expect(sale.items.single.lineTotal, 120);
      expect(sale.createdAt, isNotNull);
      expect(page.hasMore, isTrue);
    });

    test('a cancelled sale made by a member is recognised', () async {
      final page = (await MerchantSalesRepo(_FakeApi()).getSales(
        page: 1,
        size: 20,
      )).getOrElse(() => throw StateError('failed'));
      final sale = page.sales.single;

      expect(sale.soldByMember, isTrue);
      expect(sale.soldByName, 'Sub Test');
      expect(sale.isCancelled, isTrue);
      expect(sale.cancelledAt, isNotNull);
      expect(sale.customerPhone, isNull);
    });

    test('only enabled payment methods are offered', () async {
      final methods = (await MerchantSalesRepo(
        _FakeApi(),
      ).getPaymentMethods()).getOrElse(() => throw StateError('failed'));

      expect(methods.map((m) => m.code), ['WALLET', 'CASH']);
    });
  });

  group('creating a sale', () {
    test('sends only what was filled and always the discount', () async {
      final api = _FakeApi();

      await MerchantSalesRepo(api).createSale(
        const SaleDraft(lines: [SaleLine(productId: 29, quantity: 2)]),
      );

      expect(api.createBody, {
        'discount': 0.0,
        'items': [
          {'productId': 29, 'quantity': 2},
        ],
      });
    });

    test('sends the customer, payment method, discount and note', () async {
      final api = _FakeApi();

      await MerchantSalesRepo(api).createSale(
        const SaleDraft(
          lines: [SaleLine(productId: 1, quantity: 1)],
          customerName: 'Ali',
          customerPhone: '01012345678',
          paymentMethod: 'CASH',
          discount: 10,
          note: 'walk-in',
        ),
      );

      expect(api.createBody, {
        'customerName': 'Ali',
        'customerPhone': '01012345678',
        'paymentMethod': 'CASH',
        'note': 'walk-in',
        'discount': 10.0,
        'items': [
          {'productId': 1, 'quantity': 1},
        ],
      });
    });
  });

  group('SaleTotals', () {
    test('uses the base price, like the server, not the discounted one', () {
      final totals = SaleTotals.of(
        products: [_product(1, 120), _product(2, 20)],
        quantities: const {1: 1, 2: 3},
        discount: 10,
      );

      expect(totals.subtotal, 180);
      expect(totals.total, 170);
      expect(totals.discountTooHigh, isFalse);
    });

    test('a discount above the subtotal is flagged', () {
      final totals = SaleTotals.of(
        products: [_product(1, 120)],
        quantities: const {1: 1},
        discount: 121,
      );

      expect(totals.discountTooHigh, isTrue);
    });

    test('products that are not in the basket cost nothing', () {
      final totals = SaleTotals.of(
        products: [_product(1, 120)],
        quantities: const {},
        discount: 0,
      );

      expect(totals.subtotal, 0);
      expect(totals.total, 0);
    });
  });

  group('SalesCubit', () {
    test('loads the first page and appends the next', () async {
      final api = _FakeApi();
      final cubit = _salesCubit(api);

      await cubit.load();
      await cubit.loadMore();
      await cubit.loadMore();

      expect(cubit.state.sales.map((s) => s.id), [5, 7]);
      expect(cubit.state.hasMore, isFalse);
      expect(api.pages, [0, 1]);
    });

    test('cancelling replaces the sale in the list', () async {
      final cubit = _salesCubit(_FakeApi());
      await cubit.load();

      final cancelled = await cubit.cancel(5);

      expect(cancelled?.isCancelled, isTrue);
      expect(cubit.state.sales.first.isCancelled, isTrue);
      expect(cubit.state.isSubmitting, isFalse);
    });
  });

  group('NewSaleCubit', () {
    test('quantities are added, changed and removed at zero', () {
      final cubit = _newSaleCubit(_FakeApi());

      cubit.setQuantity(29, 2);
      cubit.setQuantity(43, 1);
      cubit.setQuantity(29, 3);
      expect(cubit.state.quantities, {29: 3, 43: 1});

      cubit.setQuantity(43, 0);
      expect(cubit.state.quantities, {29: 3});
      expect(cubit.state.hasItems, isTrue);

      cubit.setQuantity(29, 0);
      expect(cubit.state.hasItems, isFalse);
    });

    test('tapping the chosen payment method again clears it', () {
      final cubit = _newSaleCubit(_FakeApi());

      cubit.selectMethod('CASH');
      expect(cubit.state.paymentMethod, 'CASH');

      cubit.selectMethod('WALLET');
      expect(cubit.state.paymentMethod, 'WALLET');

      cubit.selectMethod('WALLET');
      expect(cubit.state.paymentMethod, isNull);
    });

    test('submit sends the basket and the chosen method', () async {
      final api = _FakeApi();
      final cubit = _newSaleCubit(api);
      await cubit.loadMethods();
      cubit.setQuantity(29, 2);
      cubit.selectMethod('CASH');

      final sale = await cubit.submit(customerName: 'Ali', discount: 5);

      expect(sale?.code, 'MS-000005');
      expect(api.createBody?['paymentMethod'], 'CASH');
      expect(api.createBody?['items'], [
        {'productId': 29, 'quantity': 2},
      ]);
      expect(cubit.state.methods.length, 2);
      expect(cubit.state.isSubmitting, isFalse);
    });
  });
}
