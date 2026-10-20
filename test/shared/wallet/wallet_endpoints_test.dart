import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/network/dio/network_service.dart';
import 'package:ayez_ahlaq/shared/wallet/data/apis/wallet_api.dart';
import 'package:ayez_ahlaq/shared/wallet/data/apis/wallet_requests_api.dart';
import 'package:ayez_ahlaq/shared/wallet/data/wallet_endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class RecordingNetworkService extends Fake implements NetworkService {
  final requested = <String>[];

  @override
  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool skipClientHeader = false,
  }) async {
    requested.add(endPoint);
    return const Right(<String, dynamic>{});
  }
}

void main() {
  const roles = {
    'barber': WalletEndpoints.barber,
    'customer': WalletEndpoints.customer,
    'merchant': WalletEndpoints.merchant,
  };

  roles.forEach((role, endpoints) {
    test('$role wallet calls only $role endpoints', () async {
      final network = RecordingNetworkService();

      await WalletApi(network, endpoints).getWallet();
      final requests = WalletRequestsApi(network, endpoints);
      await requests.getTransferAccounts();
      await requests.getWithdrawMethods();
      await requests.getWalletRequests(page: 0, size: 10);
      await requests.getWalletRequestDetail(7);

      expect(network.requested, hasLength(5));
      expect(network.requested.every((e) => e.startsWith('$role/')), isTrue);
      expect(network.requested.last, endsWith('/7'));
    });
  });
}
