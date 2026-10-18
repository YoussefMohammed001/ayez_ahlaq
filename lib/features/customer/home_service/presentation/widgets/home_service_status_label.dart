import '../../../../../generated/l10n.dart';
import '../../domain/entities/home_service_request_status.dart';

extension HomeServiceStatusLabel on HomeServiceRequestStatus {
  String get label => switch (this) {
    HomeServiceRequestStatus.pending => S().homeServiceStatusPending,
    HomeServiceRequestStatus.accepted => S().homeServiceStatusAccepted,
    HomeServiceRequestStatus.onTheWay => S().homeServiceStatusOnTheWay,
    HomeServiceRequestStatus.done => S().homeServiceStatusDone,
    HomeServiceRequestStatus.rejected => S().homeServiceStatusRejected,
    HomeServiceRequestStatus.cancelled => S().homeServiceStatusCancelled,
    HomeServiceRequestStatus.expired => S().homeServiceStatusExpired,
  };
}
