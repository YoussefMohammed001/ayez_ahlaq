import 'package:ayez_ahlaq/core/di/modules/barber_wallet_di.dart';
import 'package:ayez_ahlaq/core/di/modules/customer_wallet_di.dart';
import 'package:ayez_ahlaq/core/di/modules/merchant_wallet_di.dart';
import 'package:ayez_ahlaq/core/di/sl.dart';
import 'package:ayez_ahlaq/core/network/dio/network_service.dart';
import 'package:ayez_ahlaq/features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
import 'package:ayez_ahlaq/features/barber/wallet/presentation/manager/barber_wallet_requests_cubit.dart';
import 'package:ayez_ahlaq/features/customer/wallet/presentation/manager/customer_wallet_cubit.dart';
import 'package:ayez_ahlaq/features/customer/wallet/presentation/manager/customer_wallet_requests_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/wallet/presentation/manager/merchant_wallet_cubit.dart';
import 'package:ayez_ahlaq/features/merchant/wallet/presentation/manager/merchant_wallet_requests_cubit.dart';
import 'package:ayez_ahlaq/shared/wallet/presentation/manager/create_wallet_request_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNetworkService extends Fake implements NetworkService {}

void main() {
  setUp(() async {
    await sl.reset();
    sl.registerSingleton<NetworkService>(FakeNetworkService());
    registerBarberWallet();
    registerBarberWalletRequests();
    registerCustomerWallet();
    registerCustomerWalletRequests();
    registerMerchantWallet();
    registerMerchantWalletRequests();
  });

  test('every role resolves its wallet cubits', () {
    expect(sl<BarberWalletCubit>(), isA<BarberWalletCubit>());
    expect(sl<BarberWalletRequestsCubit>(), isA<BarberWalletRequestsCubit>());
    expect(sl<CustomerWalletCubit>(), isA<CustomerWalletCubit>());
    expect(
      sl<CustomerWalletRequestsCubit>(),
      isA<CustomerWalletRequestsCubit>(),
    );
    expect(sl<MerchantWalletCubit>(), isA<MerchantWalletCubit>());
    expect(
      sl<MerchantWalletRequestsCubit>(),
      isA<MerchantWalletRequestsCubit>(),
    );
  });

  test('each role gets its own create-request cubit', () {
    final barber = sl<CreateWalletRequestCubit>(instanceName: 'barber');
    final customer = sl<CreateWalletRequestCubit>(instanceName: 'customer');
    final merchant = sl<CreateWalletRequestCubit>(instanceName: 'merchant');

    expect(barber, isNot(same(customer)));
    expect(customer, isNot(same(merchant)));
  });
}
