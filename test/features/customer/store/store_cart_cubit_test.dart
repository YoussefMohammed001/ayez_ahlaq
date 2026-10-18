import 'dart:async';

import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/entities/store_cart.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/repos/i_customer_store_repo.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/use_cases/checkout_cart_use_case.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/use_cases/get_cart_use_case.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/use_cases/get_storefront_use_case.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/use_cases/put_cart_use_case.dart';
import 'package:ayez_ahlaq/features/customer/store/presentation/manager/store_cart_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeStoreRepo extends Fake implements ICustomerStoreRepo {
  final sentCarts = <Map<int, int>>[];
  final release = Completer<void>();

  @override
  Future<Either<Failure, StoreCart>> putCart(Map<int, int> quantities) async {
    sentCarts.add(quantities);
    await release.future;
    return const Right(StoreCart.empty);
  }
}

void main() {
  test('a quantity change while the cart is updating is not sent', () async {
    final repo = FakeStoreRepo();
    final cubit = StoreCartCubit(
      GetStorefrontUseCase(repo),
      GetCartUseCase(repo),
      PutCartUseCase(repo),
      CheckoutCartUseCase(repo),
    );

    final first = cubit.setQuantity(1, 1, 2);
    await cubit.setQuantity(1, 1, 3);
    repo.release.complete();
    await first;

    expect(repo.sentCarts, [
      {1: 2},
    ]);
    expect(cubit.state.isUpdatingCart, isFalse);
  });
}
