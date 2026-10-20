import '../../../core/routes/route_paths.dart';

class WalletRoutes {
  final String requests;
  final String createRequest;
  final String requestDetail;
  final String requestAttachment;

  const WalletRoutes({
    required this.requests,
    required this.createRequest,
    required this.requestDetail,
    required this.requestAttachment,
  });

  static const barber = WalletRoutes(
    requests: Routes.barberWalletRequestsScreen,
    createRequest: Routes.createBarberWalletRequestScreen,
    requestDetail: Routes.barberWalletRequestDetailScreen,
    requestAttachment: Routes.barberWalletRequestAttachmentScreen,
  );

  static const customer = WalletRoutes(
    requests: Routes.customerWalletRequestsScreen,
    createRequest: Routes.createCustomerWalletRequestScreen,
    requestDetail: Routes.customerWalletRequestDetailScreen,
    requestAttachment: Routes.customerWalletRequestAttachmentScreen,
  );

  static const merchant = WalletRoutes(
    requests: Routes.merchantWalletRequestsScreen,
    createRequest: Routes.createMerchantWalletRequestScreen,
    requestDetail: Routes.merchantWalletRequestDetailScreen,
    requestAttachment: Routes.merchantWalletRequestAttachmentScreen,
  );
}
