import 'package:ayez_ahlaq/shared/wallet/data/models/wallet_request_model.dart';
import 'package:ayez_ahlaq/shared/wallet/domain/entities/wallet_request.dart';
import 'package:ayez_ahlaq/shared/wallet/domain/entities/wallet_request_status.dart';
import 'package:ayez_ahlaq/shared/wallet/domain/entities/wallet_request_type.dart';
import 'package:ayez_ahlaq/shared/wallet/presentation/manager/wallet_requests_state.dart';
import 'package:flutter_test/flutter_test.dart';

WalletRequestModel model(int id, WalletRequestStatus status) =>
    WalletRequestModel(
      id: id,
      code: 'WR-$id',
      ownerType: 'BARBER',
      ownerId: 1,
      ownerName: 'owner',
      ownerPhone: '01000000000',
      type: WalletRequestType.deposit,
      amount: 100,
      hasAttachment: false,
      status: status,
      createdAt: DateTime(2026, 10, 20),
    );

void main() {
  test('a list of API models still resolves the live request', () {
    final fromApi = [model(1, WalletRequestStatus.pending)];
    final state = WalletRequestsState(requests: fromApi);
    final opened = model(1, WalletRequestStatus.pending);
    final WalletRequest stale = opened;

    final current = state.requestOr(1, stale);

    expect(identical(current, fromApi.first), isTrue);
  });

  test('falls back to the opened request when the list does not have it', () {
    final state = WalletRequestsState(
      requests: [model(1, WalletRequestStatus.pending)],
    );
    final opened = model(9, WalletRequestStatus.approved);

    expect(state.requestOr(9, opened), same(opened));
  });
}
