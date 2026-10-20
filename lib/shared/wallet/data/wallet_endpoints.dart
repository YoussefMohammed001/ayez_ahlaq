import '../../../core/network/constants/endpoints.dart';

class WalletEndpoints {
  final String wallet;
  final String transferAccount;
  final String withdrawMethods;
  final String requests;
  final String Function(int id) requestById;
  final String Function(int id) requestAttachment;
  final String Function(int id) requestCancel;

  const WalletEndpoints({
    required this.wallet,
    required this.transferAccount,
    required this.withdrawMethods,
    required this.requests,
    required this.requestById,
    required this.requestAttachment,
    required this.requestCancel,
  });

  static const barber = WalletEndpoints(
    wallet: EndPoints.barberWallet,
    transferAccount: EndPoints.barberTransferAccount,
    withdrawMethods: EndPoints.barberWithdrawMethods,
    requests: EndPoints.barberWalletRequests,
    requestById: EndPoints.barberWalletRequestById,
    requestAttachment: EndPoints.barberWalletRequestAttachment,
    requestCancel: EndPoints.barberWalletRequestCancel,
  );

  static const customer = WalletEndpoints(
    wallet: EndPoints.customerWallet,
    transferAccount: EndPoints.customerTransferAccount,
    withdrawMethods: EndPoints.customerWithdrawMethods,
    requests: EndPoints.customerWalletRequests,
    requestById: EndPoints.customerWalletRequestById,
    requestAttachment: EndPoints.customerWalletRequestAttachment,
    requestCancel: EndPoints.customerWalletRequestCancel,
  );

  static const merchant = WalletEndpoints(
    wallet: EndPoints.merchantWallet,
    transferAccount: EndPoints.merchantTransferAccount,
    withdrawMethods: EndPoints.merchantWithdrawMethods,
    requests: EndPoints.merchantWalletRequests,
    requestById: EndPoints.merchantWalletRequestById,
    requestAttachment: EndPoints.merchantWalletRequestAttachment,
    requestCancel: EndPoints.merchantWalletRequestCancel,
  );
}
